#TODO use the project directory and parent directory as tag
tag=$1
project_folder=$2

function log_info {
  echo "INFO: $1";
}

if ! docker build -t "$1" "$2"; then
  log_info "\`docker build -t $1 $2\` failed ..."
  log_info "removing containers with non-zero exit status ..."
  # 1. find all the docker processes with a bad exit value
  # 2. get the id
  # 3. remove the process
  docker ps -a \
    | grep "Exited ([^0])" \
    | cut -d' ' -f1 \
    | xargs -n1 docker rm \
     > /dev/null
fi
