from "%darg/ui_imports.nut" import *
let { colors } = require("colors.nut")

let ui = {
  full_rect = function(children=[], width=0, height=0, color=colors.black, styles={}) {
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

  image = function(image, width=10, height=10, styles={}) {
    return styles.__merge({
      rendObj = ROBJ_IMAGE,
      image = Picture(image),
      size = [sh(width), sh(height)]
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