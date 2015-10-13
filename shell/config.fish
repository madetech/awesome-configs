function subl; /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl $argv; end

function prepend_to_path -d "Prepend the given dir to PATH if it exists and is not already in it"
    if test -d $argv[1]
        if not contains $argv[1] $PATH
            set -gx PATH "$argv[1]" $PATH
        end
    end
end

prepend_to_path "$HOME/.rbenv/bin"        
prepend_to_path "$HOME/.rbenv/shims"       
prepend_to_path "/usr/local/bin"                
prepend_to_path "/usr/local/sbin"

rbenv rehash >/dev/null ^&1				
set -g -x fish_greeting ''

function git_prompt
    if git root >/dev/null 2>&1
        set_color normal
        printf ' on '
        set_color magenta
        printf '%s' (git currentbranch ^/dev/null)
        set_color normal
    end
end

function hg_prompt
    if hg root >/dev/null 2>&1
        set_color normal
        printf ' on '
        set_color magenta
        printf '%s' (hg branch ^/dev/null)
        set_color normal
    end
end

function fish_prompt
	set_color $fish_color_cwd
    printf '%s' (prompt_pwd)
    set_color normal

	git_prompt
	hg_prompt

	echo ' >: '
end
