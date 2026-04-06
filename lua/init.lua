-- community standard for module
local M = {}

local command_name = "Note"

M.setup = function(user_config)
	if user_config.notes_path == nil then
		print("notoanoto extension error: no notes_path")
		return
	end

	vim.api.nvim_create_user_command(command_name, function(opts)
		if vim.fn.isdirectory(user_config.notes_path) == 0 then
			print("this directory does not exist")
			return
		end

		local input = opts.args
		if not (input:match("%.md") or input:match("%.txt")) then
			if input == "" then
				input = vim.fn.strftime("%d.%m.%y")
			end
			input = input .. ".md"
		end

		if not (string.sub(user_config.notes_path, -1) == "/") then
			user_config.notes_path = user_config.notes_path .. "/"
		end

		local full_path = user_config.notes_path .. input
		--vim.cmd.edit(full_path) also exists
		vim.cmd("edit " .. full_path)
	end, {
		nargs = "?",
		--NOTE: needed for autocomplete
		complete = function(ArgLead, CmdLine, CursorPos)
			local files = vim.fn.readdir(user_config.notes_path)
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
