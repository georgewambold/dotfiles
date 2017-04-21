# Display on login
echo "Loading ~/dotfiles/etc/.bashrc"
echo "Logged in at $(hostname) as:"
echo $USER | figlet |lolcat

# Setup case insensitive autocomplete
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

# Rbenv autocomplete and shims
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Path for RBENV
test -d "$HOME/.rbenv/" && PATH="$HOME/.rbenv/bin:$PATH"

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Path for brew
test -d /usr/local/bin && export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"
# Path for Heroku
test -d /usr/local/heroku/ && export PATH="/usr/local/heroku/bin:$PATH"

# Load git completions
git_completion_script=/usr/local/etc/bash_completion.d/git-completion.bash
test -s $git_completion_script && source $git_completion_script

# A more colorful prompt
# \[\e[0m\] resets the color to default color
c_reset='\[\e[0m\]'
#  \e[0;31m\ sets the color to red
c_path='\[\e[0;31m\]'
# \e[0;32m\ sets the color to green
c_git_clean='\[\e[0;32m\]'
# \e[0;31m\ sets the color to red
c_git_dirty='\[\e[0;31m\]'

# PS1 is the variable for the prompt you see everytime you hit enter
PROMPT_COMMAND=$PROMPT_COMMAND' PS1="${c_path}\W${c_reset}$(git_prompt) $ "'

# determines if the git branch you are on is clean or dirty
git_prompt ()
{
  # Is this a git directory?
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    return 0
  fi
  # Grab working branch name
  git_branch=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
  # Clean or dirty branch
  if git diff --quiet 2>/dev/null >&2; then
    git_color="${c_git_clean}"
  else
    git_color=${c_git_dirty}
  fi
  if (( ${#git_branch} > 0 )); then
    echo " [$git_color$git_branch${c_reset}]"
  fi
}

# Autocomplete for git branches/commands
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Colors ls should use for folders, files, symlinks etc, see `man ls` and
# search for LSCOLORS
export LSCOLORS=ExGxFxdxCxDxDxaccxaeex

# Force grep to always use the color option and show line numbers
export GREP_OPTIONS='--color=always'

# Set vim as the default in terminal editor
export EDITOR="vi"

# Set path to gsutil
export PATH=${PATH}:$HOME/Library/gsutil


################# ALIASES/CLI COMMANDS #################

################# iLoan shortcuts #################
export PATH="$PATH:$HOME/Desktop/iLoan/release"
export PATH=~/Desktop/iLoan/guides/monocool:$PATH
alias rolo="cd ~/Desktop/iLoan/rolodex"
alias consumer="cd ~/Desktop/iLoan/consumer"
alias folio="cd ~/Desktop/iLoan/folio"

################# Folder shortcuts #################
alias ds="cd /Users/georgewambold/Desktop"
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

################# Git Shortcuts #################
alias g='git'
__git_complete g __git_main
alias gs='git status '
alias sg='git status '
alias gb='git branch '
alias gl='git log '
alias ga='git add '
alias gc='git checkout '
__git_complete gc _git_checkout
alias gc-='gc -'
alias gd='git diff'
__git_complete gd _git_diff
alias gst='git stash'
__git_complete gst _git_stash
alias gcm='git checkout master '
alias gp='git pull '
__git_complete gp _git_pull
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
export PATH="/usr/local/opt/postgresql@9.5/bin:$PATH"
