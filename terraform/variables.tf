variable "docker_host" {
  description = "Endpoint Docker daemon"
  type        = string
  default     = "unix:///var/run/docker.sock"
}

variable "app_image" {
  description = "Base image Node.js"
  type        = string
  default     = "node:18"
}

variable "db_image" {
  description = "Image PostgreSQL"
  type        = string
  default     = "postgres:15"
}

variable "app_port" {
  description = "Port host untuk app"
  type        = number
  default     = 3000
}

variable "db_port" {
  description = "Port host untuk database"
  type        = number
  default     = 5432
}
