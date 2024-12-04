from "%darg/ui_imports.nut" import *

let defStyle = {}
let defTextStyle = {}

let defBoxStyle = {
  padding = hdpx(3),
  borderWidth = hdpx(1),
  borderRadius = hdpx(2),
  color = Color(150,150,150),
  hoverColor = Color(250,250,250)
}

function createText(text, state=null, stateFlags=null, style = null){
  return @(){
    watch = [state, stateFlags],
    rendObj = ROBJ_TEXT,
    text = text
  }.__update(style ?? {})
}

function createBox(size, state=null, stateFlags=null, boxStyle=defBoxStyle){
  let { color, hoverColor, borderRadius } = boxStyle

  return function() {
    let sf = stateFlags?.value ?? 0
    return {
      rendObj = ROBJ_BOX,
      size = size,
      watch = stateFlags,
      borderColor = sf ? hoverColor : color,
      children = @(){
        watch = state,
        rendObj = ROBJ_BOX,
        size = flex(),
        borderColor = 0,
        fillColor = !state?.value ? sf & S_HOVER ? color : 0 : sf & S_HOVER ? hoverColor : color,
        borderRadius = borderRadius
      }
    }.__update(boxStyle ?? {})
  }
}

function createCheckbox(state, text = null, onClick = null, style = defStyle, textCtor = createText, textStyle = defTextStyle, boxCtor = createBox, boxStyle = defBoxStyle){
  let stateFlags = Watched(0)
  let [hWidth, hHeight] = calc_comp_size(textCtor("h"))
  
  let box = boxCtor([hHeight, hHeight], state, stateFlags, boxStyle)
  let label = textCtor(text, state, stateFlags, textStyle )
  return function checkbox(){
    return {
      behavior = Behaviors.Button,
      onClick = function() {
        state(!state.value)
        onClick()
      }
      onElemState = @(sf) stateFlags(sf),
      flow = FLOW_HORIZONTAL,
      gap = hWidth,
      children = [box, label]
    }.__update(style)
  }
}

return {
  checkbox = kwarg(createCheckbox),
  defBoxStyle = defBoxStyle
}