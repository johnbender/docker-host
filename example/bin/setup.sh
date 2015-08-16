# user setup
useradd -m --home /home/nickel --groups sudo nickel
echo "nickel:nickel" | chpasswd
echo "%sudo  ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
