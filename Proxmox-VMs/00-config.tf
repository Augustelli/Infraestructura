terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "2.9.7"
    }
  }
  required_version = ">= 1.5"
}

provider "proxmox" {
  pm_api_url = "https://your-proxmox-server:8006/api2/json"
  pm_user    = "root@pam"
  pm_password = "your-password"
  pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "vm" {
  name        = "terraform-vm"
  target_node = "proxmox-node"
  clone       = "template-name"

  os_type = "cloud-init"
  cores   = 2
  sockets = 1
  memory  = 2048
  disk {
    size = "20"
  }
  network {
    model  = "virtio"
    bridge = "vmbr0"
  }
  ipconfig0 = "ip=dhcp"
}