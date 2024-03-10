terraform {
  cloud {
    # Organization ID
    organization = "baliganorbi"
    # Workspace ID
    workspaces {
      name = "globoweb-app-dev"
    }
  }
}