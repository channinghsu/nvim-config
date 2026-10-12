return function()
	local vim_path = vim.fn.stdpath("config")
	local extensions = require("telescope").extensions
	local builtins = require("telescope.builtin")
	local prompt_pos = require("telescope.config").values.layout_config.horizontal.prompt_position

	local base_opts = {}

	---Returns current directory and whether it's a Git repo root
	---@return string @Current working directory
	---@return boolean|nil @true if `.git` folder exists here, false if `.git` exists but isn't folder, nil if `.git` missing
	local function get_root_info()
		local cwd = vim.uv.cwd()
		local stat = vim.uv.fs_stat(".git")
		return cwd, stat and stat.type == "directory"
	end

	---Creates a file search function based on backend and context
	---@param fzf_fn string @Name of the fzf-lua function to call (e.g. "files")
	---@param tb_fn function @Telescope builtin function to call (e.g. `builtin.find_files`)
	---@param git_only boolean @Whether to restrict search to git tracked files only
	---@return fun():any @A function that executes the selected search with proper options
	local function file_searcher(fzf_fn, tb_fn, git_only)
		return function()
			local cwd, is_git = get_root_info()
			local opts = vim.deepcopy(base_opts, true)
			if cwd == vim_path then
				opts.no_ignore = true
				return (tb_fn)(opts)
			elseif git_only and is_git then
				return (builtins.git_files)(opts)
			elseif not git_only then
				return (tb_fn)(opts)
			else
				-- fallback
				return (builtins.find_files)(opts)
			end
		end
	end

	---Creates a function that performs a live grep search using the appropriate backend
	---@param fzf_fn string @Name of the fzf-lua grep function to call (e.g. "live_grep")
	---@param tb_fn function @Telescope builtin grep function (e.g. `builtin.grep_string`)
	---@return fun():any @Function that runs the selected grep with proper options
	local function grep_searcher(fzf_fn, tb_fn)
		return function()
			local cwd = vim.uv.cwd()
			local opts = vim.deepcopy(base_opts, true)
			if cwd == vim_path then
				opts = { additional_args = { "--no-ignore" } }
			end
			return (tb_fn)(opts)
		end
	end

	-- Tables of pickers
	local pickers = {
		file = {
			{ "Files", file_searcher("files", builtins.find_files, false) },
			{ "Oldfiles", builtins.oldfiles },
			{ "Buffers", builtins.buffers },
		},
		pattern = {
			{ "Word in project", grep_searcher("live_grep", extensions.live_grep_args.live_grep_args) },
			{ "Word under cursor", grep_searcher("grep_cword", builtins.grep_string) },
		},
		git = {
			{ "Branches", builtins.git_branches },
			{ "Commits", builtins.git_commits },
		},
		dossier = {
			{ "Zoxide", extensions.zoxide.list },
		},
		misc = {
			{
				"Colorschemes",
				function()
					builtins.colorscheme({ enable_preview = true })
				end,
			},
		},
	}

	-- Build collections
	local collections = {}
	for kind, list in pairs(pickers) do
		local init = { initial_tab = 1, tabs = {} }
		for _, entry in ipairs(list) do
			table.insert(init.tabs, { name = entry[1], tele_func = entry[2] })
		end
		collections[kind] = init
	end

	require("search").setup({
		prompt_position = prompt_pos,
		collections = collections,
	})
end
