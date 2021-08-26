################# ALIASES/CLI COMMANDS #################
################# python aliases #################
#alias p3="ipython3"
#alias ip="ipython3"
#alias python="python3"

################# Folder shortcuts #################
alias desk="cd $HOME/Desktop"
alias bashp="vim /Users/gwambold/.bash_profile"
################# Command shortcuts #################
alias e="sublime"
alias v="vim"
alias vom="vim"
alias be="bundle exec"
alias o='open'
alias ..="cd .."
alias lsa="ls -aF"
alias ls='ls -FGh'
alias sl="ls"
alias cls="killall Terminal"
alias rst="bash --login"
alias killscreen="screen -ls | grep Detached | cut -d. -f1 | awk '{print $1}' | xargs kill"
################# Rails shortcuts #################
alias reset_db='be rake db:drop db:create db:migrate db:seed'
################# Heroku Shortcuts #################
alias h='heroku'
################# Git Shortcuts #################
alias g='git'
alias gs='git status '
alias sg='git status '
alias gb='git branch --sort=-committerdate'
alias ga='git add '
alias gc='git checkout '
alias gc-='gc -'
alias gd='git diff'
alias dg='git diff'
alias gst='git stash'
alias gcm='git checkout master'
alias gcp='git checkout production'
alias gp='git pull '
alias gf='git fetch'
alias gpm='gcm; gp; gc -;'
alias gl="git log"
alias grs="git reset --soft head~1;git reset head ."
################# Convenience #################
alias cwd="echo -n $(pwd) | pbcopy; echo \"Copied '$(pwd)' \""
alias wifi="networksetup -setairportpower en1 off && networksetup -setairportpower en1 on"
alias speed="speedtest-cli"

treeFunction() {
  tree -L $1 $2
}

regenTags() {
  if `gem list ripper-tags -i`
  then
    #do nothing
  else
    gem install ripper-tags
  fi
  ripper-tags -R --extra=q
}

alias tree=treeFunction
