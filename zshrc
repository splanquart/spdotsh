# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="dracula"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

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
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:/opt/local/bin:/opt/local/sbin:/usr/local/mysql/bin:/opt/local/bin/:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/local/git/bin:/usr/texbin"
export PATH="/opt/local/bin:/opt/local/sbin:/usr/local/mysql/bin:/opt/local/bin/:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/local/git/bin:/usr/texbin"
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

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias wo='workon'
alias gglog='git glog'

#  # pip should only run if there is a virtualenv currently activated
#  export PIP_REQUIRE_VIRTUALENV=true
#  # Function to bypass the virtualenv-required above
#  gpip(){
#     PIP_REQUIRE_VIRTUALENV="" pip "$@"
#  }

export PNAME="splanquart"
export PATH="$PATH:$HOME/Tools/git-scripts" # Add RVM to PATH for scripting

# $(boot2docker shellinit 2> /dev/null)  # use by docker


export PATH="/usr/local/bin:$PATH"
export WORKON_HOME=~/Envs
source /usr/local/bin/virtualenvwrapper.sh
export HOMEBREW_GITHUB_API_TOKEN="90b8e47d04297b2c3ada13c6b7f0c0ce191d9228"
export HOMEBREW_GITHUB_API_TOKEN="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"


# Created by `userpath` on 2020-01-06 13:54:38
export PATH="$PATH:/Users/steph/.local/bin"

export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/python/libexec/bin:/usr/local/sbin:$PATH"
#export PATH="/usr/local/opt/python@3.8/bin:$PATH"
# #For compilers to find readline you may need to set:
# export LDFLAGS="-L/usr/local/opt/readline/lib"
# export CPPFLAGS="-I/usr/local/opt/readline/include"
# 
# #For pkg-config to find readline you may need to set:
# export PKG_CONFIG_PATH="/usr/local/opt/readline/lib/pkgconfig"
eval "$(pyenv init -)"
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
pyenv virtualenvwrapper_lazy  # <--- ATTENTION : à rajouter après `eval "$(pyenv init -)"`

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi


local_stack_for_tests() {
    echo "# Starting containers..."

    # PostgreSQL
    echo "  - Starting PostgreSQL container..."
    docker run -d --rm --hostname localhost --name local-postgresql -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=root -e PGDATA=/dev/shm --shm-size=1G -p 5432:5432 postgres:11


    # RabbitMQ
    echo "  - Starting RabbitMQ container..."
    docker run -d --rm --hostname localhost --name local-rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3.7-management

    # Wait a bit for containers to be started.
    sleep 2

    echo "\n# Creating databases and users for PostgreSQL..."

    # api
    docker exec local-postgresql /bin/sh -c  "/bin/echo \"CREATE ROLE root WITH SUPERUSER CREATEDB LOGIN PASSWORD 'root';\" | psql --username postgres"
    docker exec local-postgresql /bin/sh -c  "/bin/echo \"CREATE DATABASE payplug_test WITH ENCODING = 'UTF8' OWNER = root;\" | psql --username postgres"

    # billing
    docker exec local-postgresql /bin/sh -c  "/bin/echo \"CREATE ROLE billing_app WITH SUPERUSER CREATEDB LOGIN PASSWORD 'billing_password';\" | psql --username postgres"
    docker exec local-postgresql /bin/sh -c  "/bin/echo \"CREATE DATABASE billing WITH ENCODING = 'UTF8' OWNER = billing_app;\" | psql --username postgres"

    # card
    docker exec local-postgresql /bin/sh -c  "/bin/echo \"CREATE ROLE card_app WITH SUPERUSER CREATEDB LOGIN PASSWORD 'card_password';\" | psql --username postgres"
    docker exec local-postgresql /bin/sh -c  "/bin/echo \"CREATE DATABASE payplug_card WITH ENCODING = 'UTF8' OWNER = card_app;\" | psql --username postgres"

    # bank_transfer
    docker exec local-postgresql /bin/sh -c  "/bin/echo \"CREATE ROLE bank_transfer_app WITH SUPERUSER CREATEDB LOGIN PASSWORD 'bank_transfer_password';\" | psql --username postgres"
    docker exec local-postgresql /bin/sh -c  "/bin/echo \"CREATE DATABASE bank_transfer WITH ENCODING = 'UTF8' OWNER = bank_transfer_app;\" | psql --username postgres"

    # kyc-check
    docker exec local-postgresql /bin/sh -c  "/bin/echo \"CREATE ROLE kyc_check_app WITH SUPERUSER CREATEDB LOGIN PASSWORD 'kyc_check_password';\" | psql --username postgres"
    docker exec local-postgresql /bin/sh -c  "/bin/echo \"CREATE DATABASE kyc_check WITH ENCODING = 'UTF8' OWNER = kyc_check_app;\" | psql --username postgres"

    # eksport
    docker exec local-postgresql /bin/sh -c  "/bin/echo \"CREATE ROLE eksport_app_live WITH SUPERUSER CREATEDB LOGIN PASSWORD 'eksport_password';\" | psql --username postgres"
    docker exec local-postgresql /bin/sh -c  "/bin/echo \"CREATE DATABASE eksport_live WITH ENCODING = 'UTF8' OWNER = eksport_app_live;\" | psql --username postgres"

    # poseidon
    docker exec local-postgresql /bin/sh -c  "/bin/echo \"CREATE ROLE poseidon_app WITH SUPERUSER CREATEDB LOGIN PASSWORD 'poseidon_password';\" | psql --username postgres"
    docker exec local-postgresql /bin/sh -c  "/bin/echo \"CREATE DATABASE poseidon WITH ENCODING = 'UTF8' OWNER = poseidon_app;\" | psql --username postgres"

    # middleton
    docker exec local-postgresql /bin/sh -c  "/bin/echo \"CREATE ROLE middleton_app WITH SUPERUSER CREATEDB LOGIN PASSWORD 'middleton_password';\" | psql --username postgres"
    docker exec local-postgresql /bin/sh -c  "/bin/echo \"CREATE DATABASE middleton WITH ENCODING = 'UTF8' OWNER = middleton_app;\" | psql --username postgres"

    # scoring
    docker exec local-postgresql /bin/sh -c  "/bin/echo \"CREATE ROLE scoring_app WITH SUPERUSER CREATEDB LOGIN PASSWORD 'scoring_password';\" | psql --username postgres"
    docker exec local-postgresql /bin/sh -c  "/bin/echo \"CREATE DATABASE scoring WITH ENCODING = 'UTF8' OWNER = scoring_app;\" | psql --username postgres"

    # reconciliation
    docker exec local-postgresql /bin/sh -c  "/bin/echo \"CREATE ROLE reconciliation_app WITH SUPERUSER CREATEDB LOGIN PASSWORD 'reconciliation_password';\" | psql --username postgres"
    docker exec local-postgresql /bin/sh -c  "/bin/echo \"CREATE DATABASE reconciliation WITH ENCODING = 'UTF8' OWNER = reconciliation_app;\" | psql --username postgres"
}


source /Users/steph/.docker/init-zsh.sh || true # Added by Docker Desktop
