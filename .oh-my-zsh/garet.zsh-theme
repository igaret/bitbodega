function prompt_char {
	if [ $UID = 0 ]; then
		echo #
	else
		echo $
	fi
}

function dirinfo {
	if [ "$(pwd -P)" = "$(pwd -L)" ]; then
		echo ""
	else
		echo "symlink detected: $(pwd -L) > $(pwd -P)" 
	fi
}

PROMPT='
%{$fg[magenta]%}%n%{$reset_color%}@%{$fg[yellow]%}$(hostname)%{$reset_color%}(%{$fg_bold[green]%}$(pwd -P)%{$reset_color%})$(git_prompt_info)
$(dirinfo)
$(prompt_char) '

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
