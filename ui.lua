-- UILua5.1.lua
-- 一个功能齐全的通用UI框架，适用于Lua 5.1
-- 作者: AI助手

-- 主UI系统类
UISystem = {
    version = "1.0.0",
    author = "AI Assistant",
    components = {},
    events = {},
    defaultStyle = {
        font = "Arial",
        fontSize = 12,
        color = {r=255, g=255, b=255, a=255},
        backgroundColor = {r=50, g=50, b=50, a=200},
        borderColor = {r=100, g=100, b=100, a=255},
        borderWidth = 1
    }
}

-- 设置元表
function UISystem:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

-- UI基类
UIComponent = {
    id = "",
    x = 0,
    y = 0,
    width = 100,
    height = 50,
    visible = true,
    enabled = true,
    parent = nil,
    children = {},
    style = {},
    eventHandlers = {}
}

function UIComponent:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    
    -- 合并默认样式
    for k,v in pairs(UISystem.defaultStyle) do
        if o.style[k] == nil then
            o.style[k] = v
        end
    end
    
    -- 生成唯一ID
    if not o.id or o.id == "" then
        o.id = "ui_" .. tostring(math.random(10000, 99999))
    end
    
    return o
end

-- 设置位置
function UIComponent:setPosition(x, y)
    self.x = x or self.x
    self.y = y or self.y
    return self
end

-- 设置尺寸
function UIComponent:setSize(width, height)
    self.width = width or self.width
    self.height = height or self.height
    return self
end

-- 设置可见性
function UIComponent:setVisible(visible)
    self.visible = visible
    return self
end

-- 设置启用状态
function UIComponent:setEnabled(enabled)
    self.enabled = enabled
    return self
end

-- 添加事件监听器
function UIComponent:addEventListener(event, handler)
    if not self.eventHandlers[event] then
        self.eventHandlers[event] = {}
    end
    table.insert(self.eventHandlers[event], handler)
    return self
end

-- 触发事件
function UIComponent:triggerEvent(event, ...)
    if self.eventHandlers[event] then
        for _, handler in ipairs(self.eventHandlers[event]) do
            handler(self, ...)
        end
    end
end

-- 渲染方法（需要子类实现）
function UIComponent:render(renderer)
    -- 子类需要实现具体的渲染逻辑
end

-- 更新方法
function UIComponent:update(dt)
    -- 更新子组件
    for _, child in ipairs(self.children) do
        if child.visible and child.update then
            child:update(dt)
        end
    end
end

-- 添加子组件
function UIComponent:addChild(child)
    child.parent = self
    table.insert(self.children, child)
    return self
end

-- 移除子组件
function UIComponent:removeChild(child)
    for i, c in ipairs(self.children) do
        if c == child or c.id == child then
            table.remove(self.children, i)
            c.parent = nil
            break
        end
    end
    return self
end

-- 查找组件
function UIComponent:findById(id)
    if self.id == id then return self end
    
    for _, child in ipairs(self.children) do
        local result = child:findById(id)
        if result then return result end
    end
    
    return nil
end

-- 按钮类
UIButton = UIComponent:new{
    text = "Button",
    pressed = false,
    hovered = false
}

function UIButton:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    
    -- 初始化事件处理器
    o.eventHandlers = o.eventHandlers or {
        onClick = {},
        onMouseEnter = {},
        onMouseLeave = {},
        onMouseDown = {},
        onMouseUp = {}
    }
    
    return o
end

function UIButton:render(renderer)
    if not self.visible then return end
    
    -- 绘制背景
    local bgColor = self.style.backgroundColor
    if self.pressed then
        bgColor = {r=bgColor.r-30, g=bgColor.g-30, b=bgColor.b-30, a=bgColor.a}
    elseif self.hovered then
        bgColor = {r=bgColor.r+20, g=bgColor.g+20, b=bgColor.b+20, a=bgColor.a}
    end
    
    renderer:drawRect(self.x, self.y, self.width, self.height, bgColor)
    
    -- 绘制边框
    renderer:drawBorder(self.x, self.y, self.width, self.height, 
                       self.style.borderColor, self.style.borderWidth)
    
    -- 绘制文本
    local textX = self.x + self.width/2
    local textY = self.y + self.height/2
    renderer:drawText(self.text, textX, textY, self.style.color, 
                     self.style.font, self.style.fontSize, "center", "center")
end

-- 标签类
UILabel = UIComponent:new{
    text = "Label",
    align = "left",
    valign = "top"
}

function UILabel:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function UILabel:render(renderer)
    if not self.visible then return end
    
    renderer:drawText(self.text, self.x, self.y, self.style.color,
                     self.style.font, self.style.fontSize, self.align, self.valign)
end

-- 文本框类
UITextBox = UIComponent:new{
    text = "",
    placeholder = "",
    cursorPos = 1,
    selected = false,
    maxLength = 100
}

function UITextBox:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    
    o.eventHandlers = o.eventHandlers or {
        onTextChange = {},
        onFocus = {},
        onBlur = {},
        onEnter = {}
    }
    
    return o
end

function UITextBox:render(renderer)
    if not self.visible then return end
    
    -- 绘制背景
    renderer:drawRect(self.x, self.y, self.width, self.height, self.style.backgroundColor)
    
    -- 绘制边框
    local borderColor = self.style.borderColor
    if self.selected then
        borderColor = {r=0, g=150, b=255, a=255}
    end
    renderer:drawBorder(self.x, self.y, self.width, self.height, borderColor, self.style.borderWidth)
    
    -- 绘制文本或占位符
    local drawText = self.text
    local drawColor = self.style.color
    if drawText == "" and self.placeholder ~= "" then
        drawText = self.placeholder
        drawColor = {r=150, g=150, b=150, a=255}
    end
    
    -- 计算文本位置（考虑滚动）
    local textX = self.x + 5
    local textY = self.y + self.height/2
    
    renderer:drawText(drawText, textX, textY, drawColor,
                     self.style.font, self.style.fontSize, "left", "center")
    
    -- 绘制光标（如果选中）
    if self.selected then
        local cursorX = self.x + 5 + renderer:measureText(string.sub(drawText, 1, self.cursorPos-1), 
                                                        self.style.font, self.style.fontSize)
        renderer:drawLine(cursorX, self.y + 5, cursorX, self.y + self.height - 5, 
                         {r=255, g=255, b=255, a=255})
    end
end

-- 面板类（容器）
UIPanel = UIComponent:new{
    scrollable = false,
    scrollX = 0,
    scrollY = 0
}

function UIPanel:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function UIPanel:render(renderer)
    if not self.visible then return end
    
    -- 绘制面板背景
    renderer:drawRect(self.x, self.y, self.width, self.height, self.style.backgroundColor)
    
    -- 绘制边框
    renderer:drawBorder(self.x, self.y, self.width, self.height, 
                       self.style.borderColor, self.style.borderWidth)
    
    -- 保存当前裁剪区域
    renderer:pushClip(self.x, self.y, self.width, self.height)
    
    -- 渲染子组件
    for _, child in ipairs(self.children) do
        if child.visible then
            -- 应用滚动偏移
            local origX, origY = child.x, child.y
            child.x = origX - self.scrollX
            child.y = origY - self.scrollY
            
            child:render(renderer)
            
            -- 恢复原始位置
            child.x, child.y = origX, origY
        end
    end
    
    -- 恢复裁剪区域
    renderer:popClip()
end

-- 复选框类
UICheckBox = UIComponent:new{
    text = "CheckBox",
    checked = false
}

function UICheckBox:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    
    o.eventHandlers = o.eventHandlers or {
        onChange = {}
    }
    
    return o
end

function UICheckBox:render(renderer)
    if not self.visible then return end
    
    -- 绘制复选框框体
    local boxSize = 20
    renderer:drawRect(self.x, self.y, boxSize, boxSize, self.style.backgroundColor)
    renderer:drawBorder(self.x, self.y, boxSize, boxSize, self.style.borderColor, self.style.borderWidth)
    
    -- 绘制勾选标记
    if self.checked then
        renderer:drawLine(self.x + 5, self.y + 10, self.x + 9, self.y + 14, 
                         {r=0, g=255, b=0, a=255})
        renderer:drawLine(self.x + 9, self.y + 14, self.x + 15, self.y + 6, 
                         {r=0, g=255, b=0, a=255})
    end
    
    -- 绘制文本
    renderer:drawText(self.text, self.x + boxSize + 10, self.y + boxSize/2, 
                     self.style.color, self.style.font, self.style.fontSize, "left", "center")
end

-- 单选框类
UIRadioButton = UICheckBox:new{
    group = "default"
}

function UIRadioButton:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    
    o.eventHandlers = o.eventHandlers or {
        onChange = {}
    }
    
    return o
end

function UIRadioButton:render(renderer)
    if not self.visible then return end
    
    -- 绘制圆形单选框
    local radius = 10
    renderer:drawCircle(self.x + radius, self.y + radius, radius, self.style.backgroundColor)
    renderer:drawCircleBorder(self.x + radius, self.y + radius, radius, 
                             self.style.borderColor, self.style.borderWidth)
    
    -- 绘制选中标记
    if self.checked then
        renderer:drawCircle(self.x + radius, self.y + radius, radius - 4, 
                           {r=0, g=150, b=255, a=255})
    end
    
    -- 绘制文本
    renderer:drawText(self.text, self.x + radius*2 + 10, self.y + radius, 
                     self.style.color, self.style.font, self.style.fontSize, "left", "center")
end

-- 滑动条类
UISlider = UIComponent:new{
    minValue = 0,
    maxValue = 100,
    value = 50,
    orientation = "horizontal", -- horizontal 或 vertical
    showValue = true
}

function UISlider:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    
    o.eventHandlers = o.eventHandlers or {
        onChange = {},
        onDragStart = {},
        onDragEnd = {}
    }
    
    return o
end

function UISlider:render(renderer)
    if not self.visible then return end
    
    -- 绘制轨道
    local trackColor = {r=80, g=80, b=80, a=255}
    renderer:drawRect(self.x, self.y, self.width, self.height, trackColor)
    
    -- 计算滑块位置
    local ratio = (self.value - self.minValue) / (self.maxValue - self.minValue)
    ratio = math.max(0, math.min(1, ratio))
    
    if self.orientation == "horizontal" then
        local sliderWidth = 20
        local sliderX = self.x + (self.width - sliderWidth) * ratio
        local sliderY = self.y - 5
        
        -- 绘制滑块
        renderer:drawRect(sliderX, sliderY, sliderWidth, self.height + 10, 
                         {r=150, g=150, b=150, a=255})
        renderer:drawBorder(sliderX, sliderY, sliderWidth, self.height + 10,
                           self.style.borderColor, self.style.borderWidth)
    else
        local sliderHeight = 20
        local sliderX = self.x - 5
        local sliderY = self.y + (self.height - sliderHeight) * ratio
        
        -- 绘制滑块
        renderer:drawRect(sliderX, sliderY, self.width + 10, sliderHeight,
                         {r=150, g=150, b=150, a=255})
        renderer:drawBorder(sliderX, sliderY, self.width + 10, sliderHeight,
                           self.style.borderColor, self.style.borderWidth)
    end
    
    -- 显示当前值
    if self.showValue then
        local valueText = tostring(math.floor(self.value))
        renderer:drawText(valueText, self.x + self.width + 10, self.y + self.height/2,
                         self.style.color, self.style.font, self.style.fontSize, "left", "center")
    end
end

-- 下拉框类
UIComboBox = UIComponent:new{
    items = {},
    selectedIndex = 0,
    open = false,
    itemHeight = 25
}

function UIComboBox:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    
    o.eventHandlers = o.eventHandlers or {
        onChange = {},
        onOpen = {},
        onClose = {}
    }
    
    return o
end

function UIComboBox:render(renderer)
    if not self.visible then return end
    
    -- 绘制主框
    renderer:drawRect(self.x, self.y, self.width, self.height, self.style.backgroundColor)
    renderer:drawBorder(self.x, self.y, self.width, self.height, self.style.borderColor, self.style.borderWidth)
    
    -- 绘制文本
    local displayText = self.selectedIndex > 0 and self.items[self.selectedIndex] or "Select..."
    renderer:drawText(displayText, self.x + 10, self.y + self.height/2,
                     self.style.color, self.style.font, self.style.fontSize, "left", "center")
    
    -- 绘制下拉箭头
    local arrowSize = 10
    local arrowX = self.x + self.width - arrowSize - 10
    local arrowY = self.y + self.height/2
    
    if self.open then
        -- 向上箭头
        renderer:drawTriangle(arrowX, arrowY - arrowSize/2,
                            arrowX + arrowSize, arrowY - arrowSize/2,
                            arrowX + arrowSize/2, arrowY + arrowSize/2,
                            self.style.color)
    else
        -- 向下箭头
        renderer:drawTriangle(arrowX, arrowY + arrowSize/2,
                            arrowX + arrowSize, arrowY + arrowSize/2,
                            arrowX + arrowSize/2, arrowY - arrowSize/2,
                            self.style.color)
    end
    
    -- 绘制下拉列表
    if self.open and #self.items > 0 then
        local listHeight = #self.items * self.itemHeight
        local listY = self.y + self.height
        
        -- 绘制列表背景
        renderer:drawRect(self.x, listY, self.width, listHeight, self.style.backgroundColor)
        renderer:drawBorder(self.x, listY, self.width, listHeight, self.style.borderColor, self.style.borderWidth)
        
        -- 绘制列表项
        for i, item in ipairs(self.items) do
            local itemY = listY + (i-1) * self.itemHeight
            local itemColor = self.style.color
            
            -- 高亮选中项
            if i == self.selectedIndex then
                renderer:drawRect(self.x, itemY, self.width, self.itemHeight, 
                                 {r=50, g=100, b=200, a=255})
            end
            
            renderer:drawText(item, self.x + 10, itemY + self.itemHeight/2,
                             itemColor, self.style.font, self.style.fontSize, "left", "center")
        end
    end
end

-- 进度条类
UIProgressBar = UIComponent:new{
    minValue = 0,
    maxValue = 100,
    value = 50,
    showText = true,
    orientation = "horizontal" -- horizontal 或 vertical
}

function UIProgressBar:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function UIProgressBar:render(renderer)
    if not self.visible then return end
    
    -- 绘制背景
    renderer:drawRect(self.x, self.y, self.width, self.height, {r=60, g=60, b=60, a=255})
    renderer:drawBorder(self.x, self.y, self.width, self.height, self.style.borderColor, self.style.borderWidth)
    
    -- 计算进度
    local ratio = (self.value - self.minValue) / (self.maxValue - self.minValue)
    ratio = math.max(0, math.min(1, ratio))
    
    -- 绘制进度条
    local progressColor
    if ratio < 0.3 then
        progressColor = {r=255, g=50, b=50, a=255} -- 红色
    elseif ratio < 0.7 then
        progressColor = {r=255, g=200, b=50, a=255} -- 黄色
    else
        progressColor = {r=50, g=200, b=50, a=255} -- 绿色
    end
    
    if self.orientation == "horizontal" then
        local progressWidth = self.width * ratio
        renderer:drawRect(self.x, self.y, progressWidth, self.height, progressColor)
    else
        local progressHeight = self.height * ratio
        renderer:drawRect(self.x, self.y + self.height - progressHeight, 
                         self.width, progressHeight, progressColor)
    end
    
    -- 显示进度文本
    if self.showText then
        local percent = math.floor(ratio * 100)
        local text = tostring(percent) .. "%"
        renderer:drawText(text, self.x + self.width/2, self.y + self.height/2,
                         self.style.color, self.style.font, self.style.fontSize, "center", "center")
    end
end

-- 图像类
UIImage = UIComponent:new{
    imagePath = "",
    stretch = false,
    keepAspect = true
}

function UIImage:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function UIImage:render(renderer)
    if not self.visible then return end
    
    if self.imagePath and self.imagePath ~= "" then
        renderer:drawImage(self.imagePath, self.x, self.y, self.width, self.height, 
                          self.stretch, self.keepAspect)
    else
        -- 如果没有图片，绘制一个占位符
        renderer:drawRect(self.x, self.y, self.width, self.height, {r=100, g=100, b=100, a=255})
        renderer:drawBorder(self.x, self.y, self.width, self.height, self.style.borderColor, self.style.borderWidth)
        renderer:drawText("Image", self.x + self.width/2, self.y + self.height/2,
                         self.style.color, self.style.font, self.style.fontSize, "center", "center")
    end
end

-- UI管理器
UIManager = {
    root = nil,
    focusedComponent = nil,
    hoveredComponent = nil,
    components = {},
    renderer = nil
}

function UIManager:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    
    o.root = UIPanel:new{id = "root", x = 0, y = 0, width = 800, height = 600}
    
    return o
end

-- 设置渲染器
function UIManager:setRenderer(renderer)
    self.renderer = renderer
    return self
end

-- 添加组件
function UIManager:addComponent(component, parent)
    parent = parent or self.root
    parent:addChild(component)
    table.insert(self.components, component)
    return self
end

-- 移除组件
function UIManager:removeComponent(component)
    for i, comp in ipairs(self.components) do
        if comp == component then
            table.remove(self.components, i)
            if comp.parent then
                comp.parent:removeChild(comp)
            end
            break
        end
    end
    return self
end

-- 查找组件
function UIManager:findById(id)
    return self.root:findById(id)
end

-- 渲染所有组件
function UIManager:render()
    if not self.renderer then return end
    
    -- 清屏
    self.renderer:clear()
    
    -- 渲染根组件及其子组件
    self.root:render(self.renderer)
end

-- 更新所有组件
function UIManager:update(dt)
    self.root:update(dt)
end

-- 处理鼠标事件
function UIManager:handleMouseEvent(x, y, button, pressed)
    local handled = false
    
    -- 查找点击的组件
    local clickedComponent = self:findComponentAt(x, y)
    
    if clickedComponent then
        if pressed then
            -- 鼠标按下
            if clickedComponent.onMouseDown then
                clickedComponent:onMouseDown(x, y, button)
            end
            clickedComponent:triggerEvent("onMouseDown", x, y, button)
            
            -- 处理按钮按下
            if clickedComponent:is(UIButton) then
                clickedComponent.pressed = true
            end
            
            -- 处理文本框聚焦
            if clickedComponent:is(UITextBox) then
                if self.focusedComponent and self.focusedComponent ~= clickedComponent then
                    self.focusedComponent.selected = false
                    self.focusedComponent:triggerEvent("onBlur")
                end
                self.focusedComponent = clickedComponent
                clickedComponent.selected = true
                clickedComponent:triggerEvent("onFocus")
            end
        else
            -- 鼠标释放
            if clickedComponent.onMouseUp then
                clickedComponent:onMouseUp(x, y, button)
            end
            clickedComponent:triggerEvent("onMouseUp", x, y, button)
            
            -- 处理按钮点击
            if clickedComponent:is(UIButton) and clickedComponent.pressed then
                clickedComponent.pressed = false
                clickedComponent:triggerEvent("onClick")
            end
        end
        
        handled = true
    end
    
    return handled
end

-- 处理键盘事件
function UIManager:handleKeyEvent(key, pressed)
    if self.focusedComponent and self.focusedComponent:is(UITextBox) then
        if pressed then
            if key == "backspace" then
                local text = self.focusedComponent.text
                if #text > 0 and self.focusedComponent.cursorPos > 1 then
                    self.focusedComponent.text = string.sub(text, 1, self.focusedComponent.cursorPos-2) .. 
                                                string.sub(text, self.focusedComponent.cursorPos)
                    self.focusedComponent.cursorPos = math.max(1, self.focusedComponent.cursorPos - 1)
                    self.focusedComponent:triggerEvent("onTextChange", self.focusedComponent.text)
                end
            elseif key == "enter" then
                self.focusedComponent:triggerEvent("onEnter", self.focusedComponent.text)
            elseif key == "left" then
                self.focusedComponent.cursorPos = math.max(1, self.focusedComponent.cursorPos - 1)
            elseif key == "right" then
                self.focusedComponent.cursorPos = math.min(#self.focusedComponent.text + 1, 
                                                          self.focusedComponent.cursorPos + 1)
            else
                -- 处理普通字符输入
                if #key == 1 then
                    if #self.focusedComponent.text < self.focusedComponent.maxLength then
                        local text = self.focusedComponent.text
                        self.focusedComponent.text = string.sub(text, 1, self.focusedComponent.cursorPos-1) .. 
                                                    key .. string.sub(text, self.focusedComponent.cursorPos)
                        self.focusedComponent.cursorPos = self.focusedComponent.cursorPos + 1
                        self.focusedComponent:triggerEvent("onTextChange", self.focusedComponent.text)
                    end
                end
            end
        end
        return true
    end
    return false
end

-- 查找指定位置的组件
function UIManager:findComponentAt(x, y)
    local function search(component)
        -- 检查当前组件
        if component.visible and component.enabled then
            if x >= component.x and x <= component.x + component.width and
               y >= component.y and y <= component.y + component.height then
                
                -- 检查子组件
                for _, child in ipairs(component.children) do
                    local result = search(child)
                    if result then return result end
                end
                
                return component
            end
        end
        return nil
    end
    
    return search(self.root)
end

-- 类型检查辅助函数
function UIComponent:is(class)
    local mt = getmetatable(self)
    while mt do
        if mt == class then return true end
        mt = getmetatable(mt)
    end
    return false
end

-- 示例渲染器接口（需要根据实际环境实现）
DummyRenderer = {
    clear = function() end,
    drawRect = function(x, y, w, h, color) end,
    drawBorder = function(x, y, w, h, color, width) end,
    drawText = function(text, x, y, color, font, size, align, valign) end,
    drawLine = function(x1, y1, x2, y2, color) end,
    drawCircle = function(x, y, radius, color) end,
    drawCircleBorder = function(x, y, radius, color, width) end,
    drawTriangle = function(x1, y1, x2, y2, x3, y3, color) end,
    drawImage = function(path, x, y, w, h, stretch, keepAspect) end,
    measureText = function(text, font, size) return 0 end,
    pushClip = function(x, y, w, h) end,
    popClip = function() end
}

-- 使用示例
function createExampleUI()
    local uiManager = UIManager:new()
    local renderer = DummyRenderer -- 替换为实际的渲染器
    
    uiManager:setRenderer(renderer)
    
    -- 创建主面板
    local mainPanel = UIPanel:new{
        id = "mainPanel",
        x = 50, y = 50,
        width = 700, height = 500,
        style = {
            backgroundColor = {r=40, g=40, b=40, a=230}
        }
    }
    
    -- 创建标题
    local title = UILabel:new{
        id = "title",
        x = 20, y = 20,
        text = "UILua5.1 - 功能齐全的UI系统",
        style = {
            fontSize = 24,
            color = {r=255, g=200, b=50, a=255}
        }
    }
    
    -- 创建按钮
    local button1 = UIButton:new{
        id = "btnTest1",
        x = 30, y = 80,
        width = 150, height = 40,
        text = "点击我",
        style = {
            backgroundColor = {r=70, g=130, b=180, a=255}
        }
    }
    
    button1:addEventListener("onClick", function(btn)
        print("按钮被点击了: " .. btn.text)
    end)
    
    -- 创建文本框
    local textBox = UITextBox:new{
        id = "txtInput",
        x = 30, y = 140,
        width = 200, height = 35,
        placeholder = "请输入文本..."
    }
    
    textBox:addEventListener("onTextChange", function(tb, text)
        print("文本改变: " .. text)
    end)
    
    -- 创建复选框
    local checkBox = UICheckBox:new{
        id = "chkOption",
        x = 30, y = 190,
        text = "启用选项"
    }
    
    checkBox:addEventListener("onChange", function(cb)
        print("复选框状态: " .. tostring(cb.checked))
    end)
    
    -- 创建滑动条
    local slider = UISlider:new{
        id = "sldVolume",
        x = 30, y = 240,
        width = 200, height = 20,
        minValue = 0,
        maxValue = 100,
        value = 75
    }
    
    slider:addEventListener("onChange", function(sld)
        print("滑动条值: " .. sld.value)
    end)
    
    -- 创建下拉框
    local comboBox = UIComboBox:new{
        id = "cmbOptions",
        x = 30, y = 290,
        width = 150, height = 30,
        items = {"选项1", "选项2", "选项3", "选项4"}
    }
    
    comboBox:addEventListener("onChange", function(cmb)
        print("选择了: " .. cmb.items[cmb.selectedIndex])
    end)
    
    -- 创建进度条
    local progressBar = UIProgressBar:new{
        id = "pbProgress",
        x = 30, y = 340,
        width = 200, height = 20,
        value = 45
    }
    
    -- 组装UI
    mainPanel:addChild(title)
    mainPanel:addChild(button1)
    mainPanel:addChild(textBox)
    mainPanel:addChild(checkBox)
    mainPanel:addChild(slider)
    mainPanel:addChild(comboBox)
    mainPanel:addChild(progressBar)
    
    uiManager:addComponent(mainPanel)
    
    return uiManager
end

-- 导出模块
local M = {
    UISystem = UISystem,
    UIComponent = UIComponent,
    UIButton = UIButton,
    UILabel = UILabel,
    UITextBox = UITextBox,
    UIPanel = UIPanel,
    UICheckBox = UICheckBox,
    UIRadioButton = UIRadioButton,
    UISlider = UISlider,
    UIComboBox = UIComboBox,
    UIProgressBar = UIProgressBar,
    UIImage = UIImage,
    UIManager = UIManager,
    createExampleUI = createExampleUI
}

return M
