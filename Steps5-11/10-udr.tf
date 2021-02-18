# Step 10
resource "azurerm_subnet_route_table_association" "udr_associate" {
  route_table_id = var.udr_id
  subnet_id = var.private_subnet_id
}

resource "azurerm_subnet_route_table_association" "udr_associate2" {
  route_table_id = var.udr_id
  subnet_id = var.public_subnet_id
}