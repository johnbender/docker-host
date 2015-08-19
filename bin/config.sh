dirname="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$dirname/helpers.sh"

# user ssh config
mkdir -p "$user_home/.ssh/"
cp /vagrant/files/authorized_keys "$user_home/.ssh/authorized_keys"

# dot file
cp -r /vagrant/files/bash_completion.d/* /etc/bash_completion.d/
cp -r /vagrant/files/dot/. "$user_home"

# make sure the permissions are sane
chown_many "$user" "$user_home"

# make sure the bash profile is executable
chmod +x "$user_home/.bash_profile"

# project directory setup
mkdir -p "$user_home/projects"
chown_many "$user" "$user_home/projects"
