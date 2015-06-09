function menu_load()
	
	screendarkness = 1
	mainFont = love.graphics.newFont("Fonts/NotoSansCJKtc-Regular.otf", 40);
	love.graphics.setBackgroundColor(192, 192, 255)
	menuitems = {"開始遊戲", "讀取進度", "結束遊戲"}
	m_menuSelect = 0
	noise = 0
	
	--music:stop()
	--musicrev:play()
end

function menu_update(dt)
	if screendarkness > 0 then
		screendarkness = math.max(0, screendarkness - dt/2)
	end

end

function menu_draw()
	--MAIN MENU
	for i = 1, #menuitems do
		local x = love.mouse.getX( )
		local y = love.mouse.getY( )
		if x > 180 and x < 350 and y > 150+55*i and y < 150+55*(i+1) - 10 then
			love.graphics.setColor(255, 0, 0)
		else
			love.graphics.setColor(255, 255, 255)
		end
		
		love.graphics.setFont(mainFont);
		love.graphics.print(menuitems[i], 180, 150+55*i)
	end
		
	
	love.graphics.setColor(0, 0, 0, 255*screendarkness)
	love.graphics.rectangle("fill", 0, 0, 800, 600)
	love.graphics.setColor(255, 255, 255)
end

function menu_mousepressed(x, y, button)
	if button=='l' then
		for i = 1, #menuitems do
			if x > 180 and x < 350 and y > 150+55*i and y < 150+55*(i+1) - 10 then
				if i == 1 then
					changegamestate("game")
				end
				break
			end
		end
	end
end

function menu_keypressed(key)
	
end