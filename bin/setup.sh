function install(){
  apt-get install -y $@
}

function which_install(){
  check="$2"
  if [ -z "$check" ]; then
    check="$1"
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

user=nickel
user_home=/home/$user

# setup nickel user
if ! cat /etc/passwd | grep $user; then
  useradd -m --home $user_home --groups sudo $user

  # setup a simple password
  echo "$user:$user" | chpasswd
  echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
fi

# make sure that docker can be run by the user
if ! groups "$user" | grep "docker"; then
  usermod -aG docker "$user"
fi

which_install tmux
which_install git

# user ssh config
mkdir -p $user_home/.ssh/
cp /vagrant/files/authorized_keys $user_home/.ssh/authorized_keys

# user terminal config
cp -r /vagrant/files/bash_completion.d/* /etc/bash_completion.d/
cp /vagrant/files/bash_profile $user_home/.bash_profile
