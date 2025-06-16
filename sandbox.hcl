resource "network" "main" {
  subnet = "10.0.5.0/24"
}

resource "virtual_browser" "browser" {
  url = "https://www.instruqt.com.com"
  agent = "chromium"
}

resource "container" "ssh" {
  image {
    name = "kroniak/ssh-client"
  }

  environment = {
    PUBLIC_IP = resource.terraform.instance.output.instance_public_ip
  }

  volume {
    source      = resource.terraform.instance.volume.0.source
    destination = "/root/.ssh"
  }

  network {
    id = resource.network.main.meta.id
  }
}


