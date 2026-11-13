-- Debugger. Java-adapteren (java-debug) settes opp av nvim-java når jdtls starter.
return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		{ "theHamsta/nvim-dap-virtual-text", opts = {} },
	},
	keys = {
		{
			"<F5>",
			function()
				require("dap").continue()
			end,
			desc = "Debug: Start/fortsett",
		},
		{
			"<S-F5>",
			function()
				require("dap").terminate()
			end,
			desc = "Debug: Stopp",
		},
		{
			"<F1>",
			function()
				require("dap").step_into()
			end,
			desc = "Debug: Step into",
		},
		{
			"<F2>",
			function()
				require("dap").step_over()
			end,
			desc = "Debug: Step over",
		},
		{
			"<F3>",
			function()
				require("dap").step_out()
			end,
			desc = "Debug: Step out",
		},
		{
			"<F7>",
			function()
				require("dapui").toggle()
			end,
			desc = "Debug: Vis/skjul UI",
		},
		{
			"<leader>b",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Debug: Toggle [B]reakpoint",
		},
		{
			"<leader>B",
			function()
				require("dap").set_breakpoint(vim.fn.input("Betingelse: "))
			end,
			desc = "Debug: Betinget [B]reakpoint",
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		dapui.setup()

		-- Lukkes ikke automatisk: nvim-java kjører også vanlige tester via DAP,
		-- og output i konsollen skal være synlig etter kjøring. Lukk med <F7>.
		dap.listeners.after.event_initialized["dapui_config"] = dapui.open

		require("custom.java_test").setup()
	end,
}

-- vim: ts=2 sts=2 sw=2 et
