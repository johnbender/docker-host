function install(){
  apt-get install -y $@
}

function which_install(){
  if [ -z "$2" ]; then
    $2="$1"
  fi

  if ! which $2; then
    install $1
  fi
}

apt-get update
which_install curl

if ! which docker; then
  curl -sSL https://get.docker.com/ | sh
fi

docker_user=ubuntu

if cat /etc/passwd | grep "vagrant"; then
  docker_user=vagrant
fi

if ! groups "$docker_user" | grep "docker"; then
  usermod -aG docker "$docker_user"
fi

which_install tmux
which_install git

cp -r /vagrant/files/bash_completion.d/* /etc/bash_completion.d/
