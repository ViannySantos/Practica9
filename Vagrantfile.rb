Vagrant.configure("2") do |config|
    # Configuración de la VM
    config.vm.box = "ubuntu/bionic64"  # Utilizamos Ubuntu 18.04 como base
    config.vm.network "private_network", type: "dhcp"  # Red privada
    config.vm.provider "virtualbox" do |vb|
      vb.memory = "512"  # Asignar 512 MB de RAM
      vb.cpus = 1        # Asignar 1 CPU
    end
    
    # Configuración de la carpeta compartida entre la máquina local y la VM
    config.vm.synced_folder "./paginas_web", "/var/www/html"  # Ruta local y remota donde se compartirán los archivos
  
    # Provisionamiento para instalar Apache y crear la página "Hola Mundo"
    config.vm.provision "shell", inline: <<-SHELL
      sudo apt-get update
      sudo apt-get install -y apache2  # Instalamos Apache
  
      # Crear archivo HTML de prueba
      echo "<html><body><h1>Hola Mundo</h1></body></html>" | sudo tee /var/www/html/index.html
  
      sudo systemctl enable apache2
      sudo systemctl start apache2  # Iniciar el servidor Apache
    SHELL
  end
  