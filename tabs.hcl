resource "editor" "vscode" {
  workspace "root" {
    target = resource.container.ssh.id
    directory = "/root"
  }
}

resource "terminal" "shell" {
  target = resource.container.ssh.id
}

#resource "cloud" "" {
#  target = resource.aws_account.aws.id
#}