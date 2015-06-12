function items_load()
	screendarkness = 1
	m_items = {"Items/5-1.png"}
	--m_items = {}
	m_selectItems = 0;
	m_oldSelectItems = 0;
	m_itemBags = love.graphics.newImage("graphics/bags.png")
	m_itemGrid = love.graphics.newImage("graphics/grid.png")
	m_combination = {}
	initialCombination()
	local imageData = love.image.newImageData( "Items/mouse.png" )
	local cursor = love.mouse.newCursor( imageData, 0, 0 )
	love.mouse.setCursor( cursor )
end

function items_update(dt)
	if screendarkness > 0 then
		screendarkness = math.max(0, screendarkness - dt)
	end
end

function items_draw()		
	love.graphics.draw(m_itemBags, 10, 10)	
	for i = 1, 9 do		
		love.graphics.draw(m_itemGrid, 20 + (i-1)*(80), 20)
	end
	
	for i = 1, #m_items do
		local itemGraphics = love.graphics.newImage(m_items[i])		
		love.graphics.draw(itemGraphics, 20 + (i-1)*(80), 20)
		if i == m_selectItems then
			local r, g, b, a = love.graphics.getColor( )
			love.graphics.setColor( 255, 0, 0)
			
			love.graphics.line(20 + (i-1)*(80), 20, 20 + (i-1)*(80) + 70, 20)
			love.graphics.line(20 + (i-1)*(80) + 70, 20, 20 + (i-1)*(80) + 70, 20 + 70)
			love.graphics.line(20 + (i-1)*(80) + 70, 20 + 70, 20 + (i-1)*(80), 20 + 70)
			love.graphics.line(20 + (i-1)*(80), 20 + 70, 20 + (i-1)*(80), 20)

			love.graphics.setColor(r, g, b, a)
		end
	end
	
	if m_oldSelectItems ~= m_selectItems then
		local mouseImage = love.image.newImageData( "Items/mouse.png" )
		if m_selectItems == 0 then
			local cursor = love.mouse.newCursor( mouseImage, 0, 0 )
			love.mouse.setCursor( cursor )
		else
			local imageData = love.image.newImageData( m_items[m_selectItems] )
			imageData:paste(mouseImage, 0, 0, 0, 0)
			local cursor = love.mouse.newCursor( imageData, 0, 0 )
			love.mouse.setCursor( cursor )
		end
		m_oldSelectItems = m_selectItems
	end
end

function items_mousepressed(x, y, button)
	if button=='l' then
		for i = 1, #m_items do
			if x > 20 + (i-1)*(80) and x < 20 + (i-1)*(80) + 70 and y > 20 and y < 20 + 70 then
				if m_selectItems == i then
					m_selectItems = 0
				elseif m_selectItems == 0 or items_combination(m_items[m_selectItems], m_items[i]) == false then
					m_selectItems = i
				end
				return true
			end
		end
	end
	if x > 10 and x < m_itemBags:getWidth() and y > 10 and y < m_itemBags:getHeight() then
		return true
	end
	return false
end

function items_add(someItem)
	if love.filesystem.exists( someItem ) and #m_items < 9 then
		m_items[#m_items + 1] = someItem
	end
end

function items_delete(someItem)
	for i = 1, #m_items do
		if m_items[i] == someItem then
			for j = i + 1, #m_items do
				m_items[j - 1] = m_items[j]
			end
			if m_selectItems == i then
				m_selectItems = 0
			elseif m_selectItems > i then
				m_selectItems = m_selectItems - 1
			end
			m_items[#m_items] = NULL
			break
		end
	end	
end

function items_keypressed(key)
	local deleteItem = false
    for i = 1, #m_items do
		if m_items[i] == "Items/" .. key  .. ".gif" then
			items_delete("Items/" .. key  .. ".gif")
			deleteItem = true
			break
		end
	end
	if deleteItem == false then
		items_add("Items/" .. key  .. ".gif")
	end
end

function initialCombination()
	m_combination[1] = {item1="Items/1.gif", item2="Items/2.gif", itemResult="Items/3.gif"}
	m_combination[2] = {item1="Items/1.gif", item2="Items/3.gif", itemResult="Items/4.gif"}
	m_combination[3] = {item1="Items/1.gif", item2="Items/4.gif", itemResult="Items/5.gif"}
	m_combination[4] = {item1="Items/1.gif", item2="Items/5.gif", itemResult="Items/6.gif"}
end

function items_combination(oldItem, newItem)
	for i = 1, #m_combination do
		if m_combination[i].item1 == oldItem and m_combination[i].item2 == newItem 
			or m_combination[i].item1 == newItem and m_combination[i].item2 == oldItem then
			items_delete(oldItem)
			items_delete(newItem)
			items_add(m_combination[i].itemResult)
			m_selectItems = 0
			return true
		end
	end
	return false
end

function getSelectItems()
	if m_selectItems ~=0 then
		return m_items[m_selectItems]
	else
		return -9999
	end
end