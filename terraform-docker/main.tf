# Create a provider block
# https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.12.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Pulls the Docker image
# https://hub.docker.com/r/nodered/node-red/tags?page=1&ordering=last_updated
resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
resource "random_string" "random" {
  length = 4
  special = false
  upper = false
}

resource "random_string" "random2" {
  length = 4
  special = false
  upper = false
}

# Create a container
# nodered_container - name of the resource
# nodered           - name of the docker container
resource "docker_container" "nodered_container" { 
  name  = join("-", ["nodered", random_string.random.result])
  image = docker_image.nodered_image.latest
  hostname = "my.nodered.com"
  ports {
    internal = 1880
    # external = 1880 # let docker setup the port
  }
}

# Create another container
# nodered2_container - name of the resource
# nodered2           - name of the docker container
resource "docker_container" "nodered_container2" { 
  name  = join("-", ["nodered", random_string.random2.result])
  image = docker_image.nodered_image.latest
  hostname = "my.nodered.com"
  ports {
    internal = 1880
    # external = 1880 # let docker setup the port
  }
}

output "container-name1" {
  value       = docker_container.nodered_container.name
  description = "shows the name of the docker container"
}

output "container-name2" {
  value       = docker_container.nodered_container2.name
  description = "shows the name of the docker container"
}

output "ip-address1" {
  value       = join(":", [docker_container.nodered_container.ip_address, docker_container.nodered_container.ports[0].external])
  description = "shows the ip address and the external port of the docker container"
}

output "ip-address2" {
  value       = join(":", [docker_container.nodered_container2.ip_address, docker_container.nodered_container2.ports[0].external])
  description = "shows the ip address and the external port of the docker container"
}
