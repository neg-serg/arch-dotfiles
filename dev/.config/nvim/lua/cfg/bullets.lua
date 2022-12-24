local ok, bullets = pcall(require, 'md-bullets')
if (not ok) then return end

bullets.setup {
    symbols={"◉","○","✸","✿"}
}
