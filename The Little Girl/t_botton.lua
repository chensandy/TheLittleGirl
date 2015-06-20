t_botton = class:new()

function t_botton_load() --50
	tMap = {7,
			8, 8, 8, 8, 8, 8, 8,
			10, 10
			}
	tId = {1,
		   1, 2, 3, 4, 5, 6, 7,
		   1, 2
		   }
	tGoBranch = {2,
				 2, 1, 1, 1, 1, 1, 1,
				 1, 2
				 }
	tGoBranch2 = {3,
				  0, 0, 5, 7, 10, 11, 12,
				  0, 0
				  }
	tOnBotton = {"maps/arrow_right_hover.png",
				 "maps/flipup_hover.png", "maps/flipup_hover.png",0,0,0,0,0,
				 "maps/flipdown_hover.png", "maps/flipdown_hover.png"
				 }
	tBottonAt = {{748,282},
				 {743,282},{743,282},{748,282},{748,282},{748,282},{748,282},{748,282},
				 {743,282},{743,282}}
end
function t_botton:init(m, id, b, b2)
	self.map = m
	self.index = id
	self.goto = {m, b, b2}
end

function t_botton:go()
	return self.goto
end

function t_botton_draw()
	local x = love.mouse.getX()
	local y = love.mouse.getY()
	local r, g, b, a = mask:getPixel(x, y)
	if r==0 and g==128 then 
		d=0
		for i=1,#tId do
			if tMap[i] == mainMap[1] and tId[i] == b/10 then
				d = i
				break
			end
		end
		if d~=0 then
			if love.filesystem.exists( tOnBotton[d] ) then
				on_t_botton = love.graphics.newImage(tOnBotton[d])
				love.graphics.draw(on_t_botton, tBottonAt[d][1], tBottonAt[d][2])
			end
		end
	end
end