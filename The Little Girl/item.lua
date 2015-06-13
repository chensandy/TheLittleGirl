item = class:new()

function item_load()	--7
	itemMap1 = {2, 2, 2,	--3
			    4, 4,	--2
				5,
			    9, 9,	--1
				10, 10, 10,
				11, 11, 11}	--1
	itemMap2 = {1, 2, 2,
			    1, 2,
				1,
			    1, 2,
				2, 2, 2,
				2, 1, 1}
	itemMap3 = {0, 0, 1,
			    1, 0,
				1,
			    1, 3,
				1, 1, 1,
				0, 0, 1}
	itemStatus = {-1, -1, -1,
				  -1, -1,
				  -1,
				  -1, -1,
				  -1, -2, -3,
				  -1, -1, -1}
	itemId = {1, 2, 3,
			  2, 1,
			  1,
			  1, 2,
			  1, 2, 3,
			  2, 1, 3}
	itemX = {441, 230, 230,
			 300, 246,
			 250,
			 677, 390,
			 404, 307, 277,
			 365, 680, 672}
	itemY = {174, 225, 225,
			 380, 234,
			 117,
			 389, 467,
			 179, 280, 329,
			 216, 219, 218}
	--[[
	itemLast=0 : 可拿取的 item(會消失)
	itemLast>0 : 改變連結到此的 branch (itemMap1-itemMap2-0 改成 itemMap1-itemMap2-itemLast)
	itemLast<0 : 改變顯示的 item ( itemMap1-itemMap2-itemMap3-itemStatus 改成 itemMap1-itemMap2-itemMap3-(itemStatus-1) )
	--]]	
	itemLast = {0, 1, -2,
			    0, 0,
				0,
			    0, 0,
				999, 999, 999,
				0, 1, 0}
	itemUsed = {"Items/2-2-1-1.png", 0, 0,
			    0, 0,
				0,
			    0, 0,
				"Items/11-2-1.png", "Items/11-2-1.png", "Items/11-2-1.png",
				0, 0, 0}
	itemTalk = {"使用鑷子，得到鑰匙", "打開糖罐", "得到鑷子",
			    "得到隨身碟", "得到鑰匙",
				"得到磁卡",
			    "得到項鍊", "得到剪刀",
				"使用珠子", "使用蝴蝶結", "剪開布娃娃",
				"得到蝴蝶結", "拉短線頭", "得到線圈"}
end

function item:init(m1, m2, m3, id, status, x, y, last, used)
	self.map1 = m1
	self.map2 = m2
	self.map3 = m3
	self.index = id
	self.status = status
	self.x = x
	self.y = y
	self.last = last
	self.used = used
end

function item_draw(map1, map2, map3)
	for i=1,#itemMap1 do
		if itemMap1[i] == map1 and itemMap2[i] == -map2 and itemMap3[i] == -map3 then
			if itemStatus[i] ~= 0 and itemLast[i] ~= 999 then
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
		clickMessage = "*** "..getSelectItems().." "..self.used
		if getSelectItems() == self.used or self.used == 0 then
			if self.last == 0 or self.status == self.last + 1 or self.last == 998 then
				if self.map3 ~= 0 then
					--clickMessage = "items_add "..self.status.." "..self.last
					items_add("Items/" .. self.map1 .. "-" .. self.map2 .. "-" .. self.map3 .. self.status ..".png")
				elseif self.map2 ~=0 then
					--clickMessage = "items_add "..self.status.." "..self.last
					items_add("Items/" .. self.map1 .. "-" .. self.map2 .. self.status ..".png")
				else
					--clickMessage = "items_add "..self.status.." "..self.last
					items_add("Items/" .. self.map1 .. self.status ..".png")
				end
				self.status = self.last
			elseif self.last == 1 then
				self.status = self.last
			elseif self.last == 999 then
				self.last = 998
				itemLast[d] = 998
			else
				self.status = self.status - 1
			end
			setUserSay(itemTalk[d])
			itemStatus[d] = self.status
			if getSelectItems() == self.used then
				items_delete(getSelectItems())
			end
		end
	end
end

function item:needChangBranch()
	if self.status > 0 then
		return true
	else
		return false
	end
end