# Create virtual machine with Public IP Address on subnet 2
# Create virtual machine with Public IP Address on subnet 2
# Create virtual machine with Public IP Address on subnet 2


# Create Public IP
resource "azurerm_public_ip" "example" {
  name                = "demo3-subnet-2-PublicIp"
  resource_group_name = "${var.resource_group}-rg"
  location            = "${var.location}"
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}

# Create network interface
resource "azurerm_network_interface" "example" {
    name                      = "demo3-nic"
    location                  = "${var.location}"
    resource_group_name       = "${var.resource_group}-rg"

    ip_configuration {
        name = "myNICConfiguration"
        subnet_id = "${var.subnet_ids[0][1]}"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.example.id
    }

    tags = {
        environment = "Terraform Demo"
    }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
    network_interface_id      = azurerm_network_interface.example.id
    network_security_group_id = "${var.nsg_ids[0][0]}"
}

# Generate random text for a unique storage account name
resource "random_id" "randomId" {
    keepers = {
        # Generate a new ID only when a new resource group is defined
        resource_group = "${var.resource_group}-rg"
    }

    byte_length = 8
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "mystorageaccount" {
    name                        = "diag${random_id.randomId.hex}"
    resource_group_name         = "${var.resource_group}-rg"
    location                    = "${var.location}"
    account_tier                = "Standard"
    account_replication_type    = "LRS"

    tags = {
        environment = "Terraform Demo"
    }
}

# Create (and display) an SSH key
resource "tls_private_key" "example_ssh" {
  algorithm = "RSA"
  rsa_bits = 4096
}
output "tls_private_key" { 
    value = tls_private_key.example_ssh.private_key_pem 
    sensitive = true
}



resource "azurerm_linux_virtual_machine" "example" {
    name                  = "myVM-public"
    location              = "${var.location}"
    resource_group_name   = "${var.resource_group}-rg"
    network_interface_ids = [azurerm_network_interface.example.id]
    size                  = "Standard_DS1_v2"

    os_disk {
        name              = "myOsDisk-public"
        caching           = "ReadWrite"
        storage_account_type = "Premium_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    computer_name  = "myvm"
    admin_username = "azureuser"
    disable_password_authentication = true

    admin_ssh_key {
        username       = "azureuser"
        public_key     = tls_private_key.example_ssh.public_key_openssh
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.mystorageaccount.primary_blob_endpoint
    }

    tags = {
        environment = "Terraform Demo"
    }
}
