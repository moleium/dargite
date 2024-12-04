from "%darg/ui_imports.nut" import *
from "%darg/laconic.nut" import *

/*
  EasyUI - A wrapper library for daRg UI framework
  Provides simplified component creation and state management
*/

// ================== Component Creation Helpers ==================

let EasyUI = {
  // Basic Components
  Text = function(params = {}) {
    return {
      rendObj = ROBJ_TEXT
      size = [SIZE_TO_CONTENT, SIZE_TO_CONTENT]
      color = Color(255, 255, 255)
    }.__update(params)
  }

  Button = function(params = {}) {
    return {
      rendObj = ROBJ_BOX
      size = [hdpx(200), hdpx(50)]
      fillColor = Color(40, 40, 40)
      borderColor = Color(80, 80, 80)
      borderWidth = hdpx(1)
      behavior = Behaviors.Button
      sound = {
        click = "ui/button_click"
        hover = "ui/button_hover"
      }
    }.__update(params)
  }

  Panel = function(params = {}) {
    return {
      rendObj = ROBJ_BOX
      size = [flex(), SIZE_TO_CONTENT]
      flow = FLOW_VERTICAL
      gap = hdpx(8)
      padding = hdpx(16)
      fillColor = Color(20, 20, 20, 180)
      borderColor = Color(40, 40, 40)
      borderWidth = hdpx(1)
    }.__update(params)
  }

  // Layout Components
  Row = function(params = {}) {
    return {
      size = [flex(), SIZE_TO_CONTENT]
      flow = FLOW_HORIZONTAL
      gap = hdpx(8)
    }.__update(params)
  }

  Column = function(params = {}) {
    return {
      size = [flex(), SIZE_TO_CONTENT]
      flow = FLOW_VERTICAL
      gap = hdpx(8)
    }.__update(params)
  }

  // ================== State Management ==================
  createStore = function(config) {
    let state = {}
    let actions = {}
    let subscribers = []

    function notifySubscribers() {
      subscribers.each(@(sub) sub())
    }

    // Initialize state with Watched values
    foreach(key, value in config?.state ?? {})
      state[key] <- Watched(value)

    // Create actions that can modify state
    foreach(name, fn in config?.actions ?? {})
      actions[name] <- function(value = null) {
        fn(state, value)
        notifySubscribers()
      }

    return {
      state
      actions
      subscribe = function(callback) {
        subscribers.append(callback)
        return @() subscribers.remove(subscribers.indexof(callback))
      }
      getState = @() state
    }
  }

  // ================== Component Builder ==================
  Component = function(config) {
    return function(props = {}) {
      // Merge default props with provided props
      let finalProps = (config?.defaultProps ?? {}).__merge(props)
      
      // Setup internal state if needed
      local state = {}
      if (config?.setup != null)
        state = config.setup(finalProps)

      // Create the render function
      let render = @() config.render(finalProps, state)

      // Add watch parameters if state uses Watched values
      local hasWatched = false
      foreach(v in state) {
        if (v instanceof Watched) {
          hasWatched = true
          break
        }
      }

      return hasWatched ? @() {
        watch = state
        children = render()
      } : render()
    }
  }

  // ================== Utility Functions ==================
  styles = {
    centered = {
      halign = ALIGN_CENTER
      valign = ALIGN_CENTER
    }
    fullSize = {
      size = flex()
    }
    textPrimary = {
      color = Color(255, 255, 255)
    }
    textSecondary = {
      color = Color(180, 180, 180)
    }
  }

  colors = {
    primary = Color(66, 135, 245)
    secondary = Color(156, 39, 176)
    success = Color(76, 175, 80)
    error = Color(244, 67, 54)
    warning = Color(255, 152, 0)
  }
}

return EasyUI