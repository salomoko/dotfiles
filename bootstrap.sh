#!/bin/sh
# Installation script adopted from https://gist.github.com/sonots/4239842

set -e

[[ -e ~/.dotfiles ]] || git clone https://github.com/ericboehs/dotfiles ~/.dotfiles
pushd ~/.dotfiles > /dev/null

git checkout master
git pull --rebase origin master
git submodule init
git submodule update

mkdir -p ~/.ssh

dotfiles="$(ls -a) .ssh/config"
for f in $dotfiles; do
  overwrite=false
  [ $f = "." ]            && continue
  [ $f = ".." ]           && continue
  [ $f = ".ssh" ]         && continue
  [ $f = ".git" ]         && continue
  [ $f = ".gitignore" ]   && continue
  [ $f = ".gitmodules" ]  && continue
  [ $f = "bootstrap.sh" ] && continue
  [ $f = "README.md" ]    && continue
  if [ -e ~/$f ];then
    if [ "$FORCE_OVERWRITE" == "true" ]; then
      overwrite=true
    else
      read -p "~/$f exists. Overwrite? [[y]n]" yn
      case $yn in
        [Nn]* ) continue;;
        * ) overwrite=true;;
      esac
    fi

    if [ overwrite ]; then
      ln -fs ~/.dotfiles/$f ~/
    fi
  else
    ln -s ~/.dotfiles/$f ~/$(dirname $f)/$(basename $f)
  fi
done

vim -c ':BundleInstall!' -c ':q!' -c ':q!'

popd > /dev/null

echo "-----> All done. Enjoy your shell."