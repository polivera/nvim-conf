-- Clear all snippets when file is loaded
require("luasnip.session.snippet_collection").clear_snippets "lua"

local lsn = require "luasnip"

local snp = lsn.snippet
local ine = lsn.insert_node
local fmt = require("luasnip.extras.fmt").fmt

lsn.add_snippets("lua", {
    snp("lol", fmt("lol name {} that is a template of {}", { ine(1), ine(0) })),
})

