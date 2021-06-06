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

# Create 3 random string for 2 docker container
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
  hostname = join(".", [random_string.random[count.index].result, "nodered", "com"])
  ports {
    internal = 1880
    # external = 1880 # let docker setup the external port automatically
  }
}

# Using splat expression instead of using the index for multiple containers
output "container-name" {
  value       = docker_container.nodered_container[*].name
  description = "shows the name of the docker container"
}

# output "container-name1" {
#   value       = docker_container.nodered_container[0].name
#   description = "shows the name of the docker container"
# }

# output "container-name2" {
#   value       = docker_container.nodered_container[1].name
#   description = "shows the name of the docker container"
# }

# output "container-name3" {
#   value       = docker_container.nodered_container[2].name
#   description = "shows the name of the docker container"
# }

# Using loop (for) to get the ip-address and port for each container
output "ip-address" {
  value = [for i in docker_container.nodered_container[*]: join(":", [i.ports[0].ip, i.ports[0].external])]
  description = "shows the ip address and the external port of the docker container"
}

# output "ip-address1" {
#   value       = join(":", [docker_container.nodered_container[0].ip_address, docker_container.nodered_container[0].ports[0].external])
#   description = "shows the ip address and the external port of the docker container"
# }

# output "ip-address2" {
#   value       = join(":", [docker_container.nodered_container[1].ip_address, docker_container.nodered_container[1].ports[0].external])
#   description = "shows the ip address and the external port of the docker container"
# }

# output "ip-address3" {
#   value       = join(":", [docker_container.nodered_container[2].ip_address, docker_container.nodered_container[2].ports[0].external])
#   description = "shows the ip address and the external port of the docker container"
# }
