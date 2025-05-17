export ZSH="$HOME/.oh-my-zsh"

source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/plugins/zsh-z/zsh-z.plugin.zsh

#set history size
export HISTSIZE=10000
#save history after logout
export SAVEHIST=10000
#append into history file
setopt INC_APPEND_HISTORY
#save only one command if 2 common are same and consistent
setopt HIST_IGNORE_DUPS

# get machine's ip address
alias ip="ipconfig getifaddr en0"

# edit global zsh configuration
alias zshconfig="vim ~/.zshrc"

# edit global vim configuration

alias vimconfig="vim ~/.config/nvim"

alias termconfig="vim ~/.config/wezterm/wezterm.lua"

# reload zsh configuration
alias zshsource="source ~/.zshrc"
# reload zsh configuration
alias ohmyzsh="cd ~/.oh-my-zsh"

# navigate to global ssh directory
alias sshhome="cd ~/.ssh"
# edit global ssh configuration
alias sshconfig="vim ~/.ssh/config"

alias kubeconfig="vim ~/.kube/config"

#use batcat instead of cat
alias cat="bat"

alias ls="eza"
# edit global git configuration
alias gitconfig="vim ~/.gitconfig"

alias k="kubectl"

alias vim="nvim"

alias vi="nvim"

alias find="fd"

alias grep="rg"

alias java20="export JAVA_HOME=/opt/homebrew/opt/openjdk && export PATH=/opt/homebrew/opt/openjdk/bin:$PATH"

alias java17="export JAVA_HOME=/opt/homebrew/opt/openjdk@17 && export PATH=/opt/homebrew/opt/openjdk@17/bin:$PATH"

alias java11="export JAVA_HOME=/opt/homebrew/opt/openjdk@11 && export PATH=/opt/homebrew/opt/openjdk@11/bin:$PATH"

alias imgcat="wezterm imgcat"

alias gd="git diff"

alias gt="git status"

alias gs="git switch"

# load zsh-completions
autoload -U compinit && compinit

source <(kubectl completion zsh)
source <(bevy completions zsh)

source /opt/homebrew/opt/nvm/nvm.sh

export KUBE_EDITOR="nvim"

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

export JAVA_HOME="/opt/homebrew/opt/openjdk"

export PATH="$HOME/dev/tools/apache-maven-3.9.2/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"

export PATH="$HOME/.go/bin:$PATH"

export PATH="$HOME/dev/integon/intern/tools:$PATH"

export PATH="/opt/homebrew/anaconda3/bin:$PATH"

export GOBIN="$HOME/.go/bin"

export BAT_THEME="gruvbox-dark"

#export CC="/opt/homebrew/bin/gcc-12"
#export CXX="/opt/homebrew/bin/g++-12"

#export CMAKE_C_COMPILER="/opt/homebrew/bin/gcc-12"
#export CMAKE_CXX_COMPILER="/opt/homebrew/bin/g++-12"

# use starship theme (needs to be at the end)
eval "$(starship init zsh)"
export GPG_TTY=$(tty)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
