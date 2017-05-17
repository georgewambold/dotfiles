################# ALIASES/CLI COMMANDS #################

################# iLoan shortcuts #################
alias rolo="cd ~/Desktop/iLoan/rolodex"
alias consumer="cd ~/Desktop/iLoan/consumer"
alias folio="cd ~/Desktop/iLoan/folio"

################# Folder shortcuts #################
alias ds="cd $HOME/Desktop"
alias bashp="vim /Users/gwambold/.bash_profile"

################# Command shortcuts #################
alias e="sublime"
alias v="vim"
alias be="bundle exec"
alias o='open'
alias ..="cd .."
alias lsa="ls -aF"
alias ls='ls -FGh'
alias sl="ls"
alias cls="killall Terminal"
alias rst="bash --login"
################# Rails shortcuts #################
alias reset_db='be rake db:terminate db:drop db:create db:migrate db:seed'

################# Git Shortcuts #################
alias g='git'
alias gs='git status '
alias sg='git status '
alias gb='git branch '
alias gl='git log '
alias ga='git add '
alias gc='git checkout '
alias gc-='gc -'
alias gd='git diff'
alias gst='git stash'
alias gcm='git checkout master '
alias gp='git pull '
alias gmp='gcm; gp; gc -;'

################# Convenience #################

alias cwd="echo -n $(pwd) | pbcopy; echo \"Copied '$(pwd)' \""
alias wifi="networksetup -setairportpower en0 off && networksetup -setairportpower en0 on"
alias speed="speedtest_cli"

treeFunction() {
  tree -L $1 $2
}

alias tree=treeFunction

################# RESTular #################

alias rest="cd /Users/georgewambold/Desktop/George/RESTular"
alias restsync="gsutil rsync -r -d -x '.git|.DS_Store|resources/.DS_Store' /Users/georgewambold/Desktop/George/personal_projects/RESTular gs://www.restular.com"

################# Nine Months Before #################

alias nine="cd /Users/georgewambold/Desktop/George/NineMonthsBefore"
alias ninesync="gsutil rsync -r -d -x '.git|.DS_Store|resources/.DS_Store' /Users/georgewambold/Desktop/George/NineMonthsBefore gs://www.ninemonthsbefore.com"

################# Pitch #################

alias pitch="cd /Users/georgewambold/Desktop/George/pitch"
alias pios="cd /Users/georgewambold/Desktop/George/pitch/pitch_ios"
alias papp="cd /Users/georgewambold/Desktop/George/pitch/pitch_app"
