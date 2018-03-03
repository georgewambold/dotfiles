# Display on login
echo "Logged in at $(hostname) as:"
echo $USER | figlet |lolcat

# Source aliases

bash_aliases_path=~/dotfiles/etc/.bash_aliases
source $bash_aliases_path
echo "sourcing .bash_aliases from: $bash_aliases_path"

# Source .powconfig
source ~/.powconfig

# Setup case insensitive autocomplete
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

# Rbenv autocomplete and shims
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Path for RBENV
test -d "$HOME/.rbenv/" && PATH="$HOME/.rbenv/bin:$PATH"

# Export dir for java binary files/projects
export JAVA_HOME=$(/usr/libexec/java_home)


# Path for PostgreSQL
test -d /usr/local/opt/postgresql@9.5/bin && export PATH=/usr/local/opt/postgresql@9.5/bin:$PATH

# Path for Heroku
test -d /usr/local/heroku/ && export PATH="/usr/local/heroku/bin:$PATH"

# Path for qt5.5 and qmake
export PATH="/usr/local/opt/qt@5.5/bin:$PATH"

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

# Git author name
export GIT_AUTHOR_NAME="George Wambold"

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

# Load git completions
test -e ~/dotfiles/git/git-completion.bash && source ~/dotfiles/git/git-completion.bash

#Autocomplete for git command aliases
__git_complete g __git_main
__git_complete gc _git_checkout
__git_complete gd _git_diff
__git_complete gst _git_stash
__git_complete gp _git_pull

# Colors ls should use for folders, files, symlinks etc, see `man ls` and
export LSCOLORS=ExGxFxdxCxDxDxaccxaeex

# Set vim as the default in terminal editor
export EDITOR="vim"

# Set path to gsutil
export PATH=${PATH}:$HOME/Library/gsutil

# Set path for node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Export monocool shit
export PATH=~/Desktop/iLoan/guides/monocool:$PATH
