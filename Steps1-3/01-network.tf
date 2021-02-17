resource "azurerm_subnet" "public_subnet" {
  resource_group_name  = var.vnet_rg
  virtual_network_name = var.vnet_name
  name                 = "${var.prefix}-dbricks-public"
  address_prefixes     = [var.subnet_cidr_public]
  delegation {
    name = "${var.prefix}-dbricks-private-del"
    service_delegation {
      name = "Microsoft.Databricks/workspaces"
    }
  }
}

resource "azurerm_network_security_group" "public_nsg" {
  name                = "${azurerm_subnet.public_subnet.name}-nsg"
  resource_group_name = var.vnet_rg
  location            = azurerm_resource_group.rg.location
}


resource "azurerm_subnet_network_security_group_association" "nsg_subnet_public" {
  network_security_group_id = azurerm_network_security_group.public_nsg.id
  subnet_id                 = azurerm_subnet.public_subnet.id
}

resource "azurerm_subnet" "private_subnet" {
  resource_group_name  = var.vnet_rg
  virtual_network_name = var.vnet_name
  name                 = "${var.prefix}-dbricks-private"
  address_prefixes     = [var.subnet_cidr_private]
  delegation {
    name = "${var.prefix}-dbricks-private-del"
    service_delegation {
      name = "Microsoft.Databricks/workspaces"
    }
  }
}

resource "azurerm_network_security_group" "private_nsg" {
  name                = "${azurerm_subnet.private_subnet.name}-nsg"
  resource_group_name = var.vnet_rg
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_subnet_network_security_group_association" "nsg_subnet_private" {
  network_security_group_id = azurerm_network_security_group.private_nsg.id
  subnet_id                 = azurerm_subnet.private_subnet.id
}
