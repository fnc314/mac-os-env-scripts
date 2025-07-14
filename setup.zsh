#! /usr/bin/zsh

function preliminary_check() {
    if [[ -e $HOME/.env ]]; then
        echo "$HOME/.env exists"
        echo "Please save contents and rerun"
        exit 0
    fi

    if [[ -e $HOME/.zshenv ]]; then
        echo "$HOME/.zshenv exists"
        echo "Please save contents and rerun"
        exit 0
    fi
}

function create_root_dot_env() {
    echo "Creating $HOME/.env2 *DIRECTORY*"
    mkdir -v $HOME/.env2
    echo
    echo "Copying contents of 'env'"
    echo
    cp -vr env $HOME/.env2
}

function create_root_dot_zshenv() {
    echo "Creating $HOME/.zshenv"
    touch $HOME/.zshenv
    echo
    echo "Copying over 'root_zshenv'"
    echo
    cat root_zshenv > $HOME/.zshenv
}

function create_root_gradle_android_directories() {    
    echo "Setting up assumed defaults for Android and Gradle"
    mkdir -pv $HOME/.android/{sdk,studio}
    touch $HOME/.android/studio/idea.properties
    touch $HOME/.android/studio/studio.vmoptions
    mkdir -pv $HOME/.gradle/init.d
    cp env/gradle/init.d/root.init.gradle.kts $HOME/.gradle/init.d
    cp env/gradle/gradle.properties $HOME/.gradle
}

preliminary_check
create_root_dot_env
create_root_dot_zshenv
create_root_gradle_android_directories