from "%darg/ui_imports.nut" import *

let { ui } = require("%dgite/ui.nut")
let { colors } = require("%dgite/colors.nut")

let styles = {
  centered = {
    halign = ALIGN_CENTER,
    valign = ALIGN_CENTER
  }

  panel = {
    halign = ALIGN_CENTER,
    valign = ALIGN_CENTER,
    gap = 12,
  }
}

let panel = ui.flow([
  ui.text("This is a text")

  ui.button("This is merely a button", {
    onClick = function() {
      print("Start button clicked")
    }

    onHover = function(on) {
      print("Start button hovered")
    }
  })

  ui.full_rect([
    ui.text("This is a full rect", colors.black)
  ], 200, 200, colors.green, styles.centered)

], FLOW_VERTICAL, colors.background, styles.panel)

let customCursor = Cursor({
  rendObj = ROBJ_VECTOR_CANVAS,
  size = [sh(2.5), sh(2.5)],
  commands = [
    [VECTOR_WIDTH, hdpx(1.4)],
    [VECTOR_FILL_COLOR, Color(10,10,10,200)],
    [VECTOR_COLOR, Color(180,180,180,100)],
    [VECTOR_POLY, 0,0, 80,65, 46,65, 35,100],
  ]
});

let mainUI = ui.flow(panel, FLOW_VERTICAL, colors.background, styles.centered).__merge({
  cursor = customCursor,
});

return mainUI;