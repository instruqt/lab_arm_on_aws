resource "lab" "main" {
  title       = "AWS ARM VM"
  description = ""

  settings {
    timelimit {
      duration = "1h"
    }
    idle {
      enabled = false
    }
  }

  layout "single_column" {
    reference = resource.layout.single_panel

    tab "terminal" {
      panel  = "terminal"
      target = resource.terminal.shell
    }

    tab "vscode" {
      panel  = "terminal"
      target = resource.editor.vscode
    }

    instructions {
      panel = "instructions"
    }
  }

  content {
    chapter "login" {
      title       = "Log into your ARM VM"
      layout_name = "single_column"

      page "notes" {
        reference = resource.page.notes
      }

      page "first" {
        reference = resource.page.first
      }
    }
  }
}