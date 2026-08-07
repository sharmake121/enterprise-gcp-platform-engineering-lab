terraform {
  backend "gcs" {
    bucket = "verdant-tempest-504711-j0-tfstate"
    prefix = "terraform/state"
  }
}