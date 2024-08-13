local registry = require("mason-registry")

local M = {}

local function install_package(pkg, version)
	local pkg_name = pkg.name

	vim.notify(("[Mason] installing %s"):format(pkg_name))

	return pkg:install({ version = version }):once(
		"closed",
		vim.schedule_wrap(function()
			if pkg:is_installed() then
				vim.notify(("[Mason] %s was successfully installed"):format(pkg_name))
			else
				vim.notify(
					("[Mason] failed to install %s. Installation logs are available in :Mason and :MasonLog"):format(
						pkg_name
					),
					vim.log.levels.ERROR
				)
			end
		end)
	)
end

local function try_install(mason_package_name)
	local Package = require("mason-core.package")
	local package_name, version = Package.Parse(mason_package_name)

	local Optional = require("mason-core.optional")

	local ok, pkg = pcall(registry.get_package, mason_package_name)
	if ok then
		-- return Optional.of_nilable(pkg)
		Optional.of_nilable(pkg)
			:if_present(function()
				if not pkg:is_installed() then
					install_package(pkg, version)
				end
			end)
			:if_not_present(function()
				vim.notify(
					("[Mason] Formatter %q is not a valid entry in ensure_installed. Make sure to only provide valid formatter names."):format(
						package_name
					),
					vim.log.levels.WARN
				)
			end)
	end
end

local function auto_install()
	local formatters_by_ft = require("conform").formatters_by_ft
	local formatters_to_install = {}

	for _, formatters in pairs(formatters_by_ft) do
		for _, formatter in pairs(formatters) do
			if type(formatter) == "table" then
				for _, f in pairs(formatter) do
					formatters_to_install[f] = 1
				end
			else
				formatters_to_install[formatter] = 1
			end
		end
	end

	for conformFormatter, _ in pairs(formatters_to_install) do
		if conformFormatter ~= nil then
			try_install(conformFormatter)
		end
	end
end

function M.setup()
	if registry.refresh then
		registry.refresh(vim.schedule_wrap(auto_install))
	else
		auto_install()
	end
end

return M
