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

gitstatus_path=~/gitstatus/gitstatus.plugin.zsh
echo "sourcing gitstatus_complete from: $gitstatus_path"
source $gitstatus_path

 # load + start compinit
autoload -U compinit && compinit

# automatic cd into directory
setopt autocd

# correct if completion is no possible
zstyle ':completion:*' completer _complete _approximate

# Rbenv autocomplete and shims
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Path for qt5.5 and qmake
export PATH="/usr/local/opt/qt@5.5/bin:$PATH"

# Git author name
export GIT_AUTHOR_NAME="George Wambold"

# determines if the git branch you are on is clean or dirty
git_prompt ()
{
  # Is this a git directory?
  #
  if gitstatus_query MY && [[ $VCS_STATUS_RESULT == ok-sync ]]; then

    # Grab working branch name
    git_branch=$VCS_STATUS_LOCAL_BRANCH
    # Clean or dirty branch
    if [ $VCS_STATUS_HAS_CONFLICTED == 1 -o $VCS_STATUS_HAS_UNSTAGED == 1 -o $VCS_STATUS_HAS_STAGED == 1 ]; then
      git_color="%F{green}"
    else
      git_color="%F{red}"
    fi
    echo "%f[$git_color$git_branch%f] "
  fi
}
gitstatus_stop 'MY' && gitstatus_start -s -1 -u -1 -c -1 -d -1 'MY'

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

# Init rbenv
eval "$(rbenv init -)"
