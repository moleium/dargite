from "%darg/ui_imports.nut" import *

let { colors } = require("colors.nut")
let chk = require("components/checkbox.nut")

/*
* TODO:
* Fix where we can't reference a function in default styles
* Because the table is defined as lambda
* REFERENCES:
* - ui.button
* - ui.input
*/

let ui = {
  rect = function(children=[], size=[], styles={}) {
    return styles.__merge({
      rendObj = ROBJ_BOX,
      fillColor = colors.transparent,
      size = [sh(size[0]), sh(size[1])],
      children = children
    });
  },

  full_rect = function(children=[], size=[], color=colors.black, styles={}) {
    return styles.__merge({
      size = [sh(size[0]), sh(size[1])],
      fillColor = color,
      children = children,
      rendObj = ROBJ_BOX
    });
  },

  flow = function(children=[], flow=FLOW_VERTICAL, color=colors.black, styles={}) {
    return styles.__merge({
      flow = flow,
      color = color,
      children = children,
      rendObj = ROBJ_SOLID
    });
  },

  canvas = function(children=[], params={}, size=[10, 10], styles={}) {
    return styles.__merge({
      rendObj = ROBJ_DAS_CANVAS,
      script = params.script,
      drawFunc = params.draw,
      setupFunc = params.setup,
      size = [sh(size[0]), sh(size[1])],
      children = children
    });
  },

  line = function(start, end, size=[10, 10], styles={}) {
    return styles.__merge({
      rendObj = ROBJ_VECTOR_CANVAS,
      size = [sh(size[0]), sh(size[1])],
      lineWidth = hdpx(2.5),
      color = Color(50, 200, 255),
      fillColor = Color(122, 1, 0, 0),
      commands = [
        [VECTOR_LINE, start[0], start[1], end[0], end[1]]
      ]
    });
  },

  text = function(text, color=colors.white, styles={}) {
    return @() styles.__merge({
      rendObj = ROBJ_TEXT,
      color = color,
      text = text
    });
  },

  input = function(text_state, size, color=colors.white, styles={}) {
    return @() styles.__merge({
      rendObj = ROBJ_BOX,
      fillColor = color,
      padding = 5,
      size = [sh(size[0]), sh(size[1])],

      watch = [text_state],

      // TODO: Fix this, use ui.text instead of duplicating
      children = {
        rendObj = ROBJ_TEXT,
        vplace = ALIGN_CENTER,
        hplace = ALIGN_CENTER,
        size = [flex(), fontH(100)],

        behavior = Behaviors.TextInput,

        text = text_state.value,
        key = text_state,

        onChange = function(val) {
          text_state.update(val)
        },
        onReturn = function() {
          text_state.update("")
        },
        onEscape = function() {
          text_state.update("")
        }
      }
    })
  }

  button = function(text, params={}, styles={}) {
    let defaultStyles = {
      margin = [hdpx(1), hdpx(10)],
      borderColor = colors.white,
      borderRadius = hdpx(4),
      fillColor = colors.black,
      padding = [hdpx(4), hdpx(10)],
      transform = {},
      behavior = Behaviors.Button,
      onClick = params?.onClick,
      onHover = params?.onHover,
      rendObj = ROBJ_BOX,
      children = [
        this.text(text, colors.white)
      ]
    };
  
    return styles.__merge(defaultStyles);
  },

  checkbox = function(params={}, styles = chk.defBoxStyle) {
    let { state, text, onClick } = params

    let checkbox = chk.checkbox({
      state    = state,
      text     = text,
      onClick  = onClick,
      boxStyle = styles
    });

    let panel = @() { children = [checkbox] };

    return {
      rendObj = ROBJ_SOLID,
      color = colors.transparent,
      children = panel
    };
  }

  image = function(image, size=[10,10], styles={}) {
    return styles.__merge({
      rendObj = ROBJ_IMAGE,
      image = Picture(image),
      size = [sh(size[0]), sh(size[1])]
    });
  },

  br = function(height=2) {
    return {
      size = [0, height],
      color = colors.transparent,
      rendObj = ROBJ_SOLID
    };
  },
};

return {
  ui = ui,
}