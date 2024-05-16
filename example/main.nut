from "%darg/ui_imports.nut" import *

let { ui } = require("%dgite/ui.nut")
let { colors } = require("%dgite/colors.nut")
let { styles } = require("style.nut")

let canvasDas = load_das("%main/canvas.das")

let panel = ui.flow([
  ui.text("This is a text"),

  ui.checkbox({
    state = Watched(true),
    text = "A Checkbox",
    onClick = function() {
      vlog("Checkbox clicked")
    }
  })
  
  ui.input(
    Watched("This is an input"), 
    [18, 4], 
    styles.input
  ),

  ui.button("This is merely a button", {
    onClick = function() {
      vlog("Start button clicked")
    }
  }),

  ui.rect([
      ui.text("This is a full rect", colors.black)
    ], 
    [20, 20], 
    colors.green, 
    styles.centered
  ),

  ui.rect([
      ui.text("Unfilled", colors.black)
    ], 
    [20, 20], 
    colors.transparent,
    styles.centered.__merge({
      borderWidth = 1,
      borderColor = colors.blue
    })
  )

  ui.canvas([
    ui.text("Rect from Das")
  ], {
    script = canvasDas,
    draw = "draw_rect",
    setup = "setup_data"
  }, [20, 20], styles.centered)

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
})

let mainUI = ui.flow(panel, FLOW_VERTICAL, colors.background, styles.centered).__merge({
  cursor = customCursor,
})

return mainUI