output "subnet_ids" {
  description = "The ids of subnets created inside the created vNet"
  value = ["${azurerm_virtual_network.example.subnet.*.id}"]
}

output "nsg_ids" {
   description = "The ids of network security groups created inside the  vNet"
  value = ["${azurerm_network_security_group.example.*.id}"]
  
}

