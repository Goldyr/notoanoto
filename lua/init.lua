-- community standard for module
local M = {}
-- DEFAULT CONFIG
M.config = {
	notes_path = vim.fn.expand("~/Documents/notes"),
}

M.setup = function(user_config)
	-- nvim doesnt like lower cases so might as well make it clear this is mine
	M.config = vim.tbl_extend("force", M.config, user_config or {})
	vim.api.nvim_create_user_command("NOTE", function(opts)
		if vim.fn.isdirectory(M.config.notes_path) == 0 then
			print("this directory does not exist")
			return
		end

		local input = opts.args
		if not (input:match("%.md") or input:match("%.txt")) then
			input = opts.args .. ".md"
		end

		local full_path = M.config.notes_path .. input
		--vim.cmd.edit(full_path) also exists
		vim.cmd("edit " .. full_path)
	end, {
		nargs = 1,
		--NOTE: needed for autocomplete
		complete = function(ArgLead, CmdLine, CursorPos)
			local files = vim.fn.readdir(M.config.notes_path)
			--similar to js map filter
			return vim.tbl_filter(function(file)
				local match_position = file:find("^" .. ArgLead)
				--nil on not found
				return match_position
			end, files)
		end,
		desc = "edits or creates a note",
	})
end
return M
