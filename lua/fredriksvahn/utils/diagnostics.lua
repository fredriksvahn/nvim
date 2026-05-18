vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = { source = 'if_many', spacing = 2 },
  update_in_insert = false,
  -- Auto-open the float when jumping with [d / ]d
  jump = { float = true },
}
