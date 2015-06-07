function game_load()
	
	--mapNum = 2
	doorNum = 14
	branchNum = 29
	itemNum = 3
	r_bottonNum = 39
	
	screendarkness = 1
	mainFont = love.graphics.newFont("Fonts/NotoSansCJKtc-Regular.otf", 40);
	love.graphics.setBackgroundColor(192, 192, 255)
	
	map = love.graphics.newImage("maps/map1.png");
	mask = love.image.newImageData("maps/map1_mask.png");
	mainMap = {1, 0, 0};
	
	items_load()
	talk_load()
	objects = {}
	door_load()
	branch_load()
	r_botton_load()
	objects.door = {}
	objects.r_botton = {}
	objects.branch = {}
	for i=1,doorNum do
		objects.door[i] = door:new(doorMap[i], doorId[i], doorLock[i], doorKey[i], doorGo[i], doorGoBranch[i])
	end
	for i=1,r_bottonNum do
		objects.r_botton[i] = r_botton:new(rMap[i], rId[i], rGo[i], rGoBranch[i], rGoBranch2[i])
	end
	for i=1,branchNum do
		objects.branch[i] = branch:new(branchMap[i], branchId[i], branchGoBranch1[i], branchGoBranch2[i])
	end
	--music:stop()
	--musicrev:play()
	
	--for debug
	clickMessage = ""
end

function game_update(dt)
	if screendarkness > 0 then
		screendarkness = math.max(0, screendarkness - dt)
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
	talk_draw()
end

function game_mousepressed(x, y, button)
	if button=='l' then
		local r, g, b, a = mask:getPixel(x, y)
		--door 0 0
		if r==0 and g==0 then 
			clickMessage = "door:".. b/25 .. " " .. x .. " ".. y
			clickDoor(b/25)
		--branch 255 0
		elseif r==255 and g==0 then 
			clickMessage = "branch:".. b/25 .. " " .. x .. " ".. y
			clickBranch(b/25)
		elseif r==128 and g==128 then 
			clickMessage = "return:".. b/25 .. " " .. x .. " ".. y
			clickRbotton(b/25)
		end
	else
		clickMessage=""
	end
	items_mousepressed(x, y, button)
	talk_mousepressed(x, y, button)
end

function game_keypressed(key)
	if key == 'a' then
		moveMap(mainMap[1], 1, 0)
	elseif key == 'b' then
		moveMap(1, 0, 0)
	elseif key == 'z' then
		moveMap(mainMap[1], 0, 0)
	elseif key == 's' then
		moveMap(mainMap[1], 2, 0)
	elseif key == 'd' then
		if objects.door[-1*mainMap[2]]:islock() then
		else
			tmp = objects.door[-1*mainMap[2]]:go()
			moveMap(tmp[1], tmp[2], tmp[3])
		end
	else
		items_keypressed(key)
		talk_keypressed(key)
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
	screendarkness = 0.5
end

function clickDoor(id)
	d = 0
	for i=1,doorNum do
		if objects.door[i].map == mainMap[1] and objects.door[i].index == id then
			d = i
		end
	end
	if d ~=0 then
		if objects.door[d]:islock() then
			-- print lock message
			-- playsound
		else
			local tmp = objects.door[d]:go()
			-- playsound
			moveMap(tmp[1], tmp[2], tmp[3])
		end
	end
end

function clickBranch(id)
	d = 0
	for i=1,branchNum do
		if objects.branch[i].map == mainMap[1] and objects.branch[i].index == id then
			d = i
		end
	end
	if d ~=0 then
		local tmp = objects.branch[d]:go()
		-- playsound
		moveMap(tmp[1], tmp[2], tmp[3])
	end
end

function clickRbotton(id)
	d = 0
	for i=1,r_bottonNum do
		if objects.r_botton[i].map == mainMap[1] and objects.r_botton[i].index == id then
			d = i
		end
	end
	if d ~=0 then
		local tmp = objects.r_botton[d]:go()
		-- playsound
		moveMap(tmp[1], tmp[2], tmp[3])
	end
end