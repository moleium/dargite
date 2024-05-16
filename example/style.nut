from "%darg/ui_imports.nut" import *
let { colors } = require("%dgite/colors.nut")

let styles = {
  centered = {
    halign = ALIGN_CENTER,
    valign = ALIGN_CENTER
  },

  panel = {
    halign = ALIGN_CENTER,
    valign = ALIGN_CENTER,
    gap = 12,
    size = [sw(100), sh(100)]
  },

  input = {
    borderWidth = 1,
    borderRadius = 4,
    borderColor = colors.green,
    fillColor = colors.black,
    color = colors.white,
  }
}

return {
  styles = styles
}