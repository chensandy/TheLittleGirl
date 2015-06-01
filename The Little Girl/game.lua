function game_load()
	
	mapNum = 2
	doorNum = 2
	itemNum = 6
	
	screendarkness = 1
	mainFont = love.graphics.newFont("Fonts/NotoSansCJKtc-Regular.otf", 40);
	love.graphics.setBackgroundColor(192, 192, 255)
	
	map = love.graphics.newImage("maps/map1.png");
	
	mainMap = 1;
	branchMap = 0;
	branchMap2 = 0;
	
	items_load()
	objects = {}
	door_load()
	objects.door = {}
	for i=1,doorNum do
		objects.door[i] = door:new(doorMap[i], doorId[i], doorLock[i], doorKey[i], doorGo[i], doorGoBranch[i])
	end
	--music:stop()
	--musicrev:play()
end

function game_update(dt)
	if screendarkness > 0 then
		screendarkness = math.max(0, screendarkness - dt/2)
	end
	
end

function game_draw()
	
	
	love.graphics.draw(map, 0, 0)
	
	
	love.graphics.setColor(0, 0, 0)
	love.graphics.setFont(mainFont);
	love.graphics.print("Map"..mainMap.." "..branchMap.." "..branchMap2, 180, 150)
	
	love.graphics.setColor(0, 0, 0, 255*screendarkness)
	love.graphics.rectangle("fill", 0, 0, 800, 600)
	love.graphics.setColor(255, 255, 255)
	
	items_draw()
end

function game_mousepressed(x, y, button)
	items_mousepressed(x, y, button)
end
function game_keypressed(key)
	if key == 'a' then
		branchMap = -1
		map = love.graphics.newImage("maps/map" .. mainMap .. branchMap .. ".png");
	elseif key == 'z' then
		branchMap = 0
		map = love.graphics.newImage("maps/map" .. mainMap .. ".png");
	elseif key == 'd' then
		if objects.door[-1*branchMap]:islock() then
		else
			mainMap = objects.door[-1*branchMap]:go()
			map = love.graphics.newImage("maps/map" .. mainMap .. ".png");
		end
	else
		items_keypressed(key)
	end
end