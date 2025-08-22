resource "azurerm_public_ip" "app_gw_ip" {
  name                = var.app_gw_pip_name
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_application_gateway" "app_gw" {
  name                = var.app_gw_name
  resource_group_name = var.rg_name
  location            = var.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "app-gw-ip-config"
    subnet_id = var.public_subnet_id
  }

  frontend_port {
    name = "http-port"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "app-gw-frontend-ip"
    public_ip_address_id = azurerm_public_ip.app_gw_ip.id
  }

  backend_address_pool {
    name         = "backend-pool"
    ip_addresses = [var.vm_private_ip]
  }

  backend_http_settings {
    name                  = "http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 8000
    protocol              = "Http"
    request_timeout       = 30
    probe_name            = "health-probe"
  }

  # Health probe for /health
  probe {
    name                                      = "health-probe"
    protocol                                  = "Http"
    path                                      = "/health/"
    host                                      = var.vm_private_ip
    interval                                  = 30
    timeout                                   = 30
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = false
  }

  # Health probe for /swagger
  probe {
    name                                      = "swagger-probe"
    protocol                                  = "Http"
    path                                      = "/swagger/"
    host                                      = var.vm_private_ip
    interval                                  = 30
    timeout                                   = 30
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = false
  }


  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "app-gw-frontend-ip"
    frontend_port_name             = "http-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "http-rule"
    rule_type                  = "Basic"
    http_listener_name         = "http-listener"
    backend_address_pool_name  = "backend-pool"
    backend_http_settings_name = "http-settings"
    priority                   = 1
  }
}
