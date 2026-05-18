-- Custom Everforest overrides — based on DeliriumTheme Everforest-darken
-- https://github.com/mr4torr/delirium-ui
-- Applied on top of sainnhe/everforest after it loads.

local bg      = '#181819'
local bg_sel  = '#313133'
local fg      = '#d2c6ab'
local fg_dim  = '#635e53'
local line_nr = '#443f36'
local red     = '#e67e80'
local green   = '#83c092'
local blue    = '#a7c080'
local teal    = '#7fbbb3'
local yellow  = '#dbbc7f'
local orange  = '#e69875'
local purple  = '#d699b6'

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Groups not covered by everforest's palette override
hl('LineNr',      { bg = bg,     fg = line_nr })
hl('EndOfBuffer', { bg = bg,     fg = bg })
hl('MatchParen',  { bg = bg_sel, fg = blue, bold = true })

-- Classic syntax (fallback for non-treesitter)
hl('Comment',      { fg = fg_dim, italic = true })
hl('Keyword',      { fg = red })
hl('Statement',    { fg = red })
hl('Conditional',  { fg = red })
hl('Repeat',       { fg = red })
hl('Include',      { fg = red })
hl('PreProc',      { fg = red })
hl('StorageClass', { fg = orange })
hl('Operator',     { fg = orange })
hl('String',       { fg = green })
hl('Character',    { fg = green })
hl('Function',     { fg = blue })
hl('Type',         { fg = teal })
hl('Number',       { fg = purple })
hl('Float',        { fg = purple })
hl('Boolean',      { fg = red })
hl('Constant',     { fg = purple })
hl('Special',      { fg = orange })
hl('Identifier',   { fg = fg })

-- Treesitter — both legacy (pre-0.10) and current names
hl('@comment',                   { fg = fg_dim, italic = true })
hl('@string',                    { fg = green })
hl('@string.escape',             { fg = orange })
hl('@character',                 { fg = green })
hl('@number',                    { fg = purple })
hl('@number.float',              { fg = purple }) -- 0.10+
hl('@float',                     { fg = purple }) -- legacy
hl('@boolean',                   { fg = red })
hl('@constant',                  { fg = purple })
hl('@constant.builtin',          { fg = orange })

hl('@function',                  { fg = blue })
hl('@function.call',             { fg = blue })
hl('@function.builtin',          { fg = blue })
hl('@function.method',           { fg = blue }) -- 0.10+
hl('@function.method.call',      { fg = blue }) -- 0.10+
hl('@method',                    { fg = blue }) -- legacy
hl('@method.call',               { fg = blue }) -- legacy
hl('@constructor',               { fg = blue })

hl('@keyword',                   { fg = red })
hl('@keyword.function',          { fg = orange })
hl('@keyword.return',            { fg = red })
hl('@keyword.operator',          { fg = red })
hl('@keyword.import',            { fg = red })
hl('@keyword.conditional',       { fg = red }) -- 0.10+
hl('@keyword.repeat',            { fg = red }) -- 0.10+
hl('@keyword.storage',           { fg = orange }) -- 0.10+
hl('@conditional',               { fg = red })  -- legacy
hl('@repeat',                    { fg = red })  -- legacy
hl('@include',                   { fg = red })  -- legacy
hl('@storageclass',              { fg = orange }) -- legacy

hl('@operator',                  { fg = orange })
hl('@punctuation',               { fg = fg_dim })
hl('@punctuation.bracket',       { fg = fg_dim })
hl('@punctuation.delimiter',     { fg = fg_dim })

hl('@type',                      { fg = teal })
hl('@type.builtin',              { fg = green })
hl('@type.qualifier',            { fg = orange })

hl('@module',                    { fg = green }) -- 0.10+
hl('@namespace',                 { fg = green }) -- legacy

hl('@variable',                  { fg = fg })
hl('@variable.builtin',          { fg = orange })
hl('@variable.member',           { fg = fg }) -- 0.10+
hl('@variable.parameter',        { fg = yellow }) -- 0.10+
hl('@field',                     { fg = fg })    -- legacy
hl('@parameter',                 { fg = yellow }) -- legacy
hl('@property',                  { fg = fg })

hl('@tag',                       { fg = orange })
hl('@tag.attribute',             { fg = blue })
hl('@tag.delimiter',             { fg = fg_dim })

-- LSP semantic tokens (used by roslyn.nvim / any LSP with semantic highlighting)
hl('@lsp.type.class',            { fg = green })
hl('@lsp.type.interface',        { fg = teal })
hl('@lsp.type.enum',             { fg = green })
hl('@lsp.type.enumMember',       { fg = green })
hl('@lsp.type.struct',           { fg = green })
hl('@lsp.type.namespace',        { fg = green })
hl('@lsp.type.function',         { fg = blue })
hl('@lsp.type.method',           { fg = blue })
hl('@lsp.type.property',         { fg = fg })
hl('@lsp.type.variable',         { fg = fg })
hl('@lsp.type.parameter',        { fg = yellow })
hl('@lsp.type.typeParameter',    { fg = yellow })
hl('@lsp.type.keyword',          { fg = red })
hl('@lsp.type.string',           { fg = green })
hl('@lsp.type.number',           { fg = purple })
hl('@lsp.type.operator',         { fg = orange })
hl('@lsp.type.comment',          { fg = fg_dim, italic = true })
hl('@lsp.type.decorator',        { fg = yellow })
hl('@lsp.type.selfKeyword',      { fg = orange })
hl('@lsp.type.plaintext',        { fg = fg })

-- Oil.nvim
hl('OilNormal', { fg = fg })
