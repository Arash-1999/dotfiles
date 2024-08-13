local M = {}

M.settings = {
	css = {
		completion = {
			completePropertyWithSemicolon = false,
		},
		lint = {
			unknownAtRules = "ignore",
			duplicateProperties = "warning",
		},
	},
	scss = {
		completion = {
			completePropertyWithSemicolon = false,
		},
		lint = {
			unknownAtRules = "ignore",
			duplicateProperties = "warning",
		},
	},
}

return M
