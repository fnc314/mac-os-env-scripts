#! /usr/bin/zsh

# A function which streamlines three calls to `brew` used to
#  generally update all things upon which `brew` is relied to
#  maintain/manage
function brew_update() {
    brew update -v
    brew upgrade -v
    brew upgrade -v $(brew list --cask)
}