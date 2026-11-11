-- Kjør og debug Cucumber-scenarier via Maven fra en .feature-buffer.
--
-- Bruker Cucumber sin JUnit Platform-engine direkte:
--   mvn test -Dsurefire.includeJUnit5Engines=cucumber -Dcucumber.features=<fil>:<linje>
-- Debug starter Maven med -Dmaven.surefire.debug (JVM venter på port 5005)
-- og kobler nvim-dap til så snart JVM-en lytter.
local M = {}

M.config = {
	-- Pakke(r) med step definitions, f.eks. "no.skatteetaten.app.steps".
	-- Trengs bare hvis glue ikke er satt i src/test/resources/junit-platform.properties.
	glue = nil,
	plugin = "pretty",
	debug_port = 5005,
	extra_args = {},
}

local SCENARIO_KEYWORDS = {
	"Scenario",
	"Scenario Outline",
	"Scenario Template",
	"Example",
	"Scenariomal",
	"Abstrakt Scenario",
	"Eksempel",
}
local EXAMPLES_KEYWORDS = { "Examples", "Scenarios", "Eksempler" }

local last_run
local term_buf

local function keyword(line)
	return line:match("^%s*([^:|#]-)%s*:")
end

-- Finner linjen Cucumber skal filtrere på: nærmeste scenario over markøren,
-- eller selve raden hvis markøren står på en datarad i en Examples-tabell.
function M.scenario_line(lines, cursor)
	local in_table = lines[cursor]:match("^%s*|") ~= nil
	local rows = 0
	for i = cursor, 1, -1 do
		local line = lines[i]
		if in_table and line:match("^%s*|") then
			rows = rows + 1
		else
			local kw = keyword(line)
			if in_table and rows > 1 and vim.tbl_contains(EXAMPLES_KEYWORDS, kw) then
				return cursor
			end
			in_table = false
			if vim.tbl_contains(SCENARIO_KEYWORDS, kw) then
				return i
			end
		end
	end
	return nil
end

local function maven_command(root, feature, debug)
	local cmd = {
		vim.fs.find("mvnw", { path = root, upward = true })[1] or "mvn",
		"test",
		"-Dsurefire.includeJUnit5Engines=cucumber",
		"-Dcucumber.features=" .. feature,
	}
	if M.config.plugin then
		table.insert(cmd, "-Dcucumber.plugin=" .. M.config.plugin)
	end
	if M.config.glue then
		table.insert(cmd, "-Dcucumber.glue=" .. M.config.glue)
	end
	if debug then
		table.insert(
			cmd,
			"-Dmaven.surefire.debug=-agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=localhost:"
				.. M.config.debug_port
		)
	end
	vim.list_extend(cmd, M.config.extra_args)
	return cmd
end

local function attach_debugger()
	local dap = require("dap")
	if not dap.adapters.java then
		vim.notify("Java debug-adapter mangler. Åpne en .java-fil så jdtls/nvim-java starter.", vim.log.levels.ERROR)
		return
	end
	dap.run({
		type = "java",
		request = "attach",
		name = "Cucumber (attach)",
		hostName = "127.0.0.1",
		port = M.config.debug_port,
	})
end

local function start(run)
	if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
		vim.api.nvim_buf_delete(term_buf, { force = true })
	end

	local origin = vim.api.nvim_get_current_win()
	vim.cmd("botright 15new")
	term_buf = vim.api.nvim_get_current_buf()

	local attached = false
	local tail = ""
	vim.fn.jobstart(run.cmd, {
		term = true,
		cwd = run.root,
		on_stdout = function(_, data)
			if not run.debug or attached then
				return
			end
			tail = (tail .. table.concat(data, "\n")):sub(-300)
			if tail:find("Listening for transport dt_socket", 1, true) then
				attached = true
				vim.schedule(attach_debugger)
			end
		end,
	})

	vim.api.nvim_set_current_win(origin)
	last_run = run
end

local function run_feature(with_line, opts)
	opts = opts or {}
	local file = vim.api.nvim_buf_get_name(0)
	local root = vim.fs.root(file, { "pom.xml" })
	if not root then
		vim.notify("Fant ingen pom.xml over " .. file, vim.log.levels.ERROR)
		return
	end

	local feature = file
	if with_line then
		local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
		local line = M.scenario_line(lines, vim.api.nvim_win_get_cursor(0)[1])
		if not line then
			vim.notify("Markøren står ikke i et scenario", vim.log.levels.WARN)
			return
		end
		feature = file .. ":" .. line
	end

	start({ root = root, debug = opts.debug, cmd = maven_command(root, feature, opts.debug) })
end

function M.run_scenario(opts)
	run_feature(true, opts)
end

function M.run_file(opts)
	run_feature(false, opts)
end

function M.run_last()
	if not last_run then
		vim.notify("Ingen Cucumber-kjøring å gjenta", vim.log.levels.WARN)
		return
	end
	start(last_run)
end

return M

-- vim: ts=2 sts=2 sw=2 et
