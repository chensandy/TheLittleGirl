function items_load()
	screendarkness = 1
	--items = {"Items/1.gif", "Items/2.gif", "Items/3.gif"}
	items = {}
	selectItems = 0;
	firstX = 10
	firstY = 10
end

function items_update(dt)
	if screendarkness > 0 then
		screendarkness = math.max(0, screendarkness - dt/2)
	end
end

function items_draw()
	for i = 1, #items do
		itemGraphics = love.graphics.newImage(items[i])
		love.graphics.draw(itemGraphics, firstX + (i-1)*(80), firstY)
		if i == selectItems then
			r, g, b, a = love.graphics.getColor( )
			love.graphics.setColor( 255, 0, 0)
			
			love.graphics.line(firstX + (i-1)*(80), firstY, firstX + (i-1)*(80) + 70, firstY)
			love.graphics.line(firstX + (i-1)*(80) + 70, firstY, firstX + (i-1)*(80) + 70, firstY + 70)
			love.graphics.line(firstX + (i-1)*(80) + 70, firstY + 70, firstX + (i-1)*(80), firstY + 70)
			love.graphics.line(firstX + (i-1)*(80), firstY + 70, firstX + (i-1)*(80), firstY)

			love.graphics.setColor(r, g, b, a)
		end
	end
end

function items_mousepressed(x, y, button)
	for i = 1, 9 do
		if love.mouse.getX( ) > firstX + (i-1)*(80) and love.mouse.getX( ) < firstX + (i-1)*(80) + 70 
			and love.mouse.getY( ) > firstY and love.mouse.getY( ) < firstY + 70 then
			if selectItems == i then
				selectItems = 0
			else
				selectItems = i
			end
		end
	end
end

function items_add(item)
	items[#items + 1] = item
end

function items_delete(item)
	for i = 1, #items do
		if items[i] == item then
			for j = i + 1, #items do
				items[j - 1] = items[j]
			end
			if selectItems == i then
				selectItems = 0
			elseif selectItems > i then
				selectItems = selectItems - 1
			end
			items[#items] = NULL
		end
	end
end

function items_keypressed(key)
	deleteItem = false
    for i = 1, #items do
		if items[i] == "Items/" .. key  .. ".gif" then
			items_delete("Items/" .. key  .. ".gif")
			deleteItem = true
			break
		end
	end
	if deleteItem == false then
		items_add("Items/" .. key  .. ".gif")
	end
end
