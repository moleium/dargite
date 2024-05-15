/*
* Objects reference:
* - dag_stdGuiRender.h
*/

require darg
require math
require DagorMath

/*
* This struct is used to share parameters between
* the setup_data and draw_rect functions.
*/
struct CanvasParams
  color: E3DCOLOR

/*
* Function: setup_data
* This function is called once when the object is created to set up
* the shared object struct. This function is passed to ROBJ_DAS_CANVAS.
*/
[export]
def setup_data(props: Properties&; var storage : CanvasParams&)
  storage.color = props |> getColor("dasTextColor", E3DCOLOR(0x212121))

/*
* This function is called every frame to draw the object. This
* function is passed to ROBJ_DAS_CANVAS.
*/
[export]
def draw_rect(var ctx: GuiContext&; rdata: ElemRenderData& const; rstate: RenderState& const; data : CanvasParams&)
  var fctx: StdGuiFontContext
  get_font_context(fctx, 0, 0, 0, 0)

  let lt = rdata.pos
  let rb = rdata.pos+rdata.size

  let frameColor = data.color
  let rounding = float4(10.0, 10.0, 10.0, 10.0)
  let thickness = 1.0

  ctx |> render_rounded_box(lt, rb, data.color, frameColor, rounding, thickness)