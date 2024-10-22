-- import nvim-dap plugin safely
local setup, nvimdap = pcall(require, "nvim-dap")
if not setup then
	return
end
