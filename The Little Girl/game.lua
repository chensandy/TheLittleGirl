function game_load()
	
	mapNum = 2
	
	screendarkness = 1
	mainFont = love.graphics.newFont("Fonts/NotoSansCJKtc-Regular.otf", 40);
	love.graphics.setBackgroundColor(192, 192, 255)
	
	
	map = {}
	for i=1,mapNum do
	map[i] = love.graphics.newImage("maps/map" .. i .. ".png");
	end
	bmap = love.graphics.newImage("maps/map1.png");
	mainMap = 1;
	branchMap = 0;
	
	items_load()
	--music:stop()
	--musicrev:play()
end

function game_update(dt)
	if screendarkness > 0 then
		screendarkness = math.max(0, screendarkness - dt/2)
	end
	if branchMap ~= 0 then
		bmap = love.graphics.newImage("maps/map" .. mainMap .. branchMap .. ".png");
	end
end

function game_draw()
	
	if branchMap == 0 then
		love.graphics.draw(map[mainMap], 0, 0)
	else
		love.graphics.draw(bmap, 0, 0)
	end
	
	love.graphics.setColor(0, 0, 0)
	love.graphics.setFont(mainFont);
	love.graphics.print("Map"..mainMap, 180, 150)
	
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
	elseif key == 'z' then
		branchMap = 0
	else
		items_keypressed(key)
	end
end