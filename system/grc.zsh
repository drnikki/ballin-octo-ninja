# https://raw.github.com/holman/dotfiles/master/system/grc.zsh
# GRC colorizes nifty unix tools all over the place
if $(grc &>/dev/null)
then
  source `brew --prefix`/etc/grc.bashrc
fi
