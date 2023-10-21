-- Add the key mappings only for Markdown files in a zk notebook.
if require("zk.util").notebook_root(vim.fn.expand("%:p")) ~= nil then
	local function map(...)
		vim.api.nvim_buf_set_keymap(0, ...)
	end

	-- Open the link under the caret.
	map(
		"n",
		"<CR>",
		"<Cmd>lua vim.lsp.buf.definition()<CR>",
		{ noremap = true, silent = false, desc = "Open Link Under Caret" }
	)

	-- Create a new note after asking for its title.
	-- This overrides the global `<leader>zn` mapping to create the note in the same directory as the current buffer.
	map(
		"n",
		"<leader>zn",
		"<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>",
		{ noremap = true, silent = false, desc = "[Z]k [N]ew Note in Current Directory" }
	)
	-- Create a new note in the same directory as the current buffer, using the current selection for title.
	map("v", "<leader>znt", ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", {
		noremap = true,
		silent = false,
		desc = "[Z]k [N]ew Note in Current Directory with Selection as [T]itle",
	})
	-- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
	map(
		"v",
		"<leader>znc",
		":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>",
		{
			noremap = true,
			silent = false,
			desc = "[Z]k [N]ew Note in Current Directory with Selection as [C]ontent",
		}
	)

	-- Open notes linking to the current buffer.
	map("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", { noremap = true, silent = false, desc = "[Z]k Open [B]acklinks" })
	-- Alternative for backlinks using pure LSP and showing the source context.
	--map('n', '<leader>zb', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
	-- Open notes linked by the current buffer.
	map(
		"n",
		"<leader>zl",
		"<Cmd>ZkLinks<CR>",
		{ noremap = true, silent = false, desc = "[Z]k Open Back[L]inks with LSP" }
	)

	-- Preview a linked note.
	map(
		"n",
		"<leader>zp",
		"<Cmd>lua vim.lsp.buf.hover()<CR>",
		{ noremap = true, silent = false, desc = "[Z]k [P]review Linked Note" }
	)
	-- Open the code actions for a visual selection.
	map(
		"v",
		"<leader>za",
		":'<,'>lua vim.lsp.buf.range_code_action()<CR>",
		{ noremap = true, silent = false, desc = "[Z]k Code [A]ctions" }
	)
end
