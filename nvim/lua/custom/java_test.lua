-- Tilbakemelding for JUnit-kjøringer via nvim-java.
--
-- nvim-java kjører tester som DAP-sesjoner. I run-modus (noDebug) sender
-- java-debug verken `initialized` eller noe annet før `terminated`, så uten
-- dette får man ingen indikasjon på at testene starter eller blir ferdige.
local M = {}

-- Navnet nvim-java gir DAP-konfigurasjonen for testkjøringer.
local SESSION_NAME = "Launch All Java Tests"
local KEY = "custom_java_test"

local function is_test_session(session)
	return session and session.config and session.config.name == SESSION_NAME
end

local function count(results, acc)
	local Status = require("java-test.results.result-status")
	for _, r in ipairs(results or {}) do
		if not r.is_suite then
			local status = r.result and r.result.status
			if status == Status.Failed then
				acc.failed = acc.failed + 1
			elseif status == Status.Skipped then
				acc.skipped = acc.skipped + 1
			else
				acc.passed = acc.passed + 1
			end
		end
		count(r.children, acc)
	end
	return acc
end

local function summarize()
	local java_test = require("java-test")
	local report = java_test.last_report
	local ok, results = pcall(function()
		return report and report:get_results()
	end)
	if not ok or not results or #results == 0 then
		vim.notify("Testkjøring ferdig (ingen resultater)", vim.log.levels.WARN)
		return
	end

	local c = count(results, { passed = 0, failed = 0, skipped = 0 })
	local msg = string.format("Tester ferdig: %d bestått, %d feilet, %d hoppet over", c.passed, c.failed, c.skipped)
	if c.failed > 0 then
		vim.notify(msg, vim.log.levels.ERROR)
		java_test.view_last_report()
	else
		vim.notify(msg, vim.log.levels.INFO)
	end
end

function M.setup()
	local dap = require("dap")

	dap.listeners.after.launch[KEY] = function(session)
		if is_test_session(session) then
			vim.notify(session.config.noDebug and "Kjører tester…" or "Debugger tester…")
		end
	end

	-- Vis konsollen i dap-ui når testen faktisk skriver noe.
	dap.listeners.after.event_output[KEY] = function(session, body)
		if is_test_session(session) and body.category ~= "telemetry" then
			local ok, dapui = pcall(require, "dapui")
			if ok and not session[KEY .. "_opened"] then
				session[KEY .. "_opened"] = true
				dapui.open()
			end
		end
	end

	dap.listeners.after.event_terminated[KEY] = function(session)
		if is_test_session(session) then
			-- Resultatene kommer over en egen socket og kan ligge litt etter `terminated`.
			vim.defer_fn(summarize, 500)
		end
	end
end

return M

-- vim: ts=2 sts=2 sw=2 et
