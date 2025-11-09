#creating resource group
resource "azurerm_resource_group" "HREN-TEST" {
  location = "South India"
  name = "RG-HREN-TEST-SI-01"
  
}
#creating vnet
resource "azurerm_virtual_network" "HREN-TEST-VNET" {
  name = "vnet-HREN-test-si-01"
  location = "South India"
  resource_group_name = "RG-HREN-TEST-SI-01"
  address_space = ["10.0.0.0/27"]
subnet {
  name="default_subnet"
  address_prefixes = ["10.0.0.0/29"]
}
}

resource "azurerm_subnet" "HREN-TEST-subnet" {
  name = "subnet-HREN-test-si-01"
  address_prefixes = ["10.0.1.0/29"]
  resource_group_name = azurerm_resource_group.HREN-TEST.name
  virtual_network_name = azurerm_virtual_network.HREN-TEST-VNET.name
}

resource "azurerm_network_interface" "HREN-TEST-Net_interface" {
  name = "net_intf-HREN-test-si"
  location = azurerm_resource_group.HREN-TEST.location
  resource_group_name = azurerm_resource_group.HREN-TEST.name
  ip_configuration {
    name = "ipconfiguration-HREN-test-si"
    subnet_id = azurerm_subnet.HREN-TEST-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

#adding VM to the network
resource "azurerm_windows_virtual_machine" "HREN-TEST-VM" {
  name ="vnet-HREN-test-si-01"
  location = azurerm_resource_group.HREN-TEST.location
  resource_group_name = azurerm_resource_group.HREN-TEST.name
  network_interface_ids = [azurerm_network_interface.HREN-TEST-Net_interface.id]
 size = "Standard_DS1"
 os_disk {
   caching = "ReadWrite"
   storage_account_type = "Standard_LRS"
 }
 admin_password = "Dee123@QWE"
 admin_username = "Bhagyashri"
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer = "WindowsServer"
    sku = "2016-Datacenter"
    version = "latest"
  }
  }
  

