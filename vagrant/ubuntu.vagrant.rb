# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/xenial64"
  config.vm.box_check_update = false
  config.ssh.forward_agent = true

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", id: "ssh", guest: 22, host: 42222, host_ip: "127.0.0.1", auto_correct: false
  # config.vm.network "forwarded_port", id: "mysql", guest: 3306, host: 3306, host_ip: "127.0.0.1"

  config.vm.network "private_network", ip: "192.168.21.11"
  config.vm.network "public_network", ip: "192.168.138.122", netmask: "255.255.255.0", bridge: "Qualcomm Atheros AR8161 PCI-E Gigabit Ethernet Controller (NDIS 6.30)"

  # https://www.vagrantup.com/docs/synced-folders/
  config.vm.synced_folder "G:/.www", "/home/vagrant/code", type: "nfs", mount_options: ['nolock,vers=3,udp,actimeo=1']

  config.vm.provider "virtualbox" do |vb|
    vb.name = "ubuntu1604"
    vb.gui = false
    vb.memory = 2048
    vb.cpus = 2
    vb.linked_clone = true
    vb.customize ['modifyvm', :id, '--ostype', 'Ubuntu_64']
  end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  
  authorize_pub = "~/.ssh/id_rsa.pub"
  config.vm.provision 'shell' do |s|
    s.inline = "echo $1 | grep -xq \"$1\" /home/vagrant/.ssh/authorized_keys || echo \"\n$1\" | tee -a /home/vagrant/.ssh/authorized_keys"
    s.args = [File.read(File.expand_path(authorize_pub))]
  end
  
  config.vm.provision "shell", inline: <<-SHELL
    sources="/etc/apt/sources.list"
    if [ ! -f "${sources}.bak" ]; then
      mv "${sources}" "${sources}.bak"
    fi
    curl -s -o ${sources} https://mirrors.ustc.edu.cn/repogen/conf/ubuntu-http-4-xenial
    
    add-apt-repository ppa:ondrej/php -r -y
    add-apt-repository ppa:ondrej/php -y
    apt-get clean
    
    grep -rl ppa.launchpad.net /etc/apt/sources.list.d/ | xargs sed -i 's/http:\/\/ppa.launchpad.net/https:\/\/launchpad.proxy.ustclug.org/g'
    
    apt-get update
    
    apt-get install -y build-essential dos2unix gcc git libmcrypt4 libpcre3-dev libpng-dev ntp unzip \
    make python2.7-dev python-pip re2c supervisor unattended-upgrades whois vim libnotify-bin \
    pv cifs-utils mcrypt bash-completion zsh graphviz avahi-daemon
    
    apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
    php7.3-cli php7.3-dev \
    php7.3-pgsql php7.3-sqlite3 php7.3-gd \
    php7.3-curl \
    php7.3-imap php7.3-mysql php7.3-mbstring \
    php7.3-xml php7.3-zip php7.3-bcmath php7.3-soap \
    php7.3-intl php7.3-readline
    
    apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
    php7.2-cli php7.2-dev \
    php7.2-pgsql php7.2-sqlite3 php7.2-gd \
    php7.2-curl php7.2-memcached \
    php7.2-imap php7.2-mysql php7.2-mbstring \
    php7.2-xml php7.2-zip php7.2-bcmath php7.2-soap \
    php7.2-intl php7.2-readline php7.2-ldap \
    php-pear
    
    update-alternatives --set php /usr/bin/php7.2
    update-alternatives --set php-config /usr/bin/php-config7.2
    update-alternatives --set phpize /usr/bin/phpize7.2
    
    curl -sS https://getcomposer.org/installer | php
    mv composer.phar /usr/local/bin/composer
    
    sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.2/cli/php.ini
    sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.2/cli/php.ini
    sudo sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.2/cli/php.ini
    sudo sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.2/cli/php.ini

    sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.3/cli/php.ini
    sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.3/cli/php.ini
    sudo sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.3/cli/php.ini
    sudo sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.3/cli/php.ini
    
  SHELL
  
  config.vm.provision "shell", inline: <<-SHELL
  SHELL
end