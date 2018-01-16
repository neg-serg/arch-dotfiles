autocmd vimrc BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,Guardfile,config.ru,*.rake} set ft=ruby
autocmd vimrc FileType ruby setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd vimrc FileType ruby setlocal re=1 nornu
