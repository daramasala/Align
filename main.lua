local Align = require "align"

local function newButton(x, y, width, height)
    local b = display.newRect(x, y, width, height)
    b:setFillColor(0, 0, 0)
    b:setStrokeColor(1, 1, 1)
    b.strokeWidth = 4
    return b
end

-- create a reference with padding
local mainRef = Align.newReference(display.currentStage, {padding=20})

local dialog = Align.newContainer(display.currentStage, {width=mainRef.insideWidth, height=mainRef.insideHeight/2, bg="bg.jpg", padding=10})
Align.center(mainRef, dialog)

local btn1 = newButton(0, 0, 60, 40)
local btn2 = newButton(0, 0, 80, 40)

Align.insideRight(dialog, btn1)
Align.onLeft(btn1, 10, btn2)
Align.insideBottom(dialog, btn1, btn2)

local icon = display.newImage(dialog, "image.png")
icon.width = 64
icon.height = 64
dialog.ref = Align.newReference(dialog)
Align.insideRight(dialog.ref, icon)
Align.insideTop(dialog.ref, icon)

local caption = display.newText({parent=dialog, text="Corona SDK", font=native.systemFont, fontSize=10})
Align.center(icon, caption)
Align.onBottom(icon, 0, caption)

local line1 = display.newText({parent=dialog, text="* Aligning to left, right, bottom, top", font=native.systemFont, fontSize=10})
local line2 = display.newText({parent=dialog, text="* Padding inside containers", font=native.systemFont, fontSize=10})
local line3 = display.newText({parent=dialog, text="* Space horizontally and vertically", font=native.systemFont, fontSize=10})
Align.insideLeft(dialog.ref, line1, line2, line3)
Align.spaceVertically(dialog.ref.y+dialog.ref.padding, dialog.ref.y + 100, line1, line2, line3)

