# enable colors and change prompt:
autoload -U colors && colors	# Load colors

eval "$(starship init zsh)"
# using spaceship right now, I will just comment the custom prompt out
#PROMPT="[%B%0(?.%F{2}%?%f.%F{3}%?%f)%b] %B%F{6}%n%f%b at %B%F{7}%3~%f%b $(git_super_status)%B%(#.%F{1}#%f.%F{5}$%f)%b "
# right prompt RPROMPT='<%!>'

setopt autocd		# automatically cd into typed directory.
setopt interactive_comments # type comments not only in scripts
setopt correct  # try to suggest the correct command

# history settings
# history in cache directory:
HISTSIZE=1000
SAVEHIST=1000
# don't clutter the home directory
HISTFILE=~/.cache/zsh/history
# don't record repeated lines in history
setopt histignoredups
# don't save this line if it has a space in front of the command
setopt histignorespace

# enables keys like Ctrl+A, Ctrl+K etc.
bindkey -e
# vim keys hjkl etc.
bindkey -v
# pfetch configuration
# a white colour, instead of a greyish colour
export PF_COL2=7

# what to show in pfetch
export PF_INFO="ascii os kernel uptime pkgs editor shell"

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

# source plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# auto suggestions settings
bindkey '^ ' autosuggest-accept

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# shamelessly copied from https://github.com/gokcehan/lf/blob/master/etc/lfcd.sh
tmp="$(mktemp)"
lfcd() {
  # I am so happy this actually works with lf-img!!!!!!!
  lfrun -last-dir-path="$tmp" "$@"
  if [ -f "$tmp" ]; then
      dir="$(cat "$tmp")"
      rm -f "$tmp"
      if [ -d "$dir" ]; then
          if [ "$dir" != "$(pwd)" ]; then
              cd "$dir"
          fi
      fi
  fi
}

# generate cover report for go
gocov() {
  go test -coverprofile="/tmp/c.out"
  go tool cover -html="/tmp/c.out"
}

# run all go files
alias gorun='go run $(ls -1 *.go | grep -v _test.go) "$@"'
alias gowatch='go watch go run $(ls -1 *.go | grep -v _test.go) "$@"'

alias newfile='touch "$1" && chmod +x "$1" && nvim "$1'

# cmake
alias cgen='cmake -B build -S src -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_BUILD_TYPE=Debug'
alias cmk='cmake --build build'
alias ct='ctest --test-dir build --output-on-failure'
alias cmt='cmk && ct'

# other commands
alias cdc='cd ~/Documents/sources/'
alias cdr='cd ~/Documents/repos/'
alias cdt='cd ~/Documents/tutorials/'
alias cddoc='cd ~/Documents/docs/'
alias cdwiki='cd ~/Documents/wiki/'
alias cdmd='cd ~/Documents/mdbooks/'
alias cdf='cd ~/.config/'
alias cds='cd ~/.local/share/'
alias cdp='cd ~/Pictures/'
alias cdv='cd ~/Videos/'
alias cdd='cd ~/Documents/'
alias cfv='nvim ~/.config/nvim/init.lua'
alias cfz='nvim ~/.zprofile'
alias cfzz='nvim ~/.config/zsh/.zshrc'
alias ls='exa'
alias lf='lfcd'
alias v='vscodium'
alias vv='vscodium .'
alias yt='yt-dlp -o "%(title)s.%(ext)s"'

# so that homeshick can be directly invoked in the command line
homeshick () {
  if [ "$1" = "cd" ] && [ -n "$2" ]; then
    # We want replicate cd behavior, so don't use cd ... ||
    # shellcheck disable=SC2164
    cd "$HOME/.homesick/repos/$2"
  else
    "${HOMESHICK_DIR:-$HOME/.homesick/repos/homeshick}/bin/homeshick" "$@"
  fi
}


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r "$HOME/.opam/opam-init/init.zsh" ]] || source "$HOME/.opam/opam-init/init.zsh" > /dev/null 2> /dev/null
# END opam configuration
