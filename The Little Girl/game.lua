function game_load()
	screendarkness = 1
	mainFont = love.graphics.newFont("Fonts/NotoSansCJKtc-Regular.otf", 40);
	love.graphics.setBackgroundColor(192, 192, 255)
	
	map = love.graphics.newImage("maps/map1.png");
	horn = love.graphics.newImage("graphics/horn.png");
	mask = love.image.newImageData("maps/map1_mask.png");
	mainMap = {1, 0, 0};
	
	items_load()
	talk_load()
	objects = {}
	door_load()
	branch_load()
	r_botton_load()
	t_botton_load()
	item_load()
	event_load()
	map_load()
	objects.door = {}
	objects.r_botton = {}
	objects.t_botton = {}
	objects.branch = {}
	objects.item = {}
	
	--mapNum = 2
	doorNum = #doorId
	branchNum = #branchId
	itemNum = #itemId
	r_bottonNum = #rId
	t_bottonNum = #tId
	Fmap7 = true
	eventIng = false
	event1Ing = false
	gameover = false
	
	for i=1,doorNum do
		objects.door[i] = door:new(doorMap[i], doorId[i], doorLock[i], doorKey[i], doorGo[i], doorGoBranch[i])
	end
	for i=1,r_bottonNum do
		objects.r_botton[i] = r_botton:new(rMap[i], rId[i], rGo[i], rGoBranch[i], rGoBranch2[i])
	end
	for i=1,t_bottonNum do
		objects.t_botton[i] = t_botton:new(tMap[i], tId[i], tGoBranch[i], tGoBranch2[i])
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
	event_update(dt)
	map_update(dt)
	if gameover then
		changegamestate("menu")
	end
end

function game_draw()
	love.graphics.draw(map, 0, 0)
	item_draw(mainMap[1], mainMap[2], mainMap[3])
	
	love.graphics.setColor(0, 0, 0)
	love.graphics.setFont(mainFont);

	--for debug
	love.graphics.print("Map"..mainMap[1].." "..mainMap[2].." "..mainMap[3], 180, 150)
	love.graphics.print(clickMessage, 180, 180)
	--for debug
	
	love.graphics.setColor(0, 0, 0, 255*screendarkness)
	love.graphics.rectangle("fill", 0, 0, 800, 600)
	love.graphics.setColor(255, 255, 255)
	
	love.graphics.draw(horn, 735, 20, 0, 1.3, 1.3)
	
	items_draw()
	event_draw()	
	talk_draw()
	if not have_talk_or_question() then
		r_botton_draw()
		t_botton_draw()
	end
end

function game_mousepressed(x, y, button)
	--有話要說或有問題要回答時，只對 talk_mousepressed 有反應
	if have_talk_or_question() then
		talk_mousepressed(x, y, button)
	elseif items_mousepressed(x, y, button) == false then
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
			--return botton 128 128
			elseif r==128 and g==128 then 
				clickMessage = "return:".. b/25 .. " " .. x .. " ".. y
				clickRbotton(b/25)
			--turn botton 0 128
			elseif r==0 and g==128 then 
				clickMessage = "turn:".. b/10 .. " " .. x .. " ".. y
				clickTbotton(b/10)
			--event item 128 0
			elseif r==128 and g==0 then 
				clickMessage = "event item:".. b/10 .. " " .. x .. " ".. y
				clickEventI(b/10)
			elseif r==0 and g==255 then 
				clickMessage = "item:".. b/25 .. " " .. x .. " ".. y
				clickItem(b/25)
			end
		elseif button=='r' then
			local r, g, b, a = mask:getPixel(x, y)
			--door 0 0
			if r==0 and g==255 then 
				clickMessage = "button=r, item:".. b/25 .. " " .. x .. " ".. y
				clickItemR(b/25)
			end
			clickMessage=""
		else
			clickMessage=""
		end
	end
end

function game_keypressed(key)
	--有話要說或有問題要回答時，對鍵盤無效
	if have_talk_or_question() == false then
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
				local tmp = objects.door[-1*mainMap[2]]:go()
				moveMap(tmp[1], tmp[2], tmp[3])
			end
		else
			items_keypressed(key)
			talk_keypressed(key)
		end
	end
end

function moveMap(id1, id2, id3)
	if have_talk_or_question() == false then
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
		if(Fmap7 and id1==7 and id2==0 and id3==0) then
			Fmap7 = false
			doEvent1()
		end

		for i=1, #mapId do
			if mapId[i][1] == id1 and mapId[i][2] == id2 and mapId[i][3] == id3 and mapFirst[i] then
				MapTalk = true
				nowM = i
				break
			end
		end
		
		if(id1==7 and id2==1 and id3==2) then
			if findItems("Items/7-1-2-1.png") == false then
				items_add("Items/7-1-2-1.png")
			end
		end
	end
end

function clickDoor(id)
	local d = 0
	for i=1,doorNum do
		if objects.door[i].map == mainMap[1] and objects.door[i].index == id then
			d = i
			if objects.door[i].lock == 1 and getSelectItems() == objects.door[i].key then
				objects.door[i].lock = 0
				items_delete(getSelectItems())
				setUserSay(doorOpenTalk[d])
			end
			break
		end
	end
	if d ~=0 then
		if objects.door[d]:islock() then
			setUserSay(doorTalk[d])
		else
			local tmp = objects.door[d]:go()
			-- playsound
			moveMap(tmp[1], tmp[2], tmp[3])
		end
	end
end

function clickBranch(id)
	local d = 0
	for i=1,branchNum do
		if objects.branch[i].map == mainMap[1] and objects.branch[i].index == id then
			d = i
			break
		end
	end
	if d ~=0 then
		local tmp = objects.branch[d]:go()
		-- playsound
		moveMap(tmp[1], tmp[2], tmp[3])
	end
end

function clickRbotton(id)
	local d = 0
	for i=1,r_bottonNum do
		if objects.r_botton[i].map == mainMap[1] and objects.r_botton[i].index == id then
			d = i
			break
		end
	end
	if d ~=0 then
		if event1Ing and d==27 then
			setGirlSay("快。點。念。故。事。　　　　　　　　　　不可以出去啦！")
		else
			local tmp = objects.r_botton[d]:go()
			-- playsound
			moveMap(tmp[1], tmp[2], tmp[3])
		end
	end
end

function clickTbotton(id)
	local d = 0
	for i=1,t_bottonNum do
		if objects.t_botton[i].map == mainMap[1] and objects.t_botton[i].index == id then
			d = i
			break
		end
	end
	if d ~=0 then
		local tmp = objects.t_botton[d]:go()
		-- playsound
		moveMap(tmp[1], tmp[2], tmp[3])
	end
end


function clickItem(id)
	local d = 0
	for i=1,itemNum do
		if itemMap1[i] == mainMap[1] and itemMap2[i] == -mainMap[2] and itemMap3[i] == -mainMap[3] and itemId[i] == id then
			d = i
			break
		end
	end
	if d ~=0 then
		item_chang(d, objects)
	end
end

function clickItemR(id)
	for i=1,itemNum do
		if itemMap1[i] == mainMap[1] and itemMap2[i] == -mainMap[2] and itemMap3[i] == -mainMap[3] and itemId[i] == id then
			item_showDescription(i)
			break
		end
	end
	
end