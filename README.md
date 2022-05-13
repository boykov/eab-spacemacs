# eab spacemacs layer

See [changes history](Changelog).

It consists of subsystems:

* editing model
  * keybindings, workflows
* extensions model
  * packages, dependencies, postload
* data model
  * publishing, knowledge base, timetracking

## Install

    mkdir -p ~/.emacs.d/private
    cd ~/.emacs.d/private
    git clone https://github.com/boykov/eab-spacemacs
    cd eab-spacemacs
    git submodule init
    git submodule update

    cd ~/.emacs.d/
    ln -s private/eab-spacemacs/local/spacemacs/init.el init.el
