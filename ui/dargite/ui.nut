from "%darg/ui_imports.nut" import *

let { colors } = require("colors.nut")
let chk = require("components/checkbox.nut")

let ui = {
  // TODO: Add a way to specify the size as flex()
  rect = function(children=[], size=[], color=colors.black, styles={}) {
    return @() styles.__merge({
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
      color = colors.white,
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

  input = function(text_state, size, styles={}) {
    let { fillColor, color } = styles;

    let inputText = this.text(text_state.value, color, {
      vplace = ALIGN_CENTER,
      hplace = ALIGN_CENTER,
      size = [flex(), fontH(100)],
      behavior = Behaviors.TextInput,
  
      onChange = function(val) {
        text_state.update(val)
      },
      onReturn = function() {
        text_state.update("")
      },
      onEscape = function() {
        text_state.update("")
      }
    });
  
    let boxStyles = styles.__merge({
      watch   = [text_state],
      padding = 5
    });

    return this.rect([inputText], size, fillColor, boxStyles);
  }

  button = function(text, params={}, styles={}) {
    let self = this;
    return @() styles.__merge({
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
        self.text(text, colors.white)
      ]
    });
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