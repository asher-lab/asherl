resource "random_string" "random" {
  length = 6
  special = false
  upper = false
}


resource "azurerm_mysql_server" "example" {
  name                = "${var.mysql_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}-rg"

  sku_name = "GP_Gen5_2"

  storage_profile {
    storage_mb            = 51200
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
    auto_grow             = "Enabled"
  }

  administrator_login          = "mysqladmin"
  administrator_login_password = "H@Sh1CoR3!"
  version                      = "5.7"
  ssl_enforcement              = "disabled"
}

resource "azurerm_private_endpoint" "example" {
  name                = "${random_string.random.result}-endpoint"
  location            = "${var.location}" 
  resource_group_name = "${var.resource_group}-rg"
  subnet_id           = "${var.subnet_ids[0][2]}"

  private_service_connection {
    name                           = "${random_string.random.result}-privateserviceconnection"
    private_connection_resource_id = azurerm_mysql_server.example.id
    subresource_names              = [ "mysqlServer" ]
    is_manual_connection           = false
  }
}