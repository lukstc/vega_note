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

## Scale

- Domain: 匹配数据和viz量度【一般来自于data数据】
- 需要注意：如果想改变axes显示数据范围，是在Axes中修改



## Axes

- values: array显示设置axes上显示的数据量度
- 

## Layout
- **columns**: 设置视图的col数量（假如有两个图，如何摆放，竖着横着）如果不specify，或者为0，则默认为无限的col



## Group的使用

- 核心概念是将可视化中不同的元素组成一个集合，方便



## Data

- 没有key命名的data例如```[1,2,3]```会自动生成key/col name： ***data***

## Transform

- 不产生新数据或者是不filter数据的transform可以直接用在mark内部
- Transform - Sequence
  - "as" -默认“data”
  - "stop" is exclusive



## Memo & Tips

- 注意拼写signal
- 注意数据内部命名与拼写
- transform对数据的操作，也是层层叠加上去的的，参考[Pi Monte Carlo](https://vega.github.io/vega/examples/pi-monte-carlo/)对数据的transform过程
- 修改数据显示范围```{7,8,9}```做柱状图，显示Y轴[6,10]:
  - 修改scale domain Min 为 6
  - 修改mark y2 为6
  - 【应该有更标准高效的办法，pending研究】



## 问题和疑问

- [Pi Monte Carlo](https://vega.github.io/vega/examples/pi-monte-carlo/)
  - #285 - map scale时候x map到height，需要reverse：true？【个人理解：绘制Axes时候，height上面的量度转投到横轴上时，是从大到小的，所以需要在scale时候reverse？】
  - #78&93&174 ```"width": {"signal": "height"},``` signal由event或者变量驱动interactive，height此处应为固定值，为何如此设置，？
    - 如果改成```"width": "height"``无法正常显示。UI提示需要array或者object，doc中写width take number
    - 【改成"width": {"value":380}可以正常显示】
  - Bind的插件？位置可以控制吗
  - #229 ```"text": {"signal": "'Estimate: ' + format(datum.estimate, ',.3f')"}``` 【如何理解此处的signal？】