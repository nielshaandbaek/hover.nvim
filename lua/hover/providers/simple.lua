require("hover").register({
	name = "Simple",
	--- @param bufnr integer
	enabled = function(bufnr)
		return true
	end,
	--- @param opts Hover.Options
	--- @param done fun(result: any)
	execute = function(opts, done)
		done({ lines = { "TEST" }, filetype = "markdown" })
	end,
	priority = 175,
})
