"""""""""""""""""""""""""""""""""""""
syntax on
    :colorscheme wildcharm
    "quiet 
    "peachpuff
    "pablo 
    "murphy 
    "lunaperche 
    "habamax "! 
    "evening 
    "delek
    "industry
    "desert
    "wildcharm
"""""""""""""""""""""""""""""""""""""
set title " заголовок окна, отражающий текущий редактируемый файл
set number " позволяет включить отображение номеров строк
"set textwidth=80 " установлен на значение, отличное от нуля, настройка wrapmargin не имеет эффекта
set wrapmargin=5 " перед переносом строк нужно установить отступ в 5 символов от правой границы окна
set linebreak " переносить строки только после символов, перечисленных в опции breakat
set incsearch " подсветка результатов поиска по мере набора текста
set ignorecase " игнорировать регистр в поиске
set breakat=^\ /\\.;>_? "  по умолчанию breakat содержит пробел и некоторые знаки препинания
set expandtab " включает использование пробелов для отступов строк, даже при нажатии клавиши Tab
set smarttab " добавляется отступ, ширина которого соответствует значению опции shiftwidth
set tabstop=4 " заставляет символ табуляции отображаться как четыре пробела вместо обычных восьми
set shiftwidth=4 " при сдвиге строк для отступа используется 4 пробела
set expandtab " включает замену символов табуляции на пробелы
set smartindent " автоформатирования отступов
set encoding=utf8 " использует кодировку UTF-8 для внутреннего представления текста
set fileencoding=utf8 " задаёт кодировку сохранения файла UTF-8
set hlsearch " подсветка совпадений поиска
set ignorecase " игнорировать регистр при поиске
"""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged') " искать плагины в этой директории
     Plug 'preservim/nerdtree'
     Plug 'stanangeloff/php.vim'
     Plug 'ap/vim-css-color'
     Plug 'sheerun/vim-polyglot'
     Plug 'yggdroot/indentline'
call plug#end()
" :source %
" :PlugInstall
" :PlugUpgrade
"""""""""""""""""""""""""""""""""""""
let mapleader = "q"
    nmap <leader> :NERDTreeClose<cr>
let mapleader = "n"
    nmap <leader> :NERDTreeFocus<cr>
let mapleader = "f"
    nmap <leader> :NERDTreeToggle<cr>

let NERDTreeShowHidden=1 " отобразить скрытые файлы

let g:indentLine_color_term = 240
"7>белый,5>фиолетовый,1>красный,2>салатовый,4>синий, 239>серый цвет
let g:indentLine_char = '࿕' " '↦ ','↓','⇣','࿕'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
