function game_load()
	
	mapNum = 2
	doorNum = 3
	itemNum = 6
	
	screendarkness = 1
	mainFont = love.graphics.newFont("Fonts/NotoSansCJKtc-Regular.otf", 40);
	love.graphics.setBackgroundColor(192, 192, 255)
	
	map = love.graphics.newImage("maps/map1.png");
	mask = love.image.newImageData("maps/map1_mask.png");
	mainMap = {1, 0, 0};
	
	items_load()
	objects = {}
	door_load()
	objects.door = {}
	for i=1,doorNum do
		objects.door[i] = door:new(doorMap[i], doorId[i], doorLock[i], doorKey[i], doorGo[i], doorGoBranch[i])
	end
	--music:stop()
	--musicrev:play()
	
	--for debug
	clickMessage = ""
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
	
	--for debug
	love.graphics.print("Map"..mainMap[1].." "..mainMap[2].." "..mainMap[3], 180, 150)
	love.graphics.print(clickMessage, 180, 180)
	--for debug
	
	love.graphics.setColor(0, 0, 0, 255*screendarkness)
	love.graphics.rectangle("fill", 0, 0, 800, 600)
	love.graphics.setColor(255, 255, 255)
	
	items_draw()
end

function game_mousepressed(x, y, button)
	if button=='l' then
		local r, g, b, a = mask:getPixel(x, y)
		--door 0 0
		if r==0 and g==0 then 
			clickMessage = "door:".. b/50 .. " " .. x .. " ".. y
			--clickDoor(b/50)
		end
	else
		clickMessage=""
	end
	items_mousepressed(x, y, button)
end
function game_keypressed(key)
	if key == 'a' then
		moveMap(mainMap[1], 1, 0)
	elseif key == 'z' then
		moveMap(mainMap[1], 0, 0)
	elseif key == 'd' then
		if objects.door[-1*mainMap[2]]:islock() then
		else
			tmp = objects.door[-1*mainMap[2]]:go()
			moveMap(tmp[1], tmp[2], tmp[3])
		end
	else
		items_keypressed(key)
	end
end

function moveMap(id1, id2, id3)
	mainMap[1] = id1
	mainMap[2] = -1*id2
	mainMap[3] = -1*id3
	if id3 ~= 0 then
		map = love.graphics.newImage("maps/map" .. mainMap[1] .. mainMap[2] .. mainMap[3] ..".png");
		mask = love.image.newImageData("maps/map" .. mainMap[1] .. mainMap[2] .. mainMap[3] .."_mask.png");
	elseif id2~=0 then
		map = love.graphics.newImage("maps/map" .. mainMap[1] .. mainMap[2] .. ".png");
		mask = love.image.newImageData("maps/map" .. mainMap[1] .. mainMap[2] .. "_mask.png");
	else
		map = love.graphics.newImage("maps/map" .. mainMap[1] .. ".png");
		mask = love.image.newImageData("maps/map" .. mainMap[1] .. "_mask.png");
	end
	screendarkness = 1
end