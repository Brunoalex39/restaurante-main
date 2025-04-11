provider "azurerm" {
  features {}
  subscription_id = "d6b9e36b-3118-4e34-8285-5e1e717e7bc4"
}

resource "azurerm_resource_group" "rg" {
  name     = "flaskapp-rg"
  location = "East US"
}

resource "azurerm_app_service_plan" "asp" {
  name                = "flaskapp-asp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "app" {
  name                = "flaskapp-anthoony"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id

  site_config {
    linux_fx_version = "PYTHON|3.9"
  }

  app_settings = {
    "FLASK_APP"                         = "app.py"
    "FLASK_ENV"                         = "production"
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "true"
    "SCM_DO_BUILD_DURING_DEPLOYMENT"   = "true"
  }
}
