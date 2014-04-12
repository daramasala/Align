local Align = {padding=20}

--- Align the top of the display objects in the list of arguments to the top of the reference
--     #          
--                 
-- #      -->  # # #
-- # #         # #
-- # #         #
function Align.top(reference, ...)
	local count = #arg
	local top = reference.y - reference.height * reference.anchorY

	for i=1, count do
		o = arg[i]
		o.y = top + o.height * o.anchorY
	end
end

--- Used to align the top of a component inside of the reference component. 
-- Same as Align.top but takes into account the reference's padding.
function Align.insideTop(reference, ...)
	local count = #arg
	local top = reference.y - reference.height * reference.anchorY + (reference.padding or 0)

	for i=1, count do
		o = arg[i]
		o.y = top + o.height * o.anchorY
	end
end

--- Align the bottom of the display objects in the list of arguments to the bottom of the reference
--     #          
--                 
-- #      -->  #  
-- # #         # #
-- # #         # # #
function Align.bottom(reference, ...)
	local count = #arg
	local bottom = reference.y + reference.height * (1-reference.anchorY)

	for i=1, count do
		o = arg[i]
		o.y = bottom - o.height * (1-o.anchorY)
	end
end

--- Align the bottom of the components to the inner bottom of the reference. Same like Align.bottom but takes into account padding.
function Align.insideBottom(reference, ...)
	local count = #arg
	local bottom = reference.y + reference.height * (1-reference.anchorY) - (reference.padding or 0)

	for i=1, count do
		o = arg[i]
		o.y = bottom - o.height * (1-o.anchorY)
	end
end

--- Align the left side of the display objects in the list of arguments to the left side of the reference
--   ####       ####
-- 
--     ##  -->  ##
-- 
-- #            #
function Align.left(reference, ...)
	local count = #arg
	local left = reference.x - reference.width * reference.anchorX

	for i=1, count do
		local o = arg[i]
		o.x = left + o.width * o.anchorX
	end
end

--- Align the left of components to the inner left of the referenece. Same as Align.left but takes into account padding
function Align.insideLeft(reference, ...)
	local count = #arg
	local left = reference.x - reference.width * reference.anchorX + (reference.padding or 0)

	for i=1, count do
		local o = arg[i]
		o.x = left + o.width * o.anchorX
	end
end


--- Align the right side of the display objects in the list of arguments to the right side of the reference
--   ####        ####
-- 
--      ##  -->    ##
-- 
-- #                #
function Align.right(reference, ...)
	local count = #arg
	local left = reference.x + reference.width * (1-reference.anchorX)

	for i=1, count do
		o = arg[i]
		o.x = left - o.width * (1-o.anchorX)
	end
end

function Align.insideRight(reference, ...)
	local count = #arg
	local left = reference.x + reference.width * (1-reference.anchorX) - (reference.padding or 0)

	for i=1, count do
		o = arg[i]
		o.x = left - o.width * (1-o.anchorX)
	end
end

--- Align the horizontal center of the display objects in the list of arguments to the horizontal center of the reference
--   #######            #######
--
-- ###          -->       ###
--
--       #####           #####
function Align.centerHorizontally(reference, ...)
	local x = reference.x + reference.width * (0.5 - reference.anchorX)
	local count = #arg
	for i=1, count do
		local o = arg[i]
		o.x = x + o.width * (o.anchorX - 0.5)
	end	
end

--- Align the vertical center of the display objects in the list of arguments to the vertical center of the reference
function Align.centerVertically(reference, ...)
	local y = reference.y + reference.height * (0.5-reference.anchorY)
	local count = #arg
	for i=1, count do
		local o = arg[i]
		o.y = y + o.height * (o.anchorY - 0.5)
	end	
end

--- Align the center of the display objects in the list of arguments to the center of the reference
function Align.center(reference, ...)
	Align.centerHorizontally(reference, ...)
	Align.centerVertically(reference, ...)
end

--- Space objects evenly between y1 and y2
-- Option 1: y1, y2, ...
-- Option 2: reference, ...
-- On option 2, y1 and y2 are the top and bottom of the reference
function Align.spaceVertically(y1, ...)
	local y2
	local startI = 1
	if (type(y1)=="table") then
		local ref = y1
        local padding = ref.padding or 0
		y1, y2 = ref.contentBounds.yMin + padding, ref.contentBounds.yMax - padding
        
	else
		y2 = arg[1]
		startI = 2
	end
	local count = #arg
	local contentHeight = 0
	for i=startI,count do
		contentHeight = contentHeight + arg[i].height
	end
	local height = (y2 - y1 +1)
	local padding = (height - contentHeight) / (count-1)
	local y = y1
	for i=startI, count do
		local o = arg[i]
		local h = o.height
		o.y = y + (h*o.anchorY)
		y = y + o.height + padding
	end
end

--- Space objects evenly between x1 and x2
-- Option 1: x1, x2, ...
-- Option 2: reference, ...
-- On option 2, x1 and x2 are the left and right of the reference
function Align.spaceHorizontally(x1, ...)
	local x2
	local startI = 1
	if (type(x1)=="table") then
		local ref = x1
        local padding = ref.padding or 0
		x1, x2 = ref.contentBounds.xMin + padding, ref.contentBounds.xMax - padding
        
	else
		x2 = arg[1]
		startI = 2
	end
	local count = #arg
	local contentWidth = 0
	for i=startI,count do
		contentWidth = contentWidth + arg[i].width
	end
	local width = (x2 - x1 +1)
	local padding = (width - contentWidth) / (count-1)
	local x = x1
	for i=startI, count do
		local o = arg[i]
		local w = o.width
		o.x = x + (w*o.anchorX)
		x = x + o.width + padding
	end
end

--- Position the objects in the arg list to the left of the reference with padding space between them
function Align.onLeft(reference, padding, ...)
	local count = #arg
	local left = reference.x - reference.width*reference.anchorX - padding
	for i=1,count do
		local o = arg[i]
		o.x = left - o.width*(1-o.anchorX)
	end
end

--- Position the objects in the arg list to the right of the reference with padding space between them
function Align.onRight(reference, padding, ...)
	local count = #arg
	local right = reference.x + reference.width*(1-reference.anchorX) + padding
	for i=1,count do
		local o = arg[i]
		o.x = right + o.width*o.anchorX
	end
end

--- Position the objects in the arg list to the bottom of the reference with padding space between them
function Align.onBottom(reference, padding, ...)
	local count = #arg
	local bottom = reference.y + reference.height*(1-reference.anchorY) + padding
	for i=1,count do
		local o = arg[i]
		o.y = bottom + o.height*o.anchorY
	end
end

--- Position the objects in the arg list to the top of the reference with padding space between them
function Align.onTop(reference, padding, ...)
	local count = #arg
	local top = reference.y + reference.height*(-reference.anchorY) + padding
	for i=1,count do
		local o = arg[i]
		o.y = top + o.height*(o.anchorY-1)
	end
end

--- Create a reference. Can be used to align components inside a Corona container. 
--- container - By default the reference inherits the width and height of the container. 
--- options (optional):
---   x, y: set reference x and y
---   width: width of the reference
---   height: height of the reference
---   padding: the container is padded so everything gets aligned to the inner frame
 function Align.newReference(container, options)
 	options = options or {}
	local padding, width, height = options.padding or container.padding or 0, options.width or container.width or Align.width, options.height or container.height or Align.height
	-- argCount = #arg
	-- if argCount == 1 then
	-- 	padding = arg[1]
	-- else
	-- 	width = arg[1] or width
	-- 	height = arg[2] or height
	-- 	padding = arg[3] or padding
	-- end
	local x = options.x or 0
	local y = options.y or 0
	if container and container.type=="reference" then
		x = x + container.x
		y = y + container.y
	end
	x = x
	y = y
	width = width
	height = height
	return {
		anchorX = 0,
		anchorY = 0,
		x = x,
		y = y,
		width = width,
		height = height,
        padding=padding,
        insideHeight=height-padding*2,
        insideWidth=width-padding*2,
		contentBounds = {xMin = x, xMax = x+width, yMin=y, yMax=y+height},
		type="reference"
	}
end

--- Adds padding properties to Corona display objects so they can be used as reference for Align.insideXXX() calls
function Align.setPadding(container, padding)
    container.padding = padding
    container.insideHeight = container.height - 2*padding
    container.insideWidth = container.width - 2*padding
end

--- Creates a new container with background image. 
-- options={x, y, width, height, padding, bg}
function Align.newContainer(parent, options)
	local width = options.width or parent.width
	local height = options.height or parent.height
	local padding = options.padding or 0
    local c = display.newContainer( parent, width, height )
	c.anchorChildren = false
	c.anchorY = 0
	c.anchorX = 0
	c.x = options.x or parent.x
	c.y = options.y or parent.y
	if options.bg then
		local bg = options.bg
        local bgImage = display.newImage(bg)
        c:insert(bgImage)
        bgImage.anchorX = 0
        bgImage.anchorY = 0
        bgImage.width = width
        bgImage.height = height
	end
    Align.setPadding(c, padding)
	return c
end

Align.centerX = display.contentCenterX
Align.centerY = display.contentCenterY
Align.width = display.contentWidth
Align.height = display.contentHeight

return Align