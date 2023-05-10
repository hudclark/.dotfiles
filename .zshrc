# If you come from bash you might have to change your $PATH.
export PATH=/usr/local/share/scala-2.13.3/bin:/usr/local/go/bin:/home/hudson/.local/share/coursier/bin:/home/hudson/go/bin:/home/hudson/bin:$PATH

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH=/usr/lib/jvm/graalvm-ce-java11-20.1.0/bin:$PATH
export JAVA_HOME=/usr/lib/jvm/graalvm-ce-java11-20.1.0
export SCALA_HOME=/usr/local/share/scala-2.13.3

# Path to your oh-my-zsh installation.
export ZSH="/home/hudson/.oh-my-zsh"

export TERM=xterm-256color

export EDITOR="nvim.appimage"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

fpath+=("$HOME/.nvm/versions/node/v17.4.0/lib/node_modules/pure-prompt/functions")
autoload -U promptinit; promptinit
prompt pure

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions vi-mode)

VI_MODE_SET_CURSOR=true

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vim="nvim.appimage"
alias nvim="nvim.appimage"
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias avro='java -jar ~/avro-tools-1.11.1.jar'

hex-to-base64 () {
  echo -n "$1" | xxd -r -p - | base64
}

source <(kubectl completion zsh)

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
# jenv enable-plugin export

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# https://askubuntu.com/questions/1363356/update-zoom-at-xubuntu-20-04-focal-fossa
# zoom update
if [ -n "$(command -v zoom)" ]; then
  zoom-update() {
    echo "Checking new version availability..."
    wget -nv -O "$(xdg-user-dir DOWNLOAD)"/zoom_amd64.deb 'https://us02web.zoom.us/client/latest/zoom_amd64.deb' &> /dev/null
    sudo dpkg --skip-same-version -i "$(xdg-user-dir DOWNLOAD)"/zoom_amd64.deb
    rm -f "$(xdg-user-dir DOWNLOAD)"/zoom_amd64.deb
  }
fi

# >>> scala-cli completions >>>
fpath=("/home/hudson/.local/share/scalacli/completions/zsh" $fpath)
compinit
# <<< scala-cli completions <<<
