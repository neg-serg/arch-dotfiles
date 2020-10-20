local a = vim.api
local language = require'vim.treesitter.language'

-- query: pattern matching on trees
-- predicate matching is implemented in lua
local Query = {}
Query.__index = Query

local M = {}

--- Parses a query.
--
-- @param language The language
-- @param query A string containing the query (s-expr syntax)
--
-- @returns The query
function M.parse_query(lang, query)
  language.require_language(lang)
  local self = setmetatable({}, Query)
  self.query = vim._ts_parse_query(lang, vim.fn.escape(query,'\\'))
  self.info = self.query:inspect()
  self.captures = self.info.captures
  return self
end

-- TODO(vigoux): support multiline nodes too

--- Gets the text corresponding to a given node
-- @param node the node
-- @param bufnr the buffer from which the node in extracted.
function M.get_node_text(node, bufnr)
  local start_row, start_col, end_row, end_col = node:range()
  if start_row ~= end_row then
    return nil
  end
  local line = a.nvim_buf_get_lines(bufnr, start_row, start_row+1, true)[1]
  return string.sub(line, start_col+1, end_col)
end

-- Predicate handler receive the following arguments
-- (match, pattern, bufnr, predicate)
local predicate_handlers = {
  ["eq?"] = function(match, _, bufnr, predicate)
      local node = match[predicate[2]]
      local node_text = M.get_node_text(node, bufnr)

      local str
      if type(predicate[3]) == "string" then
        -- (#eq? @aa "foo")
        str = predicate[3]
      else
        -- (#eq? @aa @bb)
        str = M.get_node_text(match[predicate[3]], bufnr)
      end

      if node_text ~= str or str == nil then
        return false
      end

      return true
  end,

  ["match?"] = function(match, _, bufnr, predicate)
      local node = match[predicate[2]]
      local regex = predicate[3]
      local start_row, _, end_row, _ = node:range()
      if start_row ~= end_row then
        return false
      end

      return string.find(M.get_node_text(node, bufnr), regex)
  end,

  ["vim-match?"] = (function()
    local magic_prefixes = {['\\v']=true, ['\\m']=true, ['\\M']=true, ['\\V']=true}
    local function check_magic(str)
      if string.len(str) < 2 or magic_prefixes[string.sub(str,1,2)] then
        return str
      end
      return '\\v'..str
    end

    local compiled_vim_regexes = setmetatable({}, {
      __index = function(t, pattern)
        local res = vim.regex(check_magic(pattern))
        rawset(t, pattern, res)
        return res
      end
    })

    return function(match, _, bufnr, pred)
      local node = match[pred[2]]
      local start_row, start_col, end_row, end_col = node:range()
      if start_row ~= end_row then
        return false
      end

      local regex = compiled_vim_regexes[pred[3]]
      return regex:match_line(bufnr, start_row, start_col, end_col)
    end
  end)(),

  ["contains?"] = function(match, _, bufnr, predicate)
    local node = match[predicate[2]]
    local node_text = M.get_node_text(node, bufnr)

    for i=3,#predicate do
      if string.find(node_text, predicate[i], 1, true) then
        return true
      end
    end

    return false
  end
}

--- Adds a new predicates to be used in queries
--
-- @param name the name of the predicate, without leading #
-- @param handler the handler function to be used
--    signature will be (match, pattern, bufnr, predicate)
function M.add_predicate(name, handler, force)
  if predicate_handlers[name] and not force then
    a.nvim_err_writeln(string.format("Overriding %s", name))
  end

  predicate_handlers[name] = handler
end

function Query:match_preds(match, pattern, bufnr)
  local preds = self.info.patterns[pattern]
  if not preds then
    return true
  end
  for _, pred in pairs(preds) do
    -- Here we only want to return if a predicate DOES NOT match, and
    -- continue on the other case. This way unknown predicates will not be considered,
    -- which allows some testing and easier user extensibility (#12173).
    -- Also, tree-sitter strips the leading # from predicates for us.
    if string.sub(pred[1], 1, 4) == "not-" then
      local pred_name = string.sub(pred[1], 5)
      if predicate_handlers[pred_name] and
        predicate_handlers[pred_name](match, pattern, bufnr, pred) then
        return false
      end

    elseif predicate_handlers[pred[1]] and
      not predicate_handlers[pred[1]](match, pattern, bufnr, pred) then
      return false
    end
  end
  return true
end

--- Iterates of the captures of self on a given range.
--
-- @param node The node under witch the search will occur
-- @param buffer The source buffer to search
-- @param start The starting line of the search
-- @param stop The stoping line of the search (end-exclusive)
--
-- @returns The matching capture id
-- @returns The captured node
function Query:iter_captures(node, bufnr, start, stop)
  if bufnr == 0 then
    bufnr = vim.api.nvim_get_current_buf()
  end
  local raw_iter = node:_rawquery(self.query, true, start, stop)
  local function iter()
    local capture, captured_node, match = raw_iter()
    if match ~= nil then
      local active = self:match_preds(match, match.pattern, bufnr)
      match.active = active
      if not active then
        return iter() -- tail call: try next match
      end
    end
    return capture, captured_node
  end
  return iter
end

--- Iterates of the matches of self on a given range.
--
-- @param node The node under witch the search will occur
-- @param buffer The source buffer to search
-- @param start The starting line of the search
-- @param stop The stoping line of the search (end-exclusive)
--
-- @returns The matching pattern id
-- @returns The matching match
function Query:iter_matches(node, bufnr, start, stop)
  if bufnr == 0 then
    bufnr = vim.api.nvim_get_current_buf()
  end
  local raw_iter = node:_rawquery(self.query, false, start, stop)
  local function iter()
    local pattern, match = raw_iter()
    if match ~= nil then
      local active = self:match_preds(match, pattern, bufnr)
      if not active then
        return iter() -- tail call: try next match
      end
    end
    return pattern, match
  end
  return iter
end

return M
