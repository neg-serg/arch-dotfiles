-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ chrisgrieser/nvim-alt-substitute                                             │
-- └───────────────────────────────────────────────────────────────────────────────────┘
local status, alt_substitute=pcall(require, 'alt-substitute')
if (not status) then return end
alt_substitute.setup()
