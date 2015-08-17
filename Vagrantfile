# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
username = "nickel"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provider :virtualbox do |vb, override|
    vb.customize ["modifyvm", :id, "--memory", "2048"]

    override.vm.box = "trusty64"
    override.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

    override.vm.network :private_network, ip: "33.33.33.10"

    # NOTE this mount only happens on the local instance, the
    # repositories that make up the projects directory should
    # otherwise be cloned directly
    override.vm.synced_folder "projects", "/home/#{username}/projects"
  end

  config.vm.provider :aws do |aws, override|
    override.vm.box = "aws"
    override.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"

    override.ssh.username = "ubuntu"
    aws.instance_type = "m4.xlarge"

    aws.access_key_id = ENV['AWS_KEY']
    aws.secret_access_key = ENV['AWS_SECRET']

    override.ssh.private_key_path = "~/.ssh/aws/nickeluswest2.pem"
    aws.keypair_name = "nickel us west 2"

    # AMI sourced from canonical/ubuntu
    # http://cloud-images.ubuntu.com/releases/14.04.3/release-20150814/
    aws.ami = "ami-afd5c09f"

    aws.region = "us-west-2"
    aws.security_groups = ["secure-shell"]

    override.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: ".git/"
  end

  config.vm.provision :shell, :path => "bin/setup.sh", :args => username
end
