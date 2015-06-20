r_botton = class:new()

function r_botton_load() --49
	rMap = {1, 1, 1, 1, 1,   --5
			2, 2, 2,  --3
			3, 3, 3, 3, 3, 3, 3, 3, 3, 3, --10
			4, 4, 4, 4, --4
			5, 5, 5, 5,--3
			6, 6, --2
			7, 7, 7, 7, 7, 7,--6
			8, 8, 8, 8, --4
			9, 9, 9, 9, 9, 9, 9,--7
			10, 10, 10, 10, 10,--3->5
			11, 11, 11, --3
			13}
	rId = {1, 2, 3, 4, 5,
		   1, 2, 3,
		   1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
		   1, 2, 3, 4,
		   1, 2, 3, 4,
		   1, 2,
		   1, 2, 3, 4, 5, 6,
		   1, 3, 4, 5,
		   1, 2, 3, 4, 5, 6, 7,
		   3, 4, 5, 1, 2,
		   1, 2, 3,
		   1}
	rGo = {1, 1, 1, 1, 1,
		   1, 2, 2,
		   3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
		   3, 4, 4, 4,
		   3, 5, 5, 5,
		   3, 6,
		   3, 7, 7, 7, 7, 7,
		   8, 8, 8, 8,
		   8, 9, 9, 9, 9, 9, 9,
		   10, 10, 10, 10, 10,
		   10, 11, 11,
		   3}
	rGoBranch = {1, 0, 0, 0, 0,
			     0, 0, 0,
				 1, 1, 1, 1, 1, 2, 1, 2, 2, 3,
				 1, 0, 1, 0,
				 1, 0, 1, 2,
				 1, 0,
				 2, 0, 0, 2, 2, 0,
				 1, 1, 2, 2,
				 2, 0, 0, 1, 2, 2, 2,
				 1, 1, 2, 1, 1,
				 1, 0, 0,
				 2}
	rGoBranch2 = {0, 0, 0, 0, 0,
			     0, 0, 0,
				 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				 0, 0, 0, 0,
				 0, 0, 0, 0,
				 0, 0,
				 0, 0, 0, 0, 0, 0,
				 0, 0, 0, 0,
				 0, 0, 0, 0, 0, 0, 2,
				 0, 0, 0, 0, 3,
				 0, 0, 0,
				 0}
	on_r_botton = love.graphics.newImage("maps/hover.png");
end
function r_botton:init(m, id, go, b, b2)
	self.map = m
	self.index = id
	self.goto = {go, b, b2}
end

function r_botton:go()
	return self.goto
end

function r_botton_draw()
	local x = love.mouse.getX()
	local y = love.mouse.getY()
	local r, g, b, a = mask:getPixel(x, y)
	if r==128 and g==128 then 
		love.graphics.draw(on_r_botton, 375, 508)
	end
end