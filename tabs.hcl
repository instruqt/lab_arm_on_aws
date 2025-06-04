resource "editor" "vscode" {
  workspace "root" {
    target = resource.container.ssh
    directory = "/root"
  }
}

resource "terminal" "shell" {
  target = resource.container.ssh
}
