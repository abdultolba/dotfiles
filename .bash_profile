[[ -s ~/.bashrc ]] && source ~/.bashrc

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
source "`brew --prefix`/etc/grc.bashrc"
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced