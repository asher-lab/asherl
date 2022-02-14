resource "azurerm_resource_group" "example" {
  name     = "${var.resource_group}-rg"
  location = "${var.location}"
}


resource "azurerm_network_security_group" "example" {
  name                = "${var.resource_group}-nsg"
  location            = "${azurerm_resource_group.example.location}"
  resource_group_name = "${azurerm_resource_group.example.name}"
}

resource "azurerm_virtual_network" "example" {
  name                = "${var.vnet}-vnet"
  location            = "${azurerm_resource_group.example.location}"
  resource_group_name = "${azurerm_resource_group.example.name}"
  address_space       = ["${var.address_space}"]
  
  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
    security_group = "${azurerm_network_security_group.example.id}"
  }


  subnet {
    name           = "subnet3"
    address_prefix = "10.0.3.0/24"
    security_group = "${azurerm_network_security_group.example.id}"
  }

  tags = {
    environment = "Development"
  }


}

