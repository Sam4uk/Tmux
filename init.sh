#! /bin/bash
#╔═══════════════════════════════════════════════════════════════════════════╗
#║ Copyright © 2022 Sam4uk                                                   ║
#║                                                                           ║
#║Permission is hereby  granted, free of charge , to  any  person obtaining a║
#║copy of this software and associated documentation files  (the “Software”),║
#║to deal in the Software without  restriction, including without  limitation║
#║the  rights  to  use, copy, modify, merge, publish, distribute, sublicense,║
#║and/or  sell  copies of  the Software,  and to permit persons  to  whom the║
#║Software  is furnished  to  do  so, subject  to  the  following conditions:║
#║                                                                           ║
#║The above copyright notice and this permission  notice shall be included in║
#║all copies or substantial portions of the Software.                        ║
#║                                                                           ║
#║THE SOFTWARE IS PROVIDED “AS  IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR║
#║IMPLIED,  INCLUDING  BUT  NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,║
#║FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE║
#║AUTHORS  OR COPYRIGHT HOLDERS  BE LIABLE FOR  ANY CLAIM, DAMAGES  OR  OTHER║
#║LIABILITY, WHETHER  IN  AN  ACTION  OF CONTRACT, TORT OR OTHERWISE, ARISING║
#║FROM, OUT OF  OR IN  CONNECTION  WITH  THE  SOFTWARE  OR  THE USE  OR OTHER║
#║DEALINGS IN THE SOFTWARE.                                                  ║
#╚═══════════════════════════════════════════════════════════════════════════╝

BackUp (){
    echo "File or folder ${1} renamed ${1}.$(date +%d-%m-%y)"
    mv ${1} ${1}.$(date +%d-%m-%y)
    ln -s ${2} ${1}
    echo -e "Crated new symlink ${2}"
}
InitLink (){
    echo ${1} ${2}
    echo -e "Check existing \e[34m${1}\e[0m..."
    if [ -e ${1} ]; then
        echo -e "Path found"
        if [ -L ${1} ]; then
            echo -e "${1} is a symlink"
            echo -e "Read symlink"
            echo -e "${1} => $(readlink ${1})"
            if [ $(readlink ${1}) = ${2} ]; then
                echo -e "\e[32mSymlink OK\e[0m"
            else
                BuckUp ${2} ${1}
                echo -e "\e[32m Symlink OK\e[0m"
            fi
        else
            echo -e "Try open folder"
            if [ -d ${1} ]; then
                echo -e "${1} is a folder"
                BackUp ${2} ${1}
                echo -e "\e[32mSymlink OK\e[0m"
            else
                echo -e "${1} is a file"
                BuckUp ${2} ${1}
                echo -e "\e[32mSymlink OK\e[0m"
            fi
        fi
    else
        echo -e "Path ${1} \e[31mno exists\e[0m"
        ln -s ${2} ${1}
        echo -e "\e[32mCreate\e[0"
        echo -e "\e32mSymlink OK\e[0m"
    fi
}

InitLink $HOME/.tmux.conf $(pwd)/.tmux.conf
