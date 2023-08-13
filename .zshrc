export ZSH="$HOME/.oh-my-zsh"

source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/plugins/zsh-z/zsh-z.plugin.zsh


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

#use batcat instead of cat
alias cat="bat"

alias ls="exa"
# edit global git configuration
alias gitconfig="vim ~/.gitconfig"

alias k="kubectl"

alias vim="nvim"

alias vi="nvim"

alias find="rg"

# load zsh-completions
autoload -U compinit && compinit

source <(kubectl completion zsh)

source /opt/homebrew/opt/nvm/nvm.sh
# use starship theme (needs to be at the end)
eval "$(starship init zsh)"
export GPG_TTY=$(tty)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

export JAVA_HOME="/opt/homebrew/opt/openjdk"

export PATH="$HOME/dev/tools/apache-maven-3.9.2/bin:$PATH"

alias java20="export JAVA_HOME=/opt/homebrew/opt/openjdk && export PATH=/opt/homebrew/opt/openjdk/bin:$PATH"

alias java17="export JAVA_HOME=/opt/homebrew/opt/openjdk@17 && export PATH=/opt/homebrew/opt/openjdk@17/bin:$PATH"


export PATH="$HOME/.cargo/bin:$PATH"
