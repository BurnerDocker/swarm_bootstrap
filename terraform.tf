variable "do_ssh_fprint" {
  type        = "string"
  description = "Digital Ocean SSH Key fingerprint"
}

variable "do_api_token" {
  type        = "string"
  description = "Digital Ocean API token"
}

variable "swarm_node_image" {
  type        = "string"
  default     = "ubuntu-16-04-x64"
  description = "Base image to use for docker swarm nodes"
}

provider "digitalocean" {
    token = "${var.do_api_token}"
}

# Create a tag debops_all_hosts
resource "digitalocean_tag" "debops_all_hosts" {
  name = "debops_all_hosts"
}

# Create a droplet in nyc1 with the debops_all_hosts tag
resource "digitalocean_droplet" "node01" {
  image = "${var.swarm_node_image}"
  size = "1GB"
  name = "node01"
  region = "NYC1"
  ssh_keys = ["${var.do_ssh_fprint}"]
  tags   = [
    "${digitalocean_tag.debops_all_hosts.id}"
  ]
}
