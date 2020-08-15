# ---[ System ]--------------------------------------------------------

limit -s coredumpsize 0
umask 0027

case `uname` in
  Darwin)
    # commands for OS X go here
  ;;
  Linux)
    # commands for Linux go here
  ;;
  FreeBSD)
    # commands for FreeBSD go here
  ;;
esac

# ---[ Modules ]-------------------------------------------------------

zmodload -i zsh/complist
autoload -Uz compinit && compinit

# ---[ Functions ]-----------------------------------------------------

codi() {
  local syntax="${1:-python}"
  shift
  nvim -c "Codi $syntax $@" -c "autocmd! CustomGroup" -c "set bt=nofile ls=0 noru nonu nornu"
}

web-search() {
  # get the open command
  local open_cmd
  [[ "$OSTYPE" = linux* ]] && open_cmd='xdg-open'
  [[ "$OSTYPE" = darwin* ]] && open_cmd='open'

  pattern='(google|duckduckgo|bing|yahoo|github|youtube)'

  # check whether the search engine is supported
  if [[ $1 =~ pattern ]];
  then
    echo "Search engine $1 not supported."
    return 1
  fi

  local url
  [[ "$1" == 'yahoo' ]] && url="https://search.yahoo.com" || url="https://www.$1.com"

  # no keyword provided, simply open the search engine homepage
  if [[ $# -le 1 ]]; then
    $open_cmd "$url"
    return
  fi

  typeset -A search_syntax=(
    google     "/search?q="
    bing       "/search?q="
    github     "/search?q="
    duckduckgo "/?q="
    yahoo      "/search?p="
    youtube    "/results?search_query="
  )

  url="${url}${search_syntax[$1]}"
  shift   # shift out $1

  while [[ $# -gt 0 ]]; do
    url="${url}$1+"
    shift
  done

  url="${url%?}" # remove the last '+'
  nohup $open_cmd "$url" &> /dev/null
}

up() {
  if [[ "$#" -ne 1 ]]; then
    cd ..
  elif ! [[ $1 =~ '^[0-9]+$' ]]; then
    echo "Error: up should be called with the number of directories to go up. The default is 1."
  else
    local d=""
    limit=$1
    for ((i=1 ; i <= limit ; i++))
      do
        d=$d/..
      done
    d=$(echo $d | sed 's/^\///')
    cd $d
  fi
}

sudo-command-line() {
  [[ -z $BUFFER ]] && zle up-history
  if [[ $BUFFER == sudo\ * ]]; then
      LBUFFER="${LBUFFER#sudo }"
  elif [[ $BUFFER == $EDITOR\ * ]]; then
      LBUFFER="${LBUFFER#$EDITOR }"
      LBUFFER="sudoedit $LBUFFER"
  elif [[ $BUFFER == sudoedit\ * ]]; then
      LBUFFER="${LBUFFER#sudoedit }"
      LBUFFER="$EDITOR $LBUFFER"
  else
      LBUFFER="sudo $LBUFFER"
  fi
}

nohup-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == nohup\ * ]]; then
        BUFFER="${BUFFER#nohup }"
        BUFFER="${BUFFER%\ &\>*}"
    else
		base="${BUFFER#sudo }"
		tokens_slash=("${(@s|/|)base}")
		tokens_space=("${(@s/ /)tokens_slash[-1]}")
		command=("$tokens_space[1]")
		
		BUFFER="nohup $BUFFER &> $command.out &!"
    fi
}

run-again() {
  zle up-history
  zle accept-line
}

man() {
	env \
		LESS_TERMCAP_md=$(tput bold; tput setaf 4) \
		LESS_TERMCAP_me=$(tput sgr0) \
		LESS_TERMCAP_mb=$(tput blink) \
		LESS_TERMCAP_us=$(tput setaf 2) \
		LESS_TERMCAP_ue=$(tput sgr0) \
		LESS_TERMCAP_so=$(tput smso) \
		LESS_TERMCAP_se=$(tput rmso) \
		PAGER="${commands[less]:-$PAGER}" \
		man "$@"
}

# ---[ ZLE ]---------------------------------------------------------

zle -N sudo-command-line
zle -N nohup-command-line
zle -N run-again

# ---[ Plugins ]-----------------------------------------------------

source ~/.config/zsh/plugins/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/.config/zsh/plugins/zsh-abbr/zsh-abbr.zsh
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/plugins/zsh-colorize/colorize.plugin.zsh
source ~/.config/zsh/plugins/zsh-command-time/command-time.plugin.zsh
source ~/.config/zsh/plugins/zsh-going-places/places.plugin.zsh
source ~/.config/zsh/plugins/zsh-plugin-appup/appup.plugin.zsh
source ~/.config/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh
source ~/.config/zsh/plugins/zsh-iterm2-integration/iterm2-shell-integration.zsh

# ---[ Variables ]----------------------------------------------------

FAVPATH=$HOME/.config/zsh/favorites
HISTFILE=$HOME/.config/zsh/history
HISTSIZE=100000
SAVEHIST=$HISTSIZE
WORDCHARS=''
ZLS_COLORS=''
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_COMMAND_TIME_COLOR="yellow"
ZSH_COMMAND_TIME_MIN_SECONDS=5
ZSH_COMMAND_TIME_MSG="Execution time: %s sec"

# ---[ ZSH Options ]--------------------------------------------------

# If unset, the cursor is set to the end of the word if completion is
# started. Otherwise it stays there and completion is done from both ends.
# This is needed for the prefix completer
setopt COMPLETE_IN_WORD
# don't move the cursor to the end AFTER a completion was inserted
setopt COMPLETE_ALIASES
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_REDUCE_BLANKS HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY EXTENDED_HISTORY HIST_IGNORE_DUPS HIST_FIND_NO_DUPS
setopt LIST_PACKED
setopt MULTIOS CORRECT_ALL AUTO_CD
setopt NO_ALWAYS_TO_END
setopt NO_BEEP CLOBBER
setopt SHARE_HISTORY
setopt promptsubst

# ---[ ZSH Styles ]---------------------------------------------------

# for use with expand-or-complete-prefix :
# zstyle ':completion:*' completer _complete _match _list _ignored _correct _approximate
# for use with expand-or-complete :
zstyle ':completion:*' completer _complete _match _prefix:-complete _list _correct _approximate _prefix:-approximate _ignored
# _list anywhere to the completers always only lists completions on first tab
zstyle ':completion:*:prefix-complete:*' completer _complete
zstyle ':completion:*:prefix-approximate:*' completer _approximate
# configure the match completer, more flexible of GLOB_COMPLETE
# with original set to only it doesn't act like a `*' was inserted at the cursor position
zstyle ':completion:*:match:*' original only
# first case insensitive completion, then case-sensitive partial-word completion, then case-insensitive partial-word completion
# (with -_. as possible anchors)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[-_.]=* r:|=*' 'm:{a-z}={A-Z} r:|[-_.]=* r:|=*'
# allow 2 erros in correct completer
zstyle ':completion:*:correct:*' max-errors 2 not-numeric
# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) numeric )'
# menu selection with 2 candidates or more
zstyle ':completion:*' menu select=2
# zstyle ':completion:*' menu select=1 _complete _ignored _approximate
# Case insensitive completions
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
# Messages/warnings format
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format $'%{\e[01;31m%}---- %d%{\e[m%}'
zstyle ':completion:*:messages' format $'%{\e[01;04;31m%}---- %d%{\e[m%}'
zstyle ':completion:*:warnings' format $'%{\e[01;04;31m%}---- No matches for: %d%{\e[m%}'
zstyle ':completion:*:corrections' format $'%{\e[0;31m%}%d (errors: %e)%{\e[m%}'
# make completions appear below the description of which listing they come from
# zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' select-prompt %SScrolling active: current selection at %p%s
# You can use a cache in order to proxy the list of results:
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.config/zsh/cache
# complete man pages
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
# ignore uninteresting user accounts
zstyle ':completion:*:*:*:users' ignored-patterns \
    adm apache avahi avahi-autoipd backup bind bin cl-builder colord couchdb daemon dictd festival \
    games gdm gnats haldaemon halt hplip ident identd irc jetty junkbust kernoops libuuid lightdm \
    list lp mail mailnull man messagebus named news nfsnobody nobody nscd ntp operator pcap postfix \
    postgres proxy pulse radvd rpc rpcuser rpm rtkit saned shutdown speech-dispatcher squid sshd \
    statd stunnel4 sync sys syslog uucp usbmux vcsa vde2-net www-data xfs
# ignore uninteresting hosts
zstyle ':completion:*:*:*:hosts' ignored-patterns \
    localhost loopback ip6-localhost ip6-loopback localhost6 localhost6.localdomain6 localhost.localdomain
# tab completion for PID
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
# If you end up using a directory as argument, this will remove the trailing slash (usefull in ln):
# zstyle ':completion:*' squeeze-slashes true
# cd will never select the parent directory (e.g.: cd ../<TAB>):
zstyle ':completion:*:(cd|mv|cp):*' ignore-parents parent pwd
zstyle ':completion:*:(ls|mv|cd|chdir|pushd|popd):*' special-dirs ..
# ignores filenames already in the line
zstyle ':completion:*:(rm|kill|diff):*' ignore-line yes
# Ignore completion functions for commands you don't have:
zstyle ':completion:*:functions' ignored-patterns '_*'
# don't complete backup files as executables
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'
# A newly added command will may not be found or will cause false
# correction attempts, if you got auto-correction set. By setting the
# following style, we force accept-line() to rehash, if it cannot
# find the first word on the command line in the $command[] hash.
zstyle ':acceptline:*' rehash true

# ---[ Alias Section ]-----------------------------------------------

# alias cat='bat -p'
alias df='df -h'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
# alias lh='exa -lha'
# alias la='exa -a'
# alias ll='exa -lh'
# alias ls='exa'
alias pa='ps aux'
alias pu='pushd'
# alias vim='nvim'
alias mkdir='mkdir -p'
alias bing='web-search bing'
alias google='web-search google'
alias yahoo='web-search yahoo'
alias ddg='web-search duckduckgo'
alias github='web-search github'
alias youtube='web-search youtube'

# ---[ Key bindings ]------------------------------------------------

set -o emacs

bindkey -M menuselect '^o' accept-and-infer-next-history
bindkey -M menuselect '^G' send-break
bindkey "\e\e" sudo-command-line
bindkey -M vicmd '\e\e' sudo-command-line
bindkey '^?' backward-delete-char
bindkey '^ ' run-again

# ---[ Prompt ]------------------------------------------------------

NT_PROMPT_SYMBOL=❯

PROMPT='%(?.%F{red}${NT_PROMPT_SYMBOL}%F{yellow}${NT_PROMPT_SYMBOL}%F{green}${NT_PROMPT_SYMBOL}%f.%F{red}${NT_PROMPT_SYMBOL}%F{yellow}${NT_PROMPT_SYMBOL}%F{green}${NT_PROMPT_SYMBOL}%f) '
RPROMPT='%F{cyan}%(5~|%-1~/.../%2~|%4~) '

