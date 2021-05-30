# Terraform

## TF providers

[TF providers](https://registry.terraform.io/browse/providers):
Terraform relies on plugins called `providers` to interact with remote systems.

Terraform configurations must declare which providers they require, so that Terraform can install and use them. 

```
terraform {
  required_providers {
    docker = {
        source = "kreuzwerker/docker"
        version = "2.12.0"
    }
  }
}
```

## TF resource

A resource block describes one or more infrastructure objects, such as virtual networks, compute instances, or higher-level components such as DNS records.

A resource block declares a resource of a given type `docker_image` with a given local name `nodered_image`.
The name is used to refer to this resource from elsewhere in the same Terraform module, but has no significance outside that module's scope.

```
resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}
```

Each resource type is implemented by a provider (provider is a plugin for Terraform that offers a collection of resource types)

## TF provision

[TF provision](https://www.terraform.io/docs/cli/run/index.html): 
Create, modify, and destroy infrastructure resources to match the desired state described in a Terraform configuration.

## TF expressions

[TF expressions](https://www.terraform.io/docs/language/expressions/index.html): 
Expressions are used to refer to or compute values within a configuration.

## Terraform command

* Initialize the Terraform
  ```
  $ terraform init
  ```

* Formats the terraform code and `-diff` shows the differences made in the Terraform state
  ```
  $ terraform fmt [-diff]
  ```

* View the terraform state without accessing the `tfstate` file
  ```
  $ terraform show [-json | jq]
  ```

* Shows all resources within the state
  ```
  $ terraform state list
  ```

* Cli tool for terraform
  ```
  $ terraform console
  > docker_container.nodered_container.name
  "nodered"
  > docker_container.nodered_container.hostname
  ```

* Output the terraform state information 
  ```
  $ terraform output
  ```

* Create an execution plan
  ```
  $ terraform plan
  $ terraform plan -out=plan1 [output to a file]
  $ terraform plan -destroy [shows the execution plan for the destroy]
  ```

* Executes the actions proposed in a Terraform plan
  ```
  $ terraform apply
  $ terraform apply [--auto-approve]
  $ terraform apply plan1 [run the plan from the plan file]
  ```

* Destroy
  ```
  $ terraform destroy [--auto-approve]
  ```

## Other commands

* Docker prune all the images, containers, networks, and volumes
  ```
  $ docker system prune -a
  ```
