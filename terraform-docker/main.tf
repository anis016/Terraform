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

# Create 3 random string
# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
resource "random_string" "random" {
  count = 3
  length = 4
  special = false
  upper = false
}

# Create 3 containers randomly generated using 3 "random_string" resource
# nodered_container - name of the resource
# nodered           - name of the docker container
resource "docker_container" "nodered_container" {
  count = 3
  name  = join("-", ["nodered", random_string.random[count.index].result])
  image = docker_image.nodered_image.latest
  hostname = "my.nodered.com"
  ports {
    internal = 1880
    # external = 1880 # let docker setup the external port automatically
  }
}

output "container-name1" {
  value       = docker_container.nodered_container[0].name
  description = "shows the name of the docker container"
}

output "container-name2" {
  value       = docker_container.nodered_container[1].name
  description = "shows the name of the docker container"
}

output "container-name3" {
  value       = docker_container.nodered_container[2].name
  description = "shows the name of the docker container"
}

output "ip-address1" {
  value       = join(":", [docker_container.nodered_container[0].ip_address, docker_container.nodered_container[0].ports[0].external])
  description = "shows the ip address and the external port of the docker container"
}

output "ip-address2" {
  value       = join(":", [docker_container.nodered_container[1].ip_address, docker_container.nodered_container[1].ports[0].external])
  description = "shows the ip address and the external port of the docker container"
}

output "ip-address3" {
  value       = join(":", [docker_container.nodered_container[2].ip_address, docker_container.nodered_container[2].ports[0].external])
  description = "shows the ip address and the external port of the docker container"
}
