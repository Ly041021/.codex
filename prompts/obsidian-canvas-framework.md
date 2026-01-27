---
description: '用 Obsidian Canvas 画功能框架图（落地文档/架构沟通）'
argument-hint: '[MODULE="..."] [SCOPE="..."]'
---
## 核心目标


为 **非程序员** 或需要快速概览的人员，清晰地展示软件中 **不同组件如何协作** 来完成一个特定功能。

## 关键原则 (必须遵守)

1. **区分静态与动态:**

* **静态 (模块定义区):** 系统有哪些主要部件 (类、场景、管理器)。

* **动态 (功能流程区):** 特定功能是如何一步步通过这些部件实现的。

2. **聚焦交互，忽略细节:**

* **只关心:** “谁调用了谁？”、“传递了什么关键信息？”、“信号/事件是什么？”

* **不关心:** 组件内部的具体实现逻辑。

3. **视觉清晰与一致:**

* **颜色编码:** 不同类型的模块使用固定颜色，全局统一。

* **布局:** 模块区和流程区分开，流程内部整洁。

* **标签:** 连线标签必须清晰、一致。

  

## 绘制步骤 (How-To)
  
### 1. 定义核心模块 (静态区)

* **位置:** 在 Canvas 顶部或侧边单独划定区域。

* **节点:** 每个主要模块创建一个节点。

* **标题:** 模块名 (例如: `地块放置管理器`)。

* **文件链接 (必填):** 使用 `file:` 链接到代码文件。

* **核心职责 (1-2句):** 最关键的功能 (例如: "处理地块放置/移除规则")。

* **(可选) 关键点:** 重要的依赖或信号。

* **颜色:** **必须** 为不同类型的模块指定颜色并全局统一 (例如: 管理器用绿色, UI用黄色, 场景/数据用青色, 核心逻辑用红色, IO用橙色)。

### 2. 绘制功能流程 (动态区)

* **位置:** 为每个功能创建独立的区域。

* **流程标题:** 使用大号文字节点标明功能 (例如: `**功能1: 选择地块**`)。

* **流程节点:** 放置此流程涉及的模块的 **简化版** 节点。

* 只保留与当前流程相关的简要说明。

* 可添加代表 “触发器” (如UI按钮、输入事件) 或 “结果” (如实例化场景) 的节点。

* 颜色 **必须** 与静态区的模块定义保持一致。

* **交互连线 (Edges):** **这是关键！**

* 用 **箭头** 表示交互方向。

* **标签 (Label): 必须清晰说明交互内容！**

* **调用:** `动词: 方法名(关键参数)` (例如: `调用: place_tile(tile_data)`)。

* **信号:** `Signal: 信号名(参数)` (例如: `Signal: pressed` 或 `Signal: save_requested(path)`)。

* **动作/结果:** `Action: 描述` (例如: `Action: Instantiate TileScene`, `Action: Load/Ref TileScene`)。

  

### 3. 布局与样式 (Polish)

* **分离:** 使用分组框 (Group) 或留白明确区分模块区和流程区。

* **整洁:** 减少连线交叉，节点排列有序。

* **一致:** 严格遵守颜色、标签格式。




## 给 AI 的提示 (核心要点)

1. **明确目标:** 要画哪个功能？

2. **找相关组件:** 涉及哪些代码文件？

3. **分析交互:** 它们之间如何调用、发信号？

4. **按步骤画:** 先画静态模块，再画动态流程。

5. **保持简洁:** 用词精练，标签清晰。

## 实践范例
以下是一个参考

```
{
    "nodes":[
        {"id":"group_f7","type":"group","x":-980,"y":2060,"width":3080,"height":900},
        {"id":"group_f3","type":"group","x":-980,"y":320,"width":2220,"height":520},
        {"id":"group_f5","type":"group","x":-980,"y":1220,"width":2220,"height":430},
        {"id":"group_f6","type":"group","x":-980,"y":1720,"width":2220,"height":280},
        {"id":"group_f2","type":"group","x":-980,"y":30,"width":2220,"height":240},
        {"id":"group_f1","type":"group","x":-980,"y":-270,"width":2220,"height":240},
        {"id":"group_f4","type":"group","x":-980,"y":900,"width":2220,"height":240},
        {"id":"flow3_title","type":"text","text":"**功能3: 调整网格**","x":-950,"y":340,"width":200,"height":40},
        {"id":"f3_ui","type":"text","text":"UI 控件\n(输入框)","x":-950,"y":410,"width":200,"height":100,"color":"#ffeb3b"},
        {"id":"flow2_title","type":"text","text":"**功能2: 放置地块**","x":-950,"y":50,"width":200,"height":40},
        {"id":"f2_eg","type":"text","text":"编辑器网格\n(检测点击, 发送坐标)","x":-950,"y":120,"width":200,"height":100,"color":"#2196f3"},
        {"id":"f4_le","type":"text","text":"关卡编辑器\n(处理输入)","x":-350,"y":990,"width":200,"height":100,"color":"#ff6b6b"},
        {"id":"f4_cc","type":"text","text":"摄像机控制器\n(处理移动)","x":980,"y":990,"width":200,"height":100,"color":"#9c27b0"},
        {"id":"flow4_title","type":"text","text":"**功能4: 摄像机控制**","x":-950,"y":920,"width":200,"height":40},
        {"id":"f4_input","type":"text","text":"输入事件","x":-950,"y":990,"width":200,"height":100,"color":"#9c27b0"},
        {"id":"flow1_title","type":"text","text":"**功能1: 选择地块**","x":-950,"y":-250,"width":200,"height":40},
        {"id":"f3_eg","type":"text","text":"编辑器网格\n(调整大小)","x":980,"y":410,"width":200,"height":100,"color":"#2196f3"},
        {"id":"f3_tm","type":"text","text":"地块放置管理器\n(移除越界地块)","x":980,"y":720,"width":200,"height":100,"color":"#4caf50"},
        {"id":"f3_gm","type":"text","text":"网格管理器\n(处理网格调整)","x":250,"y":410,"width":200,"height":100,"color":"#2196f3"},
        {"id":"f2_le","type":"text","text":"关卡编辑器\n(处理信号)","x":-350,"y":120,"width":200,"height":100,"color":"#ff6b6b"},
        {"id":"f2_ts","type":"text","text":"地块场景\n(被实例化)","x":980,"y":120,"width":200,"height":100,"color":"#4db6ac"},
        {"id":"f2_tm","type":"text","text":"地块放置管理器\n(检查目标坐标层级冲突, 如无冲突则执行放置)","x":240,"y":120,"width":220,"height":100,"color":"#4caf50"},
        {"id":"f3_le","type":"text","text":"关卡编辑器\n(处理信号)","x":-350,"y":620,"width":200,"height":100,"color":"#ff6b6b"},
        {"id":"f1_ui","type":"text","text":"UI 控件\n(地块按钮)","x":-950,"y":-180,"width":200,"height":100,"color":"#ffeb3b"},
        {"id":"module_ui","type":"text","text":"**UI 控制器\n(LevelEditor/level_editor_ui.gd)**\n\n- 提供用户交互界面 (如地块选择按钮, 保存/加载按钮, 网格大小输入框)\n- **发出** 用户操作的信号给 '关卡编辑器' (例如 `tile_selected`, `save_requested`)","file":"LevelEditor/level_editor_ui.gd","x":-1480,"y":-1360,"width":340,"height":320,"color":"#ffeb3b"},
        {"id":"module_eg","type":"text","text":"**编辑器网格 (LevelEditor/Grid/editor_grid.gd)**\n\n- 在屏幕上绘制编辑区域的网格线\n- 检测鼠标点击事件\n- 知道鼠标点击的位置对应网格的哪个格子\n- 发送网格点击信号给关卡编辑器","file":"LevelEditor/Grid/editor_grid.gd","x":-160,"y":-1360,"width":370,"height":320,"color":"#2196f3"},
        {"id":"module_ts","type":"text","text":"**地块场景 (Level/TileTypes/*_tile.tscn)**\n\n- 代表一个可以放置的地块 (如草地、墙壁)\n- 包含地块的外观、数据等信息\n- 定义地块属于哪个层级 (例如地面层、建筑层)","x":220,"y":-1360,"width":385,"height":320,"color":"#4db6ac"},
        {"id":"module_gm","type":"text","text":"**网格管理器 (LevelEditor/Grid/grid_manager.gd)**\n\n- 处理网格大小调整的逻辑\n- 负责清理超出网格边界的地块\n- 调用编辑器网格重绘网格线","file":"LevelEditor/Grid/grid_manager.gd","x":-160,"y":-1030,"width":370,"height":300,"color":"#2196f3"},
        {"id":"module_ls","type":"text","text":"**关卡保存器 (LevelEditor/Persistence/level_saver.gd)**\n\n- 接收当前编辑器中的所有地块信息和要保存的文件路径\n- 将这些地块信息打包成一个完整的关卡文件\n- 将关卡文件保存到电脑硬盘上","file":"LevelEditor/Persistence/level_saver.gd","x":620,"y":-1360,"width":460,"height":320,"color":"#ff9800"},
        {"id":"module_pm","type":"text","text":"**持久化管理器 (LevelEditor/Persistence/persistence_manager.gd)**\n\n- 协调关卡的保存和加载操作\n- 处理与保存器和加载器的交互\n- 管理保存和加载过程中的数据准备和清理","file":"LevelEditor/Persistence/persistence_manager.gd","x":620,"y":-1030,"width":460,"height":300,"color":"#ff9800"},
        {"id":"module_ll","type":"text","text":"**关卡加载器 (LevelEditor/Persistence/level_loader.gd)**\n\n- 接收要加载的关卡文件路径\n- 清理编辑器中当前已有的地块 (通过'地块放置管理器')\n- 读取指定的关卡文件\n- 将文件中的地块在编辑器里重新摆放出来\n- 告知 '地块放置管理器' 新加载的地块信息","file":"LevelEditor/Persistence/level_loader.gd","x":620,"y":-720,"width":460,"height":300,"color":"#ff9800"},
        {"id":"f1_le","type":"text","text":"关卡编辑器\n(处理信号, 更新选择, 创建预览)","x":-350,"y":-180,"width":270,"height":100,"color":"#ff6b6b"},
        {"id":"f1_ts","type":"text","text":"地块场景\n(加载预览) ","x":980,"y":-180,"width":200,"height":100,"color":"#4db6ac"},
        {"id":"module_le","type":"text","text":"**关卡编辑器 \n(LevelEditor/level_editor.gd)**\n\n- 整个关卡编辑器的核心协调器\n- **接收并响应** 来自 'UI 控制器' 的操作信号 (如按钮点击)\n- 管理编辑器的当前状态 (例如当前选中的是哪种地块)\n- 协调各个管理器的初始化和交互 (网格管理器, 持久化管理器等)","file":"LevelEditor/level_editor.gd","x":-1130,"y":-1360,"width":300,"height":320,"color":"#ff6b6b"},
        {"id":"module_cc","type":"text","text":"**摄像机控制器 (LevelEditor/editor_camera_controller.gd)**\n\n- 处理鼠标和键盘输入来移动、旋转编辑器的视角\n- 管理摄像机的位置和朝向","file":"LevelEditor/editor_camera_controller.gd","x":-820,"y":-1360,"width":270,"height":320,"color":"#9c27b0"},
        {"id":"module_tm","type":"text","text":"**地块放置管理器 (LevelEditor/tile_placement_manager.gd)**\n\n- 处理放置/移除地块的规则 (例如防止重叠)\n- 记录每个网格坐标上都放置了哪些地块","file":"LevelEditor/tile_placement_manager.gd","x":-540,"y":-1360,"width":370,"height":320,"color":"#4caf50"},
        {"id":"flow7_title","type":"text","text":"**功能7: 加载关卡**","x":-960,"y":2120,"width":200,"height":40},
        {"id":"f7_ui","type":"text","text":"UI 控件\n(加载按钮, FileDialog)","x":-960,"y":2190,"width":210,"height":100,"color":"#ffeb3b"},
        {"id":"f7_tm_add","type":"text","text":"地块放置管理器\n(添加加载的地块)","x":1820,"y":2660,"width":200,"height":100,"color":"#4caf50"},
        {"id":"f7_tscn","type":"text","text":"关卡场景文件 (.tscn)\n(被加载和实例化)","x":1820,"y":2320,"width":200,"height":100,"color":"#4db6ac"},
        {"id":"f7_eg","type":"text","text":"编辑器网格\n(调整大小, 提供边界)","x":1820,"y":2090,"width":200,"height":100,"color":"#2196f3"},
        {"id":"flow6_title","type":"text","text":"**功能6: 删除地块**","x":-950,"y":1740,"width":200,"height":40},
        {"id":"f6_input","type":"text","text":"输入事件\n(Delete 键)","x":-950,"y":1810,"width":200,"height":100,"color":"#9c27b0"},
        {"id":"f6_tm","type":"text","text":"地块放置管理器\n(调用 remove_tile)","x":980,"y":1810,"width":200,"height":100,"color":"#4caf50"},
        {"id":"f6_le","type":"text","text":"关卡编辑器\n(处理 Delete 键, 获取高亮坐标)","x":150,"y":1810,"width":200,"height":100,"color":"#ff6b6b"},
        {"id":"f7_le","type":"text","text":"关卡编辑器\n(处理UI信号)","x":-550,"y":2770,"width":200,"height":100,"color":"#ff6b6b"},
        {"id":"f7_pm","type":"text","text":"持久化管理器\n(协调加载流程)","x":-150,"y":2140,"width":200,"height":100,"color":"#ff9800"},
        {"id":"f7_ll","type":"text","text":"关卡加载器\n(执行加载, 清理, 添加)","x":300,"y":2500,"width":240,"height":100,"color":"#ff9800"},
        {"id":"f7_gm","type":"text","text":"网格管理器\n(调整网格大小)","x":1080,"y":2090,"width":200,"height":100,"color":"#2196f3"},
        {"id":"flow5_title","type":"text","text":"**功能5: 保存关卡**","x":-950,"y":1240,"width":200,"height":40},
        {"id":"f5_ui","type":"text","text":"UI 控件\n(保存按钮, FileDialog)","x":-950,"y":1310,"width":200,"height":100,"color":"#ffeb3b"},
        {"id":"f5_pm","type":"text","text":"持久化管理器\n(协调保存流程)","x":150,"y":1310,"width":200,"height":100,"color":"#ff9800"},
        {"id":"f5_tm","type":"text","text":"地块放置管理器\n(提供地块列表)","x":880,"y":1310,"width":300,"height":100,"color":"#4caf50"},
        {"id":"f5_ls","type":"text","text":"关卡保存器\n(创建LevelRoot, 保存网格元数据, 复制地块并保存各自元数据)","x":880,"y":1500,"width":300,"height":120,"color":"#ff9800"},
        {"id":"f5_le","type":"text","text":"关卡编辑器\n(处理UI信号)","x":-350,"y":1500,"width":200,"height":100,"color":"#ff6b6b"},
        {"id":"f7_tm_clear","type":"text","text":"地块放置管理器\n(清空现有地块)","x":320,"y":2800,"width":200,"height":100,"color":"#4caf50"}
    ],
    "edges":[
        {"id":"edge_f1_ui_le","fromNode":"f1_ui","fromSide":"right","toNode":"f1_le","toSide":"left","label":"Signal: pressed"},
        {"id":"edge_f1_le_ts","fromNode":"f1_le","fromSide":"right","toNode":"f1_ts","toSide":"left","label":"Action: Load/Ref TileScene"},
        {"id":"edge_f2_eg_le","fromNode":"f2_eg","fromSide":"right","toNode":"f2_le","toSide":"left","label":"Signal: tile_clicked(coords)"},
        {"id":"edge_f2_le_tm","fromNode":"f2_le","fromSide":"right","toNode":"f2_tm","toSide":"left","label":"Call: place_tile(tile_data)"},
        {"id":"edge_f2_tm_ts","fromNode":"f2_tm","fromSide":"right","toNode":"f2_ts","toSide":"left","label":"Action: Instantiate TileScene"},
        {"id":"edge_f3_ui_le","fromNode":"f3_ui","fromSide":"right","toNode":"f3_le","toSide":"left","label":"Signal: value_changed(value)"},
        {"id":"edge_f3_le_gm","fromNode":"f3_le","fromSide":"right","toNode":"f3_gm","toSide":"left","label":"Call: handle_grid_resize(...)"},
        {"id":"edge_f3_gm_tm","fromNode":"f3_gm","fromSide":"right","toNode":"f3_tm","toSide":"left","label":"Call: _clear_tiles_outside_bounds(...)"},
        {"id":"edge_f3_gm_eg","fromNode":"f3_gm","fromSide":"right","toNode":"f3_eg","toSide":"left","label":"Call: resize_grid(...)"},
        {"id":"edge_f4_input_le","fromNode":"f4_input","fromSide":"right","toNode":"f4_le","toSide":"left","label":"Event: _input(event)"},
        {"id":"edge_f4_le_cc","fromNode":"f4_le","fromSide":"right","toNode":"f4_cc","toSide":"left","label":"Call: handle_input(event)"},
        {"id":"edge_f5_ui_le","fromNode":"f5_ui","fromSide":"right","toNode":"f5_le","toSide":"left","label":"Signal: save_requested(path)"},
        {"id":"edge_f5_le_pm","fromNode":"f5_le","fromSide":"right","toNode":"f5_pm","toSide":"left","label":"Call: handle_save_request(path)"},
        {"id":"edge_f5_pm_tm","fromNode":"f5_pm","fromSide":"right","toNode":"f5_tm","toSide":"left","label":"Access: _placed_tiles"},
        {"id":"edge_f5_pm_ls","fromNode":"f5_pm","fromSide":"right","toNode":"f5_ls","toSide":"left","label":"Call: save_level(tiles, path, grid_bounds)"},
        {"id":"edge_f6_input_le","fromNode":"f6_input","fromSide":"right","toNode":"f6_le","toSide":"left","label":"Event: _unhandled_input(event)"},
        {"id":"edge_f6_le_tm","fromNode":"f6_le","fromSide":"right","toNode":"f6_tm","toSide":"left","label":"Call: remove_tile(pos)"},
        {"id":"edge_f7_ui_le","fromNode":"f7_ui","fromSide":"right","toNode":"f7_le","toSide":"left","label":"Signal: load_requested(path)"},
        {"id":"edge_f7_le_pm","fromNode":"f7_le","fromSide":"right","toNode":"f7_pm","toSide":"left","label":"Call: handle_load_request(path)"},
        {"id":"edge_f7_pm_ll","fromNode":"f7_pm","fromSide":"right","toNode":"f7_ll","toSide":"left","label":"Call: load_level(path, tile_manager, editor_grid)"},
        {"id":"edge_f7_ll_tm_clear","fromNode":"f7_ll","fromSide":"bottom","toNode":"f7_tm_clear","toSide":"top","label":"Call: clear_all_tiles()"},
        {"id":"edge_f7_ll_tscn_load","fromNode":"f7_ll","fromSide":"right","toNode":"f7_tscn","toSide":"left","label":"Call: ResourceLoader.load(path)"},
        {"id":"edge_f7_tscn_ll_inst","fromNode":"f7_tscn","fromSide":"bottom","toNode":"f7_ll","toSide":"top","label":"Action: Instantiate & Return Root"},
        {"id":"edge_f7_ll_gm","fromNode":"f7_ll","fromSide":"right","toNode":"f7_gm","toSide":"left","label":"Call: handle_grid_resize(...)"},
        {"id":"edge_f7_gm_eg","fromNode":"f7_gm","fromSide":"right","toNode":"f7_eg","toSide":"left","label":"Call: resize_grid(...)"},
        {"id":"edge_f7_ll_tm_add","fromNode":"f7_ll","fromSide":"right","toNode":"f7_tm_add","toSide":"left","label":"Call: place_tile(grid_pos, scene) [Loop]"}
    ]
}
```