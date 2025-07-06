// terraform/main.tf

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = var.docker_host
}

# 1) tarik image aplikasi
resource "docker_image" "app_image" {
  name = var.app_image
}

# 2) container aplikasi
resource "docker_container" "app" {
  name  = "infra-demo-app"
  image = docker_image.app_image.name
  ports {
    internal = 3000
    external = var.app_port
  }
  # mount folder kode aplikasi ke /app in-container
  volumes {
    host_path      = abspath("${path.root}/../docker/app")
    container_path = "/app"
  }
  working_dir = "/app"
  command     = ["npm", "start"]
  restart     = "unless-stopped"
}

# 3) tarik image database
resource "docker_image" "db_image" {
  name = var.db_image
}

# 4) container database
resource "docker_container" "db" {
  name  = "infra-demo-db"
  image = docker_image.db_image.name
  env = [
    "POSTGRES_USER=user",
    "POSTGRES_PASSWORD=pass",
    "POSTGRES_DB=appdb",
  ]
  ports {
    internal = 5432
    external = var.db_port
  }
  volumes {
    host_path      = abspath("${path.root}/../docker/db_data")
    container_path = "/var/lib/postgresql/data"
  }
  restart = "unless-stopped"
}
