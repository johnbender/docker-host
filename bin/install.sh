dirname="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$dirname/helpers.sh"

apt-get update

# check for, then install packages
which_install curl
which_install tmux
which_install git
which_install tig
which_install irssi

# required for emacs flyspell in tramp
which_install aspell

# required for irssi autospell
which_install ispell
install liblingua-ispell-perl

# install docker
if ! which docker; then
  curl -sSL https://get.docker.com/ | sh
fi

if ! cat /etc/passwd | grep "$user"; then
  useradd -m --home "$user_home" --groups sudo "$user" --shell /bin/bash

  # setup a simple password
  echo "$user:$user" | chpasswd
  echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
fi

# make sure that docker can be run by the user
if ! groups "$user" | grep "docker"; then
  usermod -aG docker "$user"
fi

# install docker compose
cmps_os="`uname -s`-`uname -m`"
cmps_url="https://github.com/docker/compose/releases/download/1.4.0/docker-compose-$cmps_os"
curl -Ls "$cmps_url" > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
