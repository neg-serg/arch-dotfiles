-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ w0rp/ale                                                                     │
-- └───────────────────────────────────────────────────────────────────────────────────┘
vim.g.ale_fixers = {
    ['javascript'] = 'eslint',
    ['json'] = 'jq',
    ['cpp'] = {'clang', 'clangcheck', 'clangtidy'},
    ['html'] = 'prettier',
    ['scss'] = 'stylelint',
    ['less'] = 'stylelint',
    ['css'] = 'stylelint',
    ['python'] = 'yapf',
    ['rust'] = 'rustfmt'
}
vim.g.ale_linters = {['python'] = {'bandit', 'jedils', 'mypy',
'prospector', 'pycodestyle', 'pydocstyle', 'pyflakes', 'pylama', 'pylint',
'pyls', 'pyre', 'pyright', 'vulture'}}
vim.g['ale_cpp_clangcheck_options'] = '-extra-arg -Xanalyzer -extra-arg -analyzer-output=text -- -Wall -std=c++11 -x c++ -DDBG_MACRO_NO_WARNING=1'
vim.g['ale_cpp_clang_options'] = '--std=c++11 -Wall -Iinclude'
vim.g['ale_cpp_clangtidy_options'] = '-Wall -std=c++11 -x c++ -Iinclude -extra-arg -Xanalyzer -extra-arg -analyzer-output=text'
vim.g["ale_echo_msg_format"] = '%linter% %s %severity%'
vim.g["ale_sign_error"] = ''
vim.g["ale_sign_highlight_linenrs"] = 1
vim.g["ale_sign_warning"] = ''
