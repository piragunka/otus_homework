terraform {
	required_providers {
		yandex = {
			source = "yandex-cloud/yandex"
		}
	}
	required_version = ">= 0.13"
}

provider "yandex" {
	
    cloud_id  = var.cloud_id
  	folder_id = var.folder_id
  	zone      = var.zone
  	token     = var.yc_token
}

locals {
 virtual_machines = {
   "backend1" = { public_ip = false, size_disk = 10},
   "backend2" = { public_ip = false, size_disk = 10 },
   "db"       = { public_ip = false, size_disk = 20 },
   "frontend" = { public_ip = true, size_disk = 10 },
   "jump"     = { public_ip = true, size_disk = 5 }
 }
}

resource "yandex_compute_instance" "vm" {
  
for_each  = local.virtual_machines
name      = each.key

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size = each.value.size_disk
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = each.value.public_ip
  }

      metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
  route_table_id = yandex_vpc_route_table.rt.id
}

resource "yandex_vpc_gateway" "nat_gateway" {
  name = "test-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "rt" {
  name       = "test-route-table"
  network_id = yandex_vpc_network.network-1.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}

