function items_load()
	screendarkness = 1
	m_items = {}
	m_selectItems = 0;
	m_oldSelectItems = 0;
	m_itemBags = love.graphics.newImage("graphics/bags.png")
	m_itemGrid = love.graphics.newImage("graphics/grid.png")
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
		if m_selectItems == 0 then
			local i_beam_cursor = love.mouse.getSystemCursor("arrow")
			love.mouse.setCursor(i_beam_cursor)
		else
			local cursor = love.mouse.newCursor( m_items[m_selectItems], 0, 0 )
			love.mouse.setCursor( cursor )
		end
		m_oldSelectItems = m_selectItems
	end
end

function items_mousepressed(x, y, button)
	if button=='l' then
		for i = 1, #m_items do
			if x > 20 + (i-1)*(80) and x < 20 + (i-1)*(80) + 70 
				and y > 20 and y < 20 + 70 then
				if m_selectItems == i then
					m_selectItems = 0
				else
					m_selectItems = i
				end
			end
		end
	end
end

function items_add(item)
	if love.filesystem.exists( item ) then
		m_items[#m_items + 1] = item
	end
end

function items_delete(item)
	if love.filesystem.exists( item ) then
		for i = 1, #m_items do
			if m_items[i] == item then
				for j = i + 1, #m_items do
					m_items[j - 1] = m_items[j]
				end
				if m_selectItems == i then
					m_selectItems = 0
				elseif m_selectItems > i then
					m_selectItems = m_selectItems - 1
				end
				m_items[#m_items] = NULL
			end
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
