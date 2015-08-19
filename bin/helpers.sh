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

function chown_many(){
  # user and group
  ug=$1

  # remove $1 form the stack of args
  shift

  # while there are args
  while (( "$#" )); do
    echo "INFO: chown -R $ug:$ug $1"
    chown -R $ug:$ug $1

    # remove $1 of the stack of arguments
    shift
  done
}
