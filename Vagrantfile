###############################################################################
## Vagrantfile
##
## To allow clipboard sharing from host to guest and vice versa
## you will need to make clipboard sharing birectional from virtual-box using
## virtualbox front end.
###############################################################################

$script = <<SCRIPT
sudo apt update
sudo apt upgrade -y
sudo apt install python3-pip -y
sudo apt-get install libpq-dev python3-dev -y
cd ~
echo "PATH=/home/vagrant/.local/bin/jupyter:$PATH" >> .bashrc
sudo pip3 install -r /vagrant/requirements.txt
sudo apt install xclip -y
SCRIPT


USER_NAME = ENV['USER'] || ENV['USERNAME']

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-22.04"
  config.vm.provision "shell", inline: $script
  config.ssh.forward_agent = true # Used for Clipboard sharing.
  config.ssh.forward_x11 = true # Used for Clipboard sharing.
  for i in 8888..8900
    config.vm.network :forwarded_port, guest: i, host: i-2000
  end
  config.vm.provider "virtualbox" do |vb|
    vb.name = "chunkster"
    vb.memory = 8192
    vb.cpus = 2
    # Used for Clipboard sharing.
    vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
  end
  # Set the correct host path format based on the host OS.
  if Vagrant::Util::Platform.windows?
        # Is Windows, set the path using Windows-style backslashes.
        host_path = "C:\\Users\\#{USER_NAME}\\ragit-data"
  else
        # Not Windows (assuming Linux/Mac), use Unix-style forward slashes.
        host_path = "/home/#{USER_NAME}/ragit-data"
  end
  config.vm.synced_folder host_path, "/home/vagrant/ragit-data"
  config.vm.hostname = "chunkster"
  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true
end
