#! /usr/bin/zsh

declare -a SKIPPED_DIRECTORIES=(git scripts zsh)
declare IS_EXECUTABLE_FILE=128

# Returns 0 if `[[ -e $1 && -f $1 ]]`, else returns 128
function determine_if_file_and_executable() {
    echo "TESTING $1"
    if [[ -d $1 ]]; then
        echo "$1 is a directory"
        IS_EXECUTABLE_FILE=128
    elif [[ -e $1 && -f $1 ]]; then
        echo "$1 exists AND is executable"
        IS_EXECUTABLE_FILE=0
    else
        echo "$1 is either *not* a file OR *not* executable"
        IS_EXECUTABLE_FILE=128
    fi
    echo "IS_EXECUTABLE_FILE -> $IS_EXECUTABLE_FILE"
}

# Calls `source` on `$1`
function source_file() {
    echo "Sourcing $1"
    source $1
}

# Iterates over `HOME_DOT_ENV` and avoids `SKIPPED_DIRECTORIES` as
#   all discovered entries are passed to `source` invocations
function source_from_home_dot_env() {
    for file in $(ls $HOME_DOT_ENV); do
        determine_if_file_and_executable "$HOME_DOT_ENV/$file"
        
        if [[ $IS_EXECUTABLE_FILE = 0 ]]; then
            source_file "$HOME_DOT_ENV/$file"
        else
            if [[ "${SKIPPED_DIRECTORIES[*]}" =~ $file ]]; then
                echo "SKIPPING $HOME_DOT_ENV/$file"
            else
                for script in $(ls -A $HOME_DOT_ENV/$file); do
                    determine_if_file_and_executable "$HOME_DOT_ENV/$file/$script"

                    if [[ $IS_EXECUTABLE_FILE = 0 ]]; then
                        source_file "$HOME_DOT_ENV/$file/$script"
                    fi
                done
            fi
        fi
        echo
    done
}

# Appends to `$PATH` with particular precision
function buid_path() {
    EXTRA_PATH=""
    for env_script in $(ls $HOME/.env/scripts); do
        if [[ ! -d "$HOME/.env/scripts/$env_script" ]]; then
            EXTRA_PATH="$HOME/.env/scripts/$env_script:$EXTRA_PATH"
        fi
        echo "$EXTRA_PATH"
    done
    export PATH="$EXTRA_PATH:$PATH"
}