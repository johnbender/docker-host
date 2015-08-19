set -e
dirname="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# setup user
export user="$1"
export user_home=/home/$user

bash "/vagrant/bin/install.sh"
bash "/vagrant/bin/config.sh"
