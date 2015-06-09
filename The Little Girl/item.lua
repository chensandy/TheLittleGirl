item = class:new()

function item_load()	--4
	itemMap1 = {2, 2,	--2
			    4,	--1
			    9}	--1
	itemMap2 = {1,2,
			    1,
			    1}
	itemMap3 = {0,0,
			    1,
			    1}
	itemStatus = {-1,-1,
				  -1,
				  -1}
	itemId = {1,2,
			  2,
			  1}
	itemX = {441, 230,
			 300,
			 677}
	itemY = {174, 255,
			 410,
			 389}
	itemLast = {0,-3,
			    0,
			    0}
end

function item:init(m1, m2, m3, id, status, x, y, last)
	self.map1 = m1
	self.map2 = m2
	self.map3 = m3
	self.index = id
	self.status = status
	self.x = x
	self.y = y
	self.last = last
end

function item_draw(map1, map2, map3)
	for i=1,#itemMap1 do
		if itemMap1[i] == map1 and itemMap2[i] == -map2 and itemMap3[i] == -map3 then
			if itemStatus[i] ~= 0 then
				local itemGraphics
				if -map3 ~= 0 then
					itemGraphics = love.graphics.newImage("maps/item" .. map1 .. map2 .. map3 .. itemStatus[i] ..".png")
				elseif -map2~=0 then
					itemGraphics = love.graphics.newImage("maps/item" .. map1 .. map2 .. itemStatus[i] ..".png")
				else
					itemGraphics = love.graphics.newImage("maps/item" .. map1 .. itemStatus[i] ..".png")
				end
				love.graphics.draw(itemGraphics, itemX[i], itemY[i])
			end
		end
	end
end

function item:chang(d)
	--clickMessage = "*** "..self.status.." "..self.last
	if self.status ~= self.last then
		if self.last == 0 or self.status == self.last + 1 then
			if self.map3 ~= 0 then
				items_add("Items/" .. self.map1 .. "-" .. self.map2 .. "-" .. self.map3 .. self.status ..".png")
			elseif self.map2 ~=0 then
				items_add("Items/" .. self.map1 .. "-" .. self.map2 .. self.status ..".png")
			else
				items_add("Items/" .. self.map1 .. self.status ..".png")
			end
			self.status = self.last
		else
			self.status = self.status - 1
		end
		itemStatus[d] = self.status
	end
end