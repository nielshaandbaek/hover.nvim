local REQUIREMENT_PATTERN = "REQ%-%u+%-%u+%-%d+"

local function enabled(bufnr)
	return vim.fn.expand("<cWORD>"):match(REQUIREMENT_PATTERN) ~= nil
end

local function execute(opts, done)
	local query = vim.fn.expand("<cWORD>"):match(REQUIREMENT_PATTERN)
	print(vim.inspect(query))

	local job = require("hover.async.job").job
	local full_query = "'#+\\s+" .. query .. "\\b'"
	print(vim.inspect(full_query))
	job({ "rg", full_query, "~" }, function(result)
		print(vim.inspect(result))
		if result == nil then
			done(false)
			return
		end

		local lines = {}
		for line in result:gmatch("[^\r\n]+") do
			-- Remove lines starting with \27, which is not formatted well and
			-- is only there for help/context/suggestion lines anyway.
			table.insert(lines, line)
		end

		done({ lines = lines, filetype = "markdown" })
	end)
end

require("hover").register({
	name = "Reqtraq",
	priority = 175,
	enabled = enabled,
	execute = execute,
})
