alias ll='ls -l'

local GREEN=$'%{\e[1;32m%}'
local BLUE=$'%{\e[1;34m%}'
local DEFAULT=$'%{\e[1;m%}'

local TXTBLK=$'%{\e[1;30m%}' # Black - Regular
local TXTRED=$'%{\e[1;31m%}' # Red
local TXTGRN=$'%{\e[1;32m%}' # Green
local TXTYLW=$'%{\e[1;33m%}' # Yellow
local TXTBLU=$'%{\e[1;34m%}' # Blue
local TXTPUR=$'%{\e[1;35m%}' # Purple
local TXTCYN=$'%{\e[1;36m%}' # Cyan
local TXTWHT=$'%{\e[1;37m%}' # White

PROMPT=$BLUE'[${USER}@${HOSTNAME}] %(!.#.$) '$DEFAULT
RPROMPT=$GREEN'[%~]'$DEFAULT
setopt PROMPT_SUBST

alias r='rails'
alias b='bundle'
alias ber='bundle exec rails'
alias to_utf8='iconv -f SHIFT_JIS -t UTF-8'
alias to_sjis='iconv -f UTF-8 -t SHIFT_JIS'

bindkey -e
export EDITOR=vim


# VCSの情報を取得するzshの便利関数 vcs_infoを使う
autoload -Uz vcs_info

# 表示フォーマットの指定
# %b ブランチ情報
# %a アクション名(mergeなど)
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

# バージョン管理されているディレクトリにいれば表示，そうでなければ非表示
GIT_BRANCH="%1(v|%F{yellow}%1v%f|)"
RPROMPT=$GIT_BRANCH$GREEN'[%~]'$DEFAULT
eval "$(rbenv init -)"

export PATH=$PATH:/Users/dan/.nodebrew/current/bin

# for mono CheeseCake
export PATH=$PATH:/Users/dan/bin
