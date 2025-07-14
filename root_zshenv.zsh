export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-24.jdk/Contents/Home"
export HOME_DOT_ENV="$HOME/.env"

source $HOME_DOT_ENV/scripts/helpers/helpers.zsh
source_from_home_dot_env

# Expand `$PATH` "last"
buid_path

export ZDOTDIR="$HOME/.env/zsh"