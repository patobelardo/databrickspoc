# Step 10
resource "azurerm_subnet_route_table_association" "udr_associate" {
  count =  var.step4done ? 1 : 0
  route_table_id = var.udr_id
  subnet_id = azurerm_subnet.public_subnet.id
}

resource "azurerm_subnet_route_table_association" "udr_associate2" {
  count =  var.step4done ? 1 : 0
  route_table_id = var.udr_id
  subnet_id = azurerm_subnet.private_subnet.id
}