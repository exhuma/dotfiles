local ls = require("luasnip")
local snippet = ls.snippet
local text = ls.text_node
local insert = ls.insert_node


vim.keymap.set("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
vim.keymap.set("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
vim.keymap.set("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
vim.keymap.set("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)

ls.add_snippets(nil, {
    python = {
        snippet({
            trig = "dp",
            namr = "Debug-Print",
            dscr = "Adds a print-statement with tailing 'XXX' comment",
        }, {
            text({"print("}),
            insert(1, '"print value"'),
            text({")  # XXX"}),
        }),
    },
    typescript = {
        snippet({
            trig = "dp",
            namr = "Debug-Print",
            dscr = "Adds a print-statement with tailing 'XXX' comment",
        }, {
            text({"console.log("}),
            insert(1, '"print value"'),
            text({"); // XXX"}),
        }),
    },
})

