function items_load()
	screendarkness = 1
	m_itemsMaxNumber = 16
	m_itemsPage = 1
	
	m_items = {}
	m_itemsGraphics = {}
	m_itemsCursor = {}
	
	m_selectItems = 0;
	m_oldSelectItems = 0;
	m_itemBags = love.graphics.newImage("graphics/bags.png")
	m_itemGrid = love.graphics.newImage("graphics/grid.png")
	m_combination = {}
	initialCombination()
	mouseImage = love.image.newImageData( "Items/mouse.png" )
	mouseCursor = love.mouse.newCursor( mouseImage, 0, 0 )
	love.mouse.setCursor( mouseCursor )
	--[[for test
	items_add("Items/4-1-1-1.png")
	items_add("Items/5-3-1.png")
	items_add("Items/6-2-1.png")
	items_add("Items/11-3-3.png")
	--items_add("Items/7-1-2-1.png")
	--items_add("Items/10-2-2-1.png")
	--]]
end

function items_update(dt)
	if screendarkness > 0 then
		screendarkness = math.max(0, screendarkness - dt)
	end
end

function items_draw()		
	love.graphics.draw(m_itemBags, 10, 10)
	for i = 1, m_itemsMaxNumber/2 do		
		love.graphics.draw(m_itemGrid, 20 + (i-1)*(80), 20)
	end
	local j = 1
	local tempEnd = 0
	if m_itemsPage == 1 then
		if #m_items >= 8 then
			tempEnd = 8
		else
			tempEnd = #m_items
		end
		itemsPageMsg = "下頁"
	else
		tempEnd = #m_items
		itemsPageMsg = "上頁"
	end
	love.graphics.print(itemsPageMsg, 655, 40)
	itemsPageMsg = nil
	for i = (m_itemsPage-1)*8+1, tempEnd do		
		love.graphics.draw(m_itemsGraphics[i], 20 + (j-1)*(80), 20)
		if i == m_selectItems then
			local r, g, b, a = love.graphics.getColor( )
			love.graphics.setColor( 255, 0, 0)
			
			love.graphics.line(20 + (j-1)*(80), 20, 20 + (j-1)*(80) + 70, 20)
			love.graphics.line(20 + (j-1)*(80) + 70, 20, 20 + (j-1)*(80) + 70, 20 + 70)
			love.graphics.line(20 + (j-1)*(80) + 70, 20 + 70, 20 + (j-1)*(80), 20 + 70)
			love.graphics.line(20 + (j-1)*(80), 20 + 70, 20 + (j-1)*(80), 20)

			love.graphics.setColor(r, g, b, a)
		end
		itemGraphics = nil
		j = j + 1
	end
	
	if m_oldSelectItems ~= m_selectItems then
		if m_selectItems == 0 then
			love.mouse.setCursor( mouseCursor )
		else
			love.mouse.setCursor( m_itemsCursor[m_selectItems] )
		end
		m_oldSelectItems = m_selectItems
	end
end

function items_mousepressed(x, y, button)
	if button=='l' then
		local j = 1
		local tempEnd = 0
		if m_itemsPage == 1 then
			if #m_items >= 8 then
				tempEnd = 8
			else
				tempEnd = #m_items
			end
		else
			tempEnd = #m_items
		end
	
		for i = (m_itemsPage-1)*8+1, tempEnd do
			if x > 20 + (j-1)*(80) and x < 20 + (j-1)*(80) + 70 and y > 20 and y < 20 + 70 then
				if m_selectItems == i then
					m_selectItems = 0
				elseif m_selectItems == 0 or items_combination(m_items[m_selectItems], m_items[i]) == false then
					m_selectItems = i
				end
				return true
			end
			j = j + 1
		end
		
		if x > 20 + (9-1)*(80) and x < 20 + (9-1)*(80) + 70 and y > 20 and y < 20 + 70 then
			if m_itemsPage == 1 then
				m_itemsPage = 2
			else
				m_itemsPage = 1
			end
			return true
		end
	end
	
	if button=='r' then
		m_selectItems = 0
	end
	if x > 10 and x < m_itemBags:getWidth() and y > 10 and y < m_itemBags:getHeight() then
		return true
	end
	return false
end

function items_add(someItem)
	if love.filesystem.exists( someItem ) and #m_items < m_itemsMaxNumber then
		m_items[#m_items + 1] = someItem
		
		local itemsGraphics = love.graphics.newImage( someItem )		
		m_itemsGraphics[#m_itemsGraphics + 1] = itemsGraphics
		itemsGraphics = nil
		
		local itemsImageData = love.image.newImageData( someItem )
		itemsImageData:paste(mouseImage, 0, 0, 0, 0)
		local itemCursor = love.mouse.newCursor( itemsImageData, 0, 0 )
		m_itemsCursor[#m_itemsCursor + 1] = itemCursor
		itemsImageData = nil
		itemCursor = nil
	end
end

function items_delete(someItem)
	for i = 1, #m_items do
		if m_items[i] == someItem then
			for j = i + 1, #m_items do
				m_items[j - 1] = m_items[j]
				m_itemsGraphics[j - 1] = m_itemsGraphics[j]
				m_itemsCursor[j - 1] = m_itemsCursor[j]
			end
			if m_selectItems == i then
				m_selectItems = 0
			elseif m_selectItems > i then
				m_selectItems = m_selectItems - 1
			end
			m_items[#m_items] = nil
			m_itemsGraphics[#m_itemsGraphics] = nil
			m_itemsCursor[#m_itemsCursor] = nil
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
	deleteItem = nil
end

function initialCombination()
	m_combination[1] = {item1="Items/7-2-3-1.png", item2="Items/11-1-1-1.png", itemResult="Items/7-2-3-1-1.png"}
	m_combination[2] = {item1="Items/7-2-3-1-1.png", item2="Items/8-1-2-1.png", itemResult="Items/7-2-3-1-1-1.png"}
	m_combination[3] = {item1="Items/11-3-1.png", item2="Items/11-3-2.png", itemResult="Items/11-3-1-1.png"}
end

function items_combination(oldItem, newItem)
	for i = 1, #m_combination do
		if m_combination[i].item1 == oldItem and m_combination[i].item2 == newItem 
			or m_combination[i].item1 == newItem and m_combination[i].item2 == oldItem then
			items_delete(oldItem)
			items_delete(newItem)
			items_add(m_combination[i].itemResult)
			m_selectItems = 0
			
			if i == 3 then
				local tempItemsMusic = love.audio.newSource("sounds/makeFire.mp3");tempItemsMusic:setVolume(1);tempItemsMusic:setLooping(false)
				tempItemsMusic:play()
				tempItemsMusic = nil
			end
			
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

function findItems(findItem)
	for i = 1, #m_items do
		if m_items[i] == findItem then
			return true
		end
	end
	return false
end