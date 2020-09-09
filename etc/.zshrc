# Display on login
echo "Logged in at $(hostname) as:"
echo $USER | figlet |lolcat

# Source aliases

bash_aliases_path=~/dotfiles/etc/.bash_aliases
source $bash_aliases_path
echo "sourcing .bash_aliases from: $bash_aliases_path"

git_autocomplete_path=~/dotfiles/git/git-completion.bash
echo "sourcing git_auto_complete from: $git_autocomplete_path"
source $git_autocomplete_path

 # load + start compinit
autoload -U compinit && compinit

# automatic cd into directory
setopt autocd

# correct if completion is no possible
zstyle ':completion:*' completer _complete _approximate

# Source .powconfig
source ~/.powconfig

# Rbenv autocomplete and shims
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Export dir for java binary files/projects
export JAVA_HOME=$(/usr/libexec/java_home)

# Path for qt5.5 and qmake
export PATH="/usr/local/opt/qt@5.5/bin:$PATH"

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
  git_branch=$(git symbolic-ref HEAD | cut -d'/' -f3)
  # Clean or dirty branch
  if git diff --quiet 2>/dev/null >&2; then
    git_color="%F{green}"
  else
    git_color="%F{red}"
  fi
  if (( ${#git_branch} > 0 )); then
    echo "%f[$git_color$git_branch%f] "
  fi
}

# prompt string is first subjected to parameter expansion, command substitution and arithmetic expansion.
setopt PROMPT_SUBST

# PS1 is the variable for the prompt you see everytime you hit enter
PROMPT='%F{red}%1~ $(git_prompt)%f$ '

# Colors ls should use for folders, files, symlinks etc, see `man ls` and
export LSCOLORS=ExGxFxdxCxDxDxaccxaeex

# Set vim as the default in terminal editor
export EDITOR="vim"

# Set path to gsutil
export PATH=${PATH}:$HOME/Library/gsutil

export PATH="/Users/georgewambold/.pyenv/bin:$PATH" #add pyenv to PATH
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
