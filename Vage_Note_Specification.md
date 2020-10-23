## Specification

- 控制全局设置，设置内容会cast到subset元件元素中去（如果subset有单独声明，则会被overwrite）

- eg.

  ```json
  {
    "$schema": "https://vega.github.io/schema/vega/v5.json",
    "description": "A specification outline example.",
    "width": 500,
    "height": 200,
    "padding": 5,
    "autosize": "pad",
  
    "signals": [],
    "data": [],
    "scales": [],
    "projections": [],
    "axes": [],
    "legends": [],
    "marks": []
  }
  ```
  
  Vega views can be sized (and resized) in various ways. If an object, the value should have the format `{"type": "pad", "resize": true}`, where `type` is one of the autosize strings and resize is a boolean indicating if autosize layout should be re-calculated on every update.
## Top-Level Specification Properties

| Property    |                             Type                             | Description                                                  |
| :---------- | :----------------------------------------------------------: | :----------------------------------------------------------- |
| $schema     |      [URL](https://vega.github.io/vega/docs/types/#URL)      | The URL for the Vega schema.                                 |
| description |   [String](https://vega.github.io/vega/docs/types/#String)   | A text description of the visualization. In versions ≥ 5.10, the description determines the [`aria-label` attribute](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/ARIA_Techniques/Using_the_aria-label_attribute) for the container element of a Vega view. |
| background  | [Color](https://vega.github.io/vega/docs/types/#Color) \| [Signal](https://vega.github.io/vega/docs/types/#Signal) | The background color of the entire view (defaults to transparent). If signal-valued ≥ 5.10, the provided expression is used as the `update` property for the underlying `background` [signal definition](https://vega.github.io/vega/docs/signals). |
| width       | [Number](https://vega.github.io/vega/docs/types/#Number) \| [Signal](https://vega.github.io/vega/docs/types/#Signal) | The width in pixels of the data rectangle. If signal-valued ≥ 5.10, the provided expression is used as the `update` property for the underlying `width` [signal definition](https://vega.github.io/vega/docs/signals). |
| height      | [Number](https://vega.github.io/vega/docs/types/#Number) \| [Signal](https://vega.github.io/vega/docs/types/#Signal) | The height in pixels of the data rectangle. If signal-valued ≥ 5.10, the provided expression is used as the `update` property for the underlying `height` [signal definition](https://vega.github.io/vega/docs/signals). |
| padding     | [Number](https://vega.github.io/vega/docs/types/#Number) \| [Object](https://vega.github.io/vega/docs/types/#Object) \| [Signal](https://vega.github.io/vega/docs/types/#Signal) | The padding in pixels to add around the visualization. If a number, specifies padding for all sides. If an object, the value should have the format `{"left": 5, "top": 5, "right": 5, "bottom": 5}`. Padding is applied *after* autosize layout completes. If signal-valued ≥ 5.10, the provided expression is used as the `update` property for the underlying `padding` [signal definition](https://vega.github.io/vega/docs/signals), and should evaluate to either a padding object or number. |
| autosize    | [String](https://vega.github.io/vega/docs/types/#String) \| [Autosize](https://vega.github.io/vega/docs/specification/#autosize) \| [Signal](https://vega.github.io/vega/docs/types/#Signal) | Sets how the visualization size should be determined. If a string, should be one of `pad` (default), `fit`, `fit-x`, `fit-y`, or `none`. Object values can additionally specify parameters for content sizing and automatic resizing. See the [autosize](https://vega.github.io/vega/docs/specification/#autosize) section below for more. If signal-valued ≥ 5.10, the provided expression is used as the `update` property for the underlying `autosize` [signal definition](https://vega.github.io/vega/docs/signals), and should evaluate to a complete [autosize](https://vega.github.io/vega/docs/specification/#autosize) object. |
| config      |      [Config](https://vega.github.io/vega/docs/config)       | Configuration settings with default values for marks, axes, and legends. |
| signals     |    [Signal](https://vega.github.io/vega/docs/signals)[ ]     | Signals are dynamic variables that parameterize a visualization. |
| data        |       [Data](https://vega.github.io/vega/docs/data)[ ]       | Data set definitions and transforms define the data to load and how to process it. |
| scales      |     [Scale](https://vega.github.io/vega/docs/scales)[ ]      | Scales map data values (numbers, dates, categories, etc) to visual values (pixels, colors, sizes). |
| projections | [Projection](https://vega.github.io/vega/docs/projections)[ ] | Cartographic projections map *(longitude, latitude)* pairs to projected *(x, y)* coordinates. |
| axes        |       [Axis](https://vega.github.io/vega/docs/axes)[ ]       | Coordinate axes visualize spatial scale mappings.            |
| legends     |    [Legend](https://vega.github.io/vega/docs/legends)[ ]     | Legends visualize scale mappings for visual values such as color, shape and size. |
| title       |       [Title](https://vega.github.io/vega/docs/title)        | Title text to describe a visualization.                      |
| marks       |      [Mark](https://vega.github.io/vega/docs/marks)[ ]       | Graphical marks visually encode data using geometric primitives such as rectangles, lines, and plotting symbols. |
| encode      |   [Encode](https://vega.github.io/vega/docs/marks/#encode)   | Encoding directives for the visual properties of the top-level [group mark](https://vega.github.io/vega/docs/marks/group) representing a chart’s data rectangle. For example, this can be used to set a background fill color for the plotting area, rather than the entire view. |
| usermeta    |   [Object](https://vega.github.io/vega/docs/types/#Object)   | Optional metadata that will be ignored by the Vega parser.   |

## Autosize

Vega views can be sized (and resized) in various ways. If an object, the value should have the format `{"type": "pad", "resize": true}`, where `type` is one of the autosize strings and resize is a boolean indicating if autosize layout should be re-calculated on every update.

| Name     |                            Type                            | Description                                                  |
| :------- | :--------------------------------------------------------: | :----------------------------------------------------------- |
| type     |  [String](https://vega.github.io/vega/docs/types/#String)  | ***Required.*** The sizing format type. One of `"pad"` (default), `"fit"`, `"fit-x"`, `"fit-y"`, or `"none"`. See the [autosize types](https://vega.github.io/vega/docs/specification/#autosize-types) documentation for descriptions of each. |
| resize   | [Boolean](https://vega.github.io/vega/docs/types/#Boolean) | A boolean flag indicating if autosize layout should be re-calculated on every view update. The default (`false`) causes layout to be performed once upon initialization and in response to changes in the height and/or width signals (see [here](https://github.com/vega/vega/blob/master/packages/vega-view/src/size.js) for more on sizing logic). Otherwise, the layout is kept stable. To externally force a resize, use the [View.resize](https://vega.github.io/vega/docs/api/view/#view_resize) API method. |
| contains |  [String](https://vega.github.io/vega/docs/types/#String)  | Determines how size calculation should be performed, one of `content` (default) or `padding`. The default setting (`content`) interprets the *width* and *height* settings as the data rectangle (plotting) dimensions, to which *padding* is then added. In contrast, the `padding` setting includes the *padding* within the view size calculations, such that the *width* and *height* settings indicate the **total** intended size of the view. |

  ## Autosize Types

  The total size of a Vega visualization may be determined by multiple factors: specified *width*, *height*, and *padding* values, as well as content such as axes, legends, and titles. The support different use cases, Vega provides three different *autosize* types for determining the final size of a visualization view:

- `none`: No automatic sizing is performed. The total visualization size is determined solely by the provided width, height and padding values. For example, by default the total width is calculated as `width + padding.left + padding.right`. Any content lying outside this region will be clipped. If *autosize.contains* is set to `"padding"`, the total width is instead simply *width*.
  - `pad`: Automatically increase the size of the view such that all visualization content is visible. This is the default *autosize* setting, and ensures that axes, legends and other items outside the normal width and height are included. The total size will often exceed the specified width, height, and padding.
- `fit`: Automatically adjust the layout in an attempt to force the total visualization size to fit within the given width, height and padding values. This setting causes the plotting region to be made smaller in order to accommodate axes, legends and titles. As a result, the value of the *width* and *height* signals may be changed to modify the layout. Though effective for many plots, the `fit` method can not always ensure that all content remains visible. For example, if the axes and legends alone require more space than the specified width and height, some of the content will be clipped. Similar to `none`, by default the total width will be `width + padding.left + padding.right`, relative to the original, unmodified *width* value. If *autosize.contains* is set to `"padding"`, the total width will instead be the original *width*.
  - `fit-x`: Similar to `fit`, except that only the width (x-axis) is adjusted to fit the given dimensions. The view height is automatically sized as if set to `pad`. ≥ 3.1
- `fit-y`: Similar to `fit`, except that only the height (y-axis) is adjusted to fit the given dimensions. The view width is automatically sized as if set to `pad`. ≥ 3.1