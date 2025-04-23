local M = {}

M.settings = {
  css = {
    completion = {
      completePropertyWithSemicolo = false,
    },
    lint = {
      unknownAtRules = 'ignore',
      duplicateProperties = 'warning',
    }
  },
  scss = {
    completion = {
      completePropertyWithSemicolo = false,
    },
    lint = {
      unknownAtRules = 'ignore',
      duplicateProperties = 'warning',
    }
  }
}

return M
