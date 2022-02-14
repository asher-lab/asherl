

# Create virtual machine with Private IP Address on Subnet 1
# Create virtual machine with Private IP Address on Subnet 1
# Create virtual machine with Private IP Address on Subnet 1



# Create network interface for private virtual machine
resource "azurerm_network_interface" "example-private" {
    name                      = "demo3-nic-private"
    location                  = "${var.location}"
    resource_group_name       = "${var.resource_group}-rg"

    ip_configuration {
        name = "myNICConfiguration-private"
        subnet_id = "${var.subnet_ids[0][0]}"
        private_ip_address_allocation = "Dynamic"
    }

    tags = {
        environment = "Terraform Demo"
    }
}


# Create (and display) an SSH key
resource "tls_private_key" "example_ssh_private" {
  algorithm = "RSA"
  rsa_bits = 4096
}
output "tls_private_key" { 
    value = tls_private_key.example_ssh_private.private_key_pem 
    sensitive = true
}

# ssh keys are in tfstate file which is very insecure


resource "azurerm_linux_virtual_machine" "example" {
    name                  = "myVM-private"
    location              = "${var.location}"
    resource_group_name   = "${var.resource_group}-rg"
    network_interface_ids = [azurerm_network_interface.example-private.id]
    size                  = "Standard_DS1_v2"

    os_disk {
        name              = "myOsDisk"
        caching           = "ReadWrite"
        storage_account_type = "Premium_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    computer_name  = "myvm-private"
    admin_username = "azureuser"
    disable_password_authentication = true

    admin_ssh_key {
        username       = "azureuser"
        public_key     = tls_private_key.example_ssh_private.public_key_openssh
    }


    tags = {
        environment = "Terraform Demo"
    }
}