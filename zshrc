alias ll='ls -l'

local GREEN=$'%{\e[1;32m%}'
local BLUE=$'%{\e[1;34m%}'
local DEFAULT=$'%{\e[1;m%}'

PROMPT=$BLUE'[${USER}@${HOSTNAME}] %(!.#.$) '$DEFAULT
RPROMPT=$GREEN'[%~]'$DEFAULT
setopt PROMPT_SUBST

alias r='rails'
alias to_utf8='iconv -f SHIFT_JIS -t UTF-8'
alias to_sjis='iconv -f UTF-8 -t SHIFT_JIS'

bindkey -e
export EDITOR=vim
