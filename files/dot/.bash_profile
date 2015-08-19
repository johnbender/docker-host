# docker
docker_prefix="d"
alias "$docker_prefix"b='docker build --force-rm'
alias "$docker_prefix"cln='docker ps -a | grep "Exited ([^0]*)" | cut -d" " -f1 | xargs -n1 docker rm'
alias "$docker_prefix"clni='docker rmi $(docker images -q -f dangling=true)'
alias "$docker_prefix"i='docker images'
alias "$docker_prefix"ps='docker ps'
alias "$docker_prefix"psa='docker ps -a'
alias "$docker_prefix"rmall="dpsa | cut -d' ' -f1 | tail -n +2 | xargs -n1 docker rm -f"
alias dc='docker-compose'

# git aliases
alias gs='git status -sb'
alias ga='git add'
alias gc='git commit'
alias gd='git diff'
alias gp='git push'
alias gcp='git cherry-pick'
alias gco='git checkout'
alias gcp='git cherry-pick'
alias grec='git-reconcile'

# prompt
BROWN="\[\033[0;33m\]"
PS_CLEAR="\[\033[0m\]"
BLUE="\[\033[0;34m\]"

# TODO find git parent directory
parse_git_branch() {
  [ -d .git ] || return 1
  git symbolic-ref HEAD 2> /dev/null | sed 's#\(.*\)\/\([^\/]*\)$# \2#'
}

prompt_color() {
  PS1="\u@$(hostname -f) ${BLUE}\W${BROWN}\$(parse_git_branch)${PS_CLEAR} : "
  PS2="\[[33;1m\]continue \[[0m[1m\]> "
}

# Prevent "dumb" terminals from getting colors, e.g. Tramp
if [ $TERM != "dumb" ] && [ -n "$PS1" ]; then
  prompt_color
  # eval `dircolors ~/.dir_colors`
  # alias ls='ls --color=auto'
fi
