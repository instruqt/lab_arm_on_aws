resource "lab" "main" {
  title = "AWS ARM VM"
  description = <<-EOF

  EOF

  layout "single_column" {
    reference = resource.layout.single_panel
  }
}