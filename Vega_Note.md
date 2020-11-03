# vega note

## List of Content

- [Specification-全局声明](##Specification)	Overview of a full Vega specification, including sizing and metadata.
- Config-默认视图设置	Configure defaults for visual encoding choices.
- Data-数据以及数据处理	Define, load, and parse data to visualize.
- Transforms-数据变形处理过滤分组	Apply data transforms (filter, sort, aggregate, layout) prior to visualization.
- Triggers-开关？（含义+作用+机制？）	Modify data sets or mark properties in response to signal values.
- Projections-用于匹配地图坐标&视图XY轴	Cartographic projections to map (longitude, latitude) data.
- Scales-量度、刻度：将数据数值匹配可视化范围	Map data values (numbers, strings) to visual properties (coordinates, colors, sizes).
- Schemes-分配颜色方案	Color schemes that can be used as scale ranges.
- Axes-将空间量度、刻度进行可视化	Visualize scale mappings for spatial encodings using coordinate axes.
- Legends-图例	Visualize scale mappings for color, shape and size encodings.
- Title-视图名称	Specify a chart title for a visualization.
- Marks-标志	Visually encode data with graphical marks such as rectangles, lines, and symbols.
- Signals-信号：驱动交互（和trigger关系？）	Dynamic variables that can drive interactive updates.
- Event Streams-事件流（监视事件，触发signal）	Define input event streams to specify interactions.
- Expressions-表达式（注意语法）	Express custom calculations over data and signals.
- Layout-布局（控制布局位置等变量）	Perform grid layout for a collection of group marks.
- Types-参数类型列表（用做参考）	Documentation of recurring parameter types.

---

## Specification

## Config

## Singal

- singal作为动态变量（dynamic variables that parameterize a visualization and can drive interactive behaviors）
- Event Stream驱动singal变化
- events will be evaluated according to their specifiaction order
- event激活singal更新，进一步推动全局引用了此singal的变量更新，最后view重新render
- Singal name需要为有效的JS ID，且不能为预留过的名字

## Mark

- 文字，图形，每个图中元素都都是独立的元素，需要在在json文件中单独声明
- 因为每个元素都是独立的，所有的变化也都需要单独声明并匹配【例如：hover在】
- **Text**
  - y设置y轴位置
  - ```dy``` 设置offset
- ```from``` take type **From**, [doc参考](https://vega.github.io/vega/docs/marks/#from)

- data - string
	- facet - Facet - 只可用于group mark声明，用来partition数据across multiple marks
	  - ```facet```[faceting Doc](https://vega.github.io/vega/docs/marks/#faceting) 用来定义和分割多组（group）marks的data，只有**group mark**的定义中可以使用这
	    - facet【方面，特点】可以参考翻译理解其作用和含义
	    - name - string - Required 【新生facet】
	    - data - string - Required【数据来源】
	    - field - Field - 【如果是pre-facet的data，Required】
	    - groupby - Field | Field [] - 【如果是data-driven facets，Required】指定用哪一个字段来分割数据
	    - aggregate - Object -【for data-driven facets, 声明对每一个facet的aggregate方法】

	### Group的使用
	- 核心概念是将可视化中不同的元素组成一个集合，方便对整体进行管理分配

## Scale

- Domain: 匹配数据和viz量度【一般来自于data数据】
- 需要注意：如果想改变axes显示数据范围，是在Axes中修改
- ```domainMax，domainMin```只能接```Number```
- ```range```:
  - e.g. ```"range":{"scheme":"blueorange"}```
  - 可以使用设定好的颜色，也可以自定义新的scheme



## Axes

- values: array显示设置axes上显示的数据量度
-

## Layout
- **columns**: 设置视图的col数量（假如有两个图，如何摆放，竖着横着）如果不specify，或者为0，则默认为无限的col
- e.g 如果有3个group mark，columns=3，则形成row-1*col-3，
- e.g 如果有3个group mark，columns=4，则形成row-2*col-2，fill前3个position
- group marks的在代码里的相对位置，决定了fill出现在viz里的顺序



## Data

- 没有key命名的data例如```[1,2,3]```会自动生成key/col name： ***data***

- Format:

  - format 除了可以用来声明函数格式，也可以用来改变data type

  - ```JSON
    "format":{"type":"json","parse":{"value":"number"}}
    ```


## Transform

- 不产生新数据或者是不filter数据的transform可以直接用在mark内部
- Transform - Sequence
  - "as" -默认“data”
  - "stop" is exclusive
- ```transform```很多用法可能和python实现理念不一样，注意参考doc
- ```aggregate```直接得出处理后的结果，产生新数据
- ```joinaggreage```处理产生新数据后会append到原始数据
### Layout Transform
- ```Pie```计算并转换data数字为角度数据用于pie或者是donut chart绘制
  - 参数
    - ```field```	Field： data中用于计算角度的数据field
    - ```startAngle```	Number 绘图的起始角度(default 0，正上方。north).
    - ```endAngle```	Number	绘图的结束角度(default 2 * PI).
    - ```sort``` Boolean	根据角度来排序If true, sorts the arcs according to field values (default false).
    - ```as```	String[ ]	The output fields for the computed start and end angles for each arc. The default is ["startAngle", "endAngle"]用来改名字的

## Memo & Tips

- 注意拼写signal
- 注意数据内部命名与拼写
- transform对数据的操作，也是层层叠加上去的的，参考[Pi Monte Carlo](https://vega.github.io/vega/examples/pi-monte-carlo/)对数据的transform过程
- 修改数据显示范围```{7,8,9}```做柱状图，显示Y轴[6,10]【轴的显示范围略大于数值范围】【显示效果参考笔记Modified Bar Chart】:
  - 笨办法【hard coding】
    - 修改scale domain Min 为 6
    - 修改mark y2【柱状图底部的位置】 为6
  - 新办法【transform提前处理好数据】【以IMDB rating为例，参考笔记Modified Bar Chart】
    - Step#1-数据处理transform```joinaggreage```【根据需求agg之后（min & max）并到原有数据上面Rate_min,Rate_max】
    - Step#2-数据处理transform```formula```【```min * 0.99``` & ```max * 1.01```并到原有数据上面,R_low,R_high】
    - Step#3-Scale-【Multi-Field Data References】```"fields":["R_low","R_high"]```
    - Step#4-Mark选取新的low值-```"y2": {"scale": "yy","field": "R_low"}```
    - Note: 新方法不需要hard coding，不过需要考虑：在对min和max处理之后，处理的值是否在合理范围内【Pending Review】
- 处理数type：data-format-parameter-parse【参考个人笔记Bar Chart data部分】
- 注意能接收的参数的类型：[官方doc参考](https://vega.github.io/vega/docs/types/#Value)
- [Pi Monte Carlo](https://vega.github.io/vega/examples/pi-monte-carlo/)
  - #285 - map scale时候x map到height，需要reverse：true【个人理解：绘制Axes时候，height上面的量度转投到横轴上时，是从大到小的，所以需要在scale时候reverse？】
  - #78&93&174 ```"width": {"signal": "height"},``` signal由event或者变量驱动interactive，height此处应为固定值，为何如此设置，？
    - 如果改成```"width": "height"``无法正常显示。UI提示需要array或者object，doc中写width take number
    - 【改成"width": {"value":380}可以正常显示】
    - 【Solved】```signal```传递的是一个变量，不一定是和交互相关的
  - Bind的插件？【Solved】不可以设定控制组件的样式，这部分需要通过前端JS实现
  - #229 ```"text": {"signal": "'Estimate: ' + format(datum.estimate, ',.3f')"}``` 【如何理解此处的signal？】
    - 【Solved】【传递的是可变参数】
-

## 问题和疑问

- "$schema": 似乎没有什么实际作用，删除后似乎对viz显示没有什么影响？

- ```json
  "type":"group",
        "from":{
          "facet":{
            "data":"the_score",
            "name":"facet",
            "groupby":"category"
          }
        }
  ```

- 对facet的理解：用于在多个group marks中分割数据【并且分配按照group by之后的数据，分配给各个mark】？

- field - Field - 【如果是pre-facet的data，Required】【改进grouped bar chart的图，使用pre-facet的data】【pending task】

- [Grouped Bar Chart](https://vega.github.io/vega/examples/grouped-bar-chart/) 中

  - #76

    - ```JSON
      "signals": [{"name": "height", "update": "bandwidth('yscale')"}],
      "scales": [
              {
                "name": "pos",
                "type": "band",
                "range": "height",
                "domain": {"data": "facet", "field": "position"}
              }
            ],
      ```

    - 此处的作用？

    - 个人理解是：

      - 此处bandwidth('yscale')返回的值是height的scale上的band宽度【group下每个sub-mark的bandwidth】

      - **bandwidth**(*name*[, *group*]): Returns the current band width for the named band scale transform, or zero if the scale is not found or is not a band scale. The optional *group* argument takes a scenegraph group mark item to indicate the specific scope in which to look up the scale.

      - 重新赋值给height <== 宽度

      - 此处scale是定义group内sub mark的scale，在scale

      - 更新的是group内部每个子mark内部的scale？

      - 实验

      - ```json
        # original height = 240
        # height for each group ~ 80 = 240/3
        # 以下结果可以验证上述理解 hard coding height2 value
        "signals": [
                {"name": "height", "update": "bandwidth('yscale')"},
                {"name": "height2", "value": [1,80]}
              ],

              "scales": [
                {
                  "name": "pos",
                  "type": "band",
                  "range": {"signal":"height2"},
                  "domain": {"data": "facet", "field": "position"}
                }
              ],
        ```

  - #105

    - ```json
      {
        "type": "text",
        "from": {"data": "bars"},
        "encode": {
          "enter": {
            "x": {"field": "x2", "offset": -5},
            "y": {"field": "y", "offset": {"field": "height", "mult": 0.5}},
            "fill": [
              {"test": "contrast('white', datum.fill) > contrast('black', datum.fill)", "value": "white"},
              {"value": "black"}
            ],
            "align": {"value": "right"},
            "baseline": {"value": "middle"},
            "text": {"field": "datum.value"}
          }
        }
      }
      ```

    - 为啥from data bars

    - 为啥x field 用x2

- [Line Chart]()

  - modified chart: [Error c is not a function]
    - catnull-rom
