#!/bin/bash
export BASH_SILENCE_DEPRECATION_WARNING=1 && > .hushlogin
export PATH="/Applications/MAMP/bin/php/php8.3.14/bin:$PATH"
export PATH="/Applications/MAMP/bin/php/php8.3.28/bin:$PATH"
export PATH="/users/master/script:$PATH"
#eval "$(/usr/local/bin/brew shellenv)"                      
printf "\e[8;33;120t"

######
PS1="\n    " ; PS2="  "

######
alias p="cd ~ && vim .bash_profile"
alias p.=". ~/.bash_profile ; defaults write com.apple.finder AppleShowAllFiles -bool true ;
        killall Finder ; exit"
_p() {
    { rsync --archive --delete ~/.bash_profile ~/.b_p.copy/ ;
      rsync --archive --delete ~/.bash_profile ~/profile/ ;
      rsync --archive --delete ~/.vimrc ~/.b_p.copy/ ;
      rsync --archive --delete ~/.vim ~/.b_p.copy/ ; } &&
      printf "\n${COLOR}  создана локальная копия файла${RESET}\n" || printf "\n  $?\n"
    if [ -e /volumes/usb ] ; then
        rsync --archive --delete ~/.bash_profile /volumes/usb/b_p.copy/ &&
        rsync --archive --delete ~/.vimrc /volumes/usb/b_p.copy/ &&
        rsync --archive --delete ~/.vim /volumes/usb/b_p.copy/ &&
        printf "${COLOR}  создана флеш копия файла${RESET}\n"
    else
        printf "\e[1;31m  ф л е ш - н а к о п и т е л ь   н е   н а й д е н\e[0m\n"
    fi
}
p_() {
    if [ -e ~/.b_p.copy ] ; then
        { rsync --archive --delete ~/.b_p.copy/.bash_profile ~/.bash_profile ;
          rsync --archive --delete ~/.b_p.copy/.vimrc ~/.vimrc ;
          rsync --archive --delete ~/.b_p.copy/.vim/ ~/.vim ; } &&
          clear && printf "\n${COLOR}  файл локально восстановлен\n  требуется перезагрузка${RESET}" &&
          printf "\n${BLINK}${COLOR}  терминал закроется через 5 секунд...${RESET}" &&
          printf "\n${PS1}" && sleep 6 && exit
    elif [ -e /volumes/usb/b_p.copy ] ; then
        { rsync --archive --delete /volumes/usb/b_p.copy/.bash_profile ~/.bash_profile ;
          rsync --archive --delete /volumes/usb/b_p.copy/.vimrc ~/.vimrc ;
          rsync --archive --delete /volumes/usb/b_p.copy/.vim/ ~/.vim ; } &&
          clear && printf "\n${COLOR}  файл восстановлен из флеш-накопителя${RESET}" &&
          printf "\n${COLOR}  требуется перезагрузка${RESET}" &&
          printf "\n${BLINK}${COLOR}  терминал закроется через 5 секунд...${RESET}" &&
          printf "\n${PS1}" && sleep 6 && exit
    else
        printf "\n\e[1;31m  з а п р а ш и в а е м ы е   р е с у р с ы  н е   н а й д е н ы\e[0m\n"
    fi
}

######
export PATH="$PATH:/users/master/pascal"
pc() { 
    fpc $1 # free pascal compiler
    if test $PWD/*.o ; then
        rm $PWD/*.o
    fi
}

######
alias o_="printf '\e[8;35;121t'" #                                      развернуть окно терминала
alias z_="printf '\e[8;12;121t'" #                                                  свернуть окно
alias u_="printf '\e[2t'" #                                                         убрать в Dock
alias e_="exit" #                                                                закрыть терминал
alias q_="osascript -e 'tell application \"Terminal\" to quit'" #                закрыть терминал
alias s_="osascript -e 'tell application \"System Events\" to sleep'" #            усыпить машину
alias d_="osascript -e 'tell application \"System Events\" to shut down' & exit" #      выключить

######
alias sudo="sudo " # использовать псевдоним

######
alias ?="which" # найти полный путь к указанным командам или сценариям

###### kill -9 "номер процесса"
alias port_="sudo lsof -i -P | grep LISTEN | grep :$PORT"

######
alias disk_="diskutil list"
alias disk_f="printf '\n\033[5m  для форматирования скопируй и измени:\033[0m
            \n  sudo diskutil eraseDisk #format# #name# MBRFormat /dev/disk #disk#
            \n\033[5m  если нужно отформатировать запароленную флешку:\033[0m
            \n  diskutil apfs deleteContainer /dev/diskX\n'"

###### wi-fi restart [интерфейс-> en0] [SSID маршрутизатора] [пароль]
alias wfr="networksetup -setairportpower en0 off ;
           networksetup -setairportpower en0 on ;
           networksetup -setairportnetwork en0 dot fkmybnfR?0"
alias wfq="networksetup -setairportpower en0 off"
alias wf="networksetup -setairportpower en0 on"

######
alias v="vim"

######
alias n="vim -c 'NERDTree'"

######
alias sql="clear ; mysql -uroot -p0960Master" # выход = exit or quit

######
alias sas="sudo apachectl stop"
alias sar="sudo apachectl restart"

######
alias l="ls -Fla | sort -r";

######
#alias sites="clear && cd ~/sites && gls -lhF --group-directories-first -lia"
alias sites="networksetup -setairportpower en0 on && open -a \"Google Chrome.app\" http://localhost:80 ;
             sleep 4 ;
             osascript -e 'tell application \"Terminal.app\" to activate' ;
             clear ; cd ~/Sites && path_test" 

_sites() {
    if [ ! -e /volumes/usb ] ; then
        printf "\n\e[1;31m  ф л е ш - н а к о п и т е л ь   н е   н а й д е н\e[0m\n"
    else
        rsync --archive --delete ~/sites/ /volumes/usb/sites/ &&
            printf "\n  создана флеш копия файла\n"
    fi
    rsync --archive --delete --exclude='.local/' ~/sites/ ~/.sites-copy/ &&
        printf "  создана локальная копия файла\n"
        
}

sites_() {
    test -e /volumes/usb/sites &&
        rsync --archive --delete /volumes/usb/sites ~/sites-copy ||
            rsync --archive --delete ~/.sites-copy/ ~/sites-copy
}

##### перезагрузить активное окно браузера
alias wr="osascript -e 'tell application \"Google Chrome.app\"
                            tell the active tab of its first window
                                reload
                            end tell
                        end tell'"

#####
alias mamp="open -a 'MAMP.app' && sleep 3 &&
            osascript -e 'tell application \"Terminal.app\" to activate' && clear &&
            cd /Applications/MAMP/htdocs/Master && path_test"

#alias master="clear ; cd /Applications/MAMP/htdocs/master && gls -lhF --group-directories-first -lia"
#alias parser="clear ; cd /Applications/MAMP/htdocs/parser && gls -lhF --group-directories-first -lia"
alias master="clear ; cd /Applications/MAMP/htdocs/master && l"

_master() {
    if [ ! -e /volumes/usb ] ; then
        printf "\n\e[1;31m  ф л е ш - н а к о п и т е л ь   н е   н а й д е н\e[0m\n"
    else
        rsync --archive --delete --exclude='.git/' --exclude='.gitignore' --exclude='README.md' \
            /applications/mamp/htdocs/master/ /volumes/usb/master/ &&
                printf "\n${COLOR}  создана флеш копия файла${RESET}\n"
    fi
    rsync --archive --delete --exclude='.git/' --exclude='.gitignore' --exclude='README.md' \
        /applications/mamp/htdocs/master/ ~/master/ &&
            printf "${COLOR}  создана локальная копия файла${RESET}\n"
}

alias git_="git add . && sleep 3 ;
            git commit -m 'new version' && sleep 3 ;
            git push origin main"

master_() {
    if [ ! -e /volumes/usb/master ] ; then
        printf "\n\e[1;31m  ф л е ш - н а к о п и т е л ь   н е   н а й д е н\e[0m\n"
    else
        { rsync --archive --delete --exclude='.git/' --exclude='.gitignore' --exclude='README.md' \
            /volumes/usb/master/ /applications/mamp/htdocs/master/ &&
                printf "\n${COLOR}  $?${RESET}\n" ; } || 
        { rsync --archive --delete --exclude='.git/' --exclude='.gitignore' --exclude='README.md' \
            ~/master/ /applications/mamp/htdocs/master/ &&
                printf "\n${COLOR}  $?${RESET}\n" ; }
    fi
}

_parser() {
    if [ ! -e /volumes/usb ] ; then
        printf "\n\e[1;31m  ф л е ш - н а к о п и т е л ь   н е   н а й д е н\e[0m\n"
    else
        rsync --archive --delete /applications/mamp/htdocs/parser/ /volumes/usb/parser/ &&
        printf "\n  создана флеш копия файла\n"
    fi
    rsync --archive --delete /applications/mamp/htdocs/parser/ ~/parser/ &&
    printf "  создана локальная копия файла\n"
}

parser_() {
    test -e /volumes/usb/parser &&
        { rsync --archive --delete /volumes/usb/parser/ /applications/mamp/htdocs/parser/ &&
            printf "\n  $?\n" ; } ||
        { rsync --archive --delete ~/parser/ /applications/mamp/htdocs/parser/ &&
            printf "\n  $?\n" ; }
}

alias mamp_log="cd /Applications/MAMP/logs && vim apache_error.log"

#####
#alias usb="cd /Volumes/usb && gls -lhF --group-directories-first -lia"
alias usb="cd /Volumes/usb && l"

_usb() {
    test -e /volumes/usb && 
        rsync --archive --delete --progress $PWD /volumes/usb/. || printf "\n  $?\n"
}

usb_() {
    rsync --archive --delete --progress /volumes/usb/"$1" $PWD || printf "\n  $?\n"
}

######
doc_() {
    cd ~/downloads
    if test -e $1
    then
        mv -fv $1 ~/documents/$1
    fi; cd -
}

######
cp_home() {
    if [ "$PWD" != $HOME ]
    then
        cp -rpv "$PWD" ~/$1
    fi
}

######
rec_() {
    dir_=$(PWD) && cd ~/Movies
    if [ ! -e rec/ ] ; then
      mkdir rec && cd rec && screencapture -v -g "$1.mp4"
    else
      cd rec && screencapture -v -g "$1.mp4"
    fi
    cd $dir_ && echo "    ${STYLE}${COLOR}${PWD}${RESET}" && ls -F
}
qtp_() {
    open -a 'QuickTime Player' "$1.mp4"
}
alias qtq="pkill 'QuickTime Player'"

######
alias ml="networksetup -setairportpower en0 on && open -a Mail"
alias mlq="pkill Mail"

######
alias gx="open -a 'Opera GX.app'"
alias gxl="open -a 'MAMP.app' && sleep 6 &&
    networksetup -setairportpower en0 on && open -a 'Opera GX.app' http://localhost:8888"
alias gxq="osascript -e 'tell application \"Opera GX.app\" to quit'"

######
alias ff="networksetup -setairportpower en0 on && open -a \"Firefox DE.app\""
alias ffl="open -a 'MAMP.app' && sleep 6 &&
    open -a \"Firefox DE.app\" http://localhost:8888"
alias ffq="osascript -e 'tell application \"Firefox DE.app\" to quit'"

######
alias gg="networksetup -setairportpower en0 on && open -a \"Google Chrome.app\""
alias ggl="open -a 'MAMP.app' && sleep 6 &&
    open -a Google.app http://localhost:8888"
alias ggq="osascript -e 'tell application \"Google Chrome.app\" to quit'"

######
alias te="networksetup -setairportpower en0 on && open -a Telegram"
alias teq="osascript -e 'tell application \"Telegram\" to quit'"

######
alias wa="networksetup -setairportpower en0 on && open -a WhatsApp.app"
alias waq="osascript -e 'tell application \"WhatsApp.app\" to quit'"

######
alias as="open -a 'Android Studio.app'"
alias asq="osascript -e 'tell application \"Android Studio.app\" to quit'"

######
alias vs="open -a 'Visual Studio Code'"
alias vsq="osascript -e 'tell application \"Visual Studio Code\" to quit'"

######
alias se="open -a 'Script Editor.app'"

######
alias text="open -a 'TextEdit.app'"

######
alias nt="open -a Notes" ; alias ntq="pkill Notes"

######
alias pv="cd ~/documents/books/ && open -a 'Preview.app' $1"

######
alias io="open -a 'ImageOptim.app'"

######
STYLE="$(tput bold)" # "[1"

BLINK="$(tput blink)"

COLOR="$(tput setaf 047)" # серый= 8, 010; малиновый= 171; сиреневый= 071; голубой= 047

RESET="$(tput sgr0)" # сбросить атрибуты "[0"

home_() { clear && echo "    ${STYLE}${COLOR}${HOME##*/}${RESET}" && ls -F ; }

_pwd() {
    clear && echo "    ${STYLE}${COLOR}${PWD}${RESET}" &&
    ls -Fla | sort -r
} 
#-1Fa ; } #ls -x #ls -Fla | awk '{print $0, $11}' | sort -r
#gls -lhF --group-directories-first -lia ; }

path_test() { [ $PWD == $HOME ] && home_ || _pwd ; }

######
lk() {
    if test -e "$1" -a "$2" ; then
        ln -s "$1" "$2" && path_test
    elif test $# != "" ; then
        case "$1" in
            -h ) ln -s "$PWD" ~/"$2" && printf "\n  $?\n" ;;
            -d ) ln -s "$PWD" ~/desktop/"$2" && printf "\n  0\n" || printf "\n  1\n" ;;
             * ) printf "\n\e[1;31m  п у т ь   н е и з в е с т е н\e[0m\n" ;;
        esac
    fi
}

######
alias c="clear" ; alias h="export HISTTIMEFORMAT=' %T   ' ; history"

ch() {
    cd ~ ; rm -fr .ds_store .bash_sessions .bash_history .mysql_history .sqlite_history .viminfo
    rm -fr .zshrc .zprofile .zsh_sessions .zsh_history .zcompdump ; history -c
    cd - ; path_test
}

ch_() {
    cd ~ ; rm -fr .ds_store .bash_sessions .bash_history .mysql_history .sqlite_history .viminfo
    rm -fr .zshrc .zprofile .zsh_sessions .zsh_history .zcompdump ; history -c
    sudo purge # clear RAM and disk cache
    cd - ; path_test
}

######
#alias ls="gls -hF --group-directories-first"

######
md() {
    if [ -f "$1" ] ; then
        printf "\n  удалить существующий файл $1, и создать директорию $1\?\n"
        read -p "  [ yes / no ]: " ay_
        case $ay_ in
            ( [y]* ) rm "$1" && mkdir "$1" && path_test ;;
            ( [n]* ) : && path_test ;;
        esac
    elif [  -d "$1" ] ; then
        printf "\n  обнулить / открыть директорию $1\?\n"
        read -p "  [ yes / open dir / q ]: " ay_
        case $ay_ in
            ( [y]* ) rm -fr "$1" && mkdir "$1" && path_test ;;
            ( [o]* ) cd "$1" && path_test ;;
            (    * ) : && path_test ;;
        esac
    else
        mkdir "$@" && path_test
    fi
}

md_() {
    if test "$@" 
    then
        mkdir -p "$@" && cd "$@" && _pwd
    fi
}

######
df_() {
    if [ -f "$1" ] ; then
        printf "\n  удалить существующий файл $1, и создать директорию $1\?\n"
        read -p "  [ yes / no / quit ]: " ay_
        case $ay_ in
            ( [y]* ) rm "$1" && mkdir "$1" && cd "$_" && touch "$2" && vim "$2" ;;
            ( [n]* ) : && path_test ;;
        esac
    elif [ -d "$1" ] ; then
        printf "\n  обнулить / открыть директорию $1\?\n"
        read -p "  [ yes / open dir. / quit ]: " ay_
        case $ay_ in
            ( [y]* ) rm -fr "$1" && mkdir "$1" && cd "$_" && path_test ;;
            ( [o]* ) cd "$1" && path_test ;;
            (    * ) : && path_test ;;
        esac
    else
        mkdir "$1" && cd "$1" && touch "$2" ; vim "$2"
    fi
}

######
cm() { modify="$1" ; file="$2" ; chmod $modify $file && path_test ; }

######
tf_() { touch "$1" && vim "$1" ; }

tf() {
    if [ -d "$1" ] ; then
        printf "\n  существует директория $1, удалить и создать файл $1?"
        printf "\n  выберите exit, чтобы отменить.\n"
        read -p "  создать [ file ][ +xf ], создать и открыть [ vf ][ +vf ]: " ay_
        case $ay_ in
            ( [f]* ) rm -fr "$1" && touch "$@" && path_test ;;
            (  +xf ) rm -fr "$1" && touch "$@" && chmod +x "$1" && path_test ;;
            (   vf ) rm -fr "$1" && touch "$1" && vim "$1" ;;
            (  +vf ) rm -fr "$1" && touch "$1" && chmod +x "$1" && vim "$1" ;;
                 * ) : && path_test ;;
        esac
    elif [ -f "$1" ] ; then
        printf "\n  существует файл $1.\n  добавить [ add ], обнулить [ rec ], изменить [ +x ][ -x ],\n"
        read -p "  изменить и открыть [ +xv ][ -xv ]: " ay_
        case $ay_ in
            ( [a]* ) >> "$1" && vim "$1" ;;
            ( [r]* ) > "$1" && vim "$1" ;;
            (   +x ) chmod +x "$1" && path_test ;;
            (   -x ) chmod -x "$1" && path_test ;;
            (  +xv ) chmod +x "$1" && vim "$1" ;;
            (  -xv ) chmod -x "$1" && vim "$1" ;;
                 * ) : && path_test ;;
        esac
    elif [ $1 ] ; then
        echo
        read -p "  создать файл [ file ][ +xf ], создать и открыть [ vf ][ +vf ]: " ay_
        case $ay_ in
            ( [f]* ) touch "$@" && path_test ;;
            (  +xf ) touch "$@" && chmod +x "$1" && path_test ;;
            (   vf ) touch "$1" && vim "$1" ;;
            (  +vf ) touch "$1" && chmod +x "$1" && vim "$1" ;;
                 * ) : && path_test ;;
        esac
    else
        printf "\n\e[1;31m  п у т ь   н е и з в е с т е н\e[0m\n"
   fi
}

######
cf() {
    if [ -e "$1" -a "$2" ] ; then
        file_=$1 ; shift
        for copy_ in "$@" ; do
            cp -rpv $file_ $copy_
        done ;
    elif [ -e "$1" ] ; then
        cp -rpv "$1" "$1-copy" && path_test
    else
        printf "\n\e[1;31m  п у т ь   н е и з в е с т е н\e[0m\n"
    fi
}

cf_() { # inside
    if [ "$PWD" != $HOME ] ; then
        for dir_ in "$2"*/ ; do
            cp -nrpv "$1" "$dir_"
        done
    else
        printf "\n\e[1;31m  о т к а з а н о\e[0m\n"
    fi
}

######
mf() {
    if [ -e "$1" -a "$2" ] ; then
        echo ; read -p "  [ move ->file / ->dir. / quit<- ]: " ay_
        case $ay_ in
            [f]* ) [ -f "$1" ] &&
                mv "$1" "$2" && path_test || { rm -fr "$1" && touch "$2" ; path_test ; } ;;
            [d]* ) [ -d "$1" ] &&
                mv "$1" "$2" && path_test || { rm "$1" && mkdir "$2" ; path_test ; } ;;
               * ) path_test ;;
        esac
    else
        printf "\n\e[1;31m  п у т ь   н е и з в е с т е н\e[0m\n"
    fi
}

######
r() {
    if [ "$PWD" == $HOME ] ; then
        if [ -e "$1" -o -h "$1" ] ; then
            printf "\n\e[1;31m  п о д т в е р д и т ь   у д а л е н и е\e[0m\n"
            printf "\n\e[1;31m  [ yes /\e[0m ${BLINK}${COLOR}NO${RESET}\e[1;31m ] \e[0m\n"
            printf "${PS1}" && read ay_
            case $ay_ in
               yes )
                 rm -fr "$@" && path_test &&
                   { for link_ in "$@" ; do
                     unlink $link_ ; shift
                     done ; } ; path_test ;;
                 * )
                   printf "\n  произведена отмена команды\n" && sleep 3 && path_test ;;
            esac
        else
            printf "\n\e[1;31m  т р е б у е т с я   и м я   с у щ е с т в у ю щ е г о   ф а й л а\e[0m\n"
        fi
    else
        if [ -e "$1" -o -h "$1" ] ; then
            rm -fr "$@" && path_test &&
              { for link_ in "$@" ; do
                unlink $link_ ; shift
                done ; }
            path_test
        elif [ -n $# ] ; then
            case "$1" in
              d- )
                rm -fr "$PWD"/* && path_test ;;
              -d )
                dir_=$(PWD) ; cd .. && rm -fr $dir_ && path_test ;;
               * )
                printf "\n\e[1;31m  т р е б у е т с я   и м я   с у щ е с т в у ю щ е г о   ф а й л а\e[0m\n"
                printf "\n\e[1;31m  и л и   ф л а г\e[0m ${STYLE}${COLOR}( -d/d- )${RESET}\n"
            esac
        fi
    fi
}

######
sf() { cd / ; test "$@" && { cd "$@" && path_test ; } || path_test ; }

f() { 
    cd ~
    if [ -e "$@" ]
        then cd "$@" && path_test
    elif [ ! -e "$@" ]
        then printf "\n\e[1;31m  п у т ь   н е и з в е с т е н\e[0m\n"
    else home_ 
    fi
}

f_() { test "$@" && { cd "$@" && _pwd ; } || { _pwd ; } ; }

_f() { cd .. && path_test ; } ; alias ..="cd .. && path_test"

_() { _f ; local _f2 ; _f2() { _f ; } ; _f2 ; }

######
