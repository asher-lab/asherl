resource "azurerm_resource_group" "example" {
  name     = "${var.resource_group}-rg"
  location = "${var.location}"
}

resource "azurerm_mysql_server" "example" {
  name                = "example-mysqlserver-normal"
  location            ="${var.location}"
  resource_group_name = "${var.resource_group}-rg"

  administrator_login          = "mysqladminun"
  administrator_login_password = "H@Sh1CoR3!"

  sku_name   = "B_Gen5_2"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = false
}