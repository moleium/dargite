/*
 * - dag_stdGuiRender.h - Core rendering functionality
 */

require darg
require math
require DagorMath
require DagorStdGuiRender

/*
 * CanvasParams - Parameters for canvas rendering
 *
 * @color: Color value in E3DCOLOR format for filling the canvas
 */
struct CanvasParams
  color: E3DCOLOR

/*
 * setup_data - Initialize canvas parameters from properties
 * @props: Reference to Properties object containing initialization values
 * @storage: Reference to CanvasParams struct to store the values
 *
 * Called once during object creation to set up shared parameters.
 * Used by ROBJ_DAS_CANVAS.
 */
[export]
def setup_data(props: Properties&; var storage : CanvasParams&)
  storage.color = props |> getColor("color", E3DCOLOR(0x212121))

/*
 * draw_rect - Render the canvas rectangle
 * @ctx: GUI context for rendering
 * @rdata: Element render data containing position and size
 * @rstate: Current render state
 * @data: Canvas parameters containing colors and other properties
 *
 * Draws a rounded rectangle with specified color and properties.
 * Called each frame by ROBJ_DAS_CANVAS.
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