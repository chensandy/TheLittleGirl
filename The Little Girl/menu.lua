function menu_load()
	
	screendarkness = 1
	mainFont = love.graphics.newFont("Fonts/NotoSansCJKtc-Regular.otf", 40);
	love.graphics.setBackgroundColor(192, 192, 255)
	menuitems = {"開始遊戲", "讀取進度", "結束遊戲"}
	
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
		love.graphics.setColor(255, 255, 255)
		love.graphics.setFont(mainFont);
		love.graphics.print(menuitems[i], 180, 150+55*i)
	end
		
	
	love.graphics.setColor(0, 0, 0, 255*screendarkness)
	love.graphics.rectangle("fill", 0, 0, 800, 600)
	love.graphics.setColor(255, 255, 255)
end

function menu_keypressed(key)
	
end