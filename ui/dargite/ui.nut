from "%darg/ui_imports.nut" import *
let { colors } = require("colors.nut")

let ui = {
  full_rect = function(width, height, color=colors.black, styles={}, children=[]) {
    return styles.__merge({
      size = [width, height],
      color = color,
      children = children,
      rendObj = ROBJ_SOLID
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

  text = function(text, color=colors.white, styles={}) {
    return styles.__merge({
      rendObj = ROBJ_TEXT,
      color = color,
      text = text
    });
  },

  button = function(text, onClick, styles={}) {
    return styles.__merge({
      behavior = Behaviors.Button,
      onClick = onClick,
      rendObj = ROBJ_BOX,
      children = [
        this.text(text)
      ]
    });
  },

  image = function(image, width=sh(10), height=sh(10), styles={}) {
    return styles.__merge({
      rendObj = ROBJ_IMAGE,
      image = Picture(image),
      size = [width, height]
    });
  },

  br = function(height=2) {
    return {
      size = [0, height],
      color = colors.transparent,
      rendObj = ROBJ_SOLID
    };
  }
};

return {
  ui = ui,
}