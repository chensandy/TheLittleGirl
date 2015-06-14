item = class:new()

function item_load()	--7
	itemMap1 = {2, 2, 2,	--3
			    4, 4,	--2
				5,
				7,
			    9, 9,	--1
				10, 10, 10,
				11, 11, 11}	--1
	itemMap2 = {1, 2, 2,
			    1, 2,
				1,
				2,
			    1, 2,
				2, 2, 2,
				2, 1, 1}
	itemMap3 = {0, 0, 1,
			    1, 0,
				1,
				3,
			    1, 3,
				1, 1, 1,
				0, 0, 1}
	itemStatus = {-1, -1, -1,
				  -1, -1,
				  -1,
				  -1,
				  -1, -1,
				  -1, -2, -3,
				  -1, -1, -1}
	itemId = {1, 2, 3,
			  2, 1,
			  1,
			  1,
			  1, 2,
			  1, 2, 3,
			  2, 1, 3}
	itemX = {441, 230, 230,
			 300, 246,
			 250,
			 397,
			 677, 390,
			 404, 307, 277,
			 365, 680, 672}
	itemY = {174, 225, 225,
			 380, 234,
			 117,
			 49,
			 389, 467,
			 179, 280, 329,
			 216, 219, 218}
	--[[
	itemLast=0 : 可拿取的 item(會消失)
	itemLast>0 : 改變連結到此的 branch (itemMap1-itemMap2-0 改成 itemMap1-itemMap2-itemLast)
	itemLast<0 : 改變顯示的 item ( itemMap1-itemMap2-itemMap3-itemStatus 改成 itemMap1-itemMap2-itemMap3-(itemStatus-1) )
	itemLast=999 ：一開始不在
	itemLast=998 ：已使用 item，要顯示出來，不可再拿取
	--]]	
	itemLast = {0, 1, -2,
			    0, 0,
				0,
				0,
			    0, 0,
				999, 999, 999,
				0, 1, 0}
	itemUsed = {"Items/2-2-1-1.png", 0, 0,
			    0, 0,
				0,
				0,
			    0, 0,
				"Items/?.png", "Items/11-2-1.png", "Items/9-2-3-1.png",
				0, 0, "Items/9-2-3-1.png"}
	itemTalk = {"使用方糖夾，得到鑰匙", "打開糖罐", "得到方糖夾",
			    "得到隨身碟", "得到鑰匙",
				"得到磁卡",
				"得到針",
			    "得到項鍊", "得到剪刀",
				"使用珠子", "使用蝴蝶結", "剪開布娃娃",
				"得到蝴蝶結", "拉短線頭", "使用剪刀，得到線圈"}
	itemDescription = {"沙發下好像有什麼東西，但是手搆不到", "有一個糖罐", "一個方糖夾，可以用來做什麼嗎",
					   "好像有用歐", "好像可以拿來開門",
					   "好像可以拿來開門",
					   "這一根尖尖的是什麼？",
					   "好漂亮", "好像能拿來剪開東西",
					   "少一顆珠子", "好像缺少了甚麼", "好像可以剪開",
					   "好漂亮的蝴蝶結", "有線頭", "哎呀，線頭被拉長了，這條線好像蠻堅韌的"}
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
				itemGraphics = nil
			end
		end
	end
end

function item_chang(d)
	--clickMessage = "*** "..self.status.." "..self.last
	if itemStatus[d] ~= itemLast[d] then
		clickMessage = "*** "..getSelectItems().." "..itemUsed[d]
		if getSelectItems() == itemUsed[d] or itemUsed[d] == 0 then
			if itemLast[d] == 0 or itemStatus[d] == itemLast[d] + 1 or itemLast[d] == 998 then
				if itemMap3[d] ~= 0 then
					clickMessage = "items_add "..itemStatus[d].." "..itemLast[d]
					items_add("Items/" .. itemMap1[d] .. "-" .. itemMap2[d] .. "-" .. itemMap3[d] .. itemStatus[d] ..".png")
				elseif itemMap2[d] ~=0 then
					clickMessage = "items_add "..itemStatus[d].." "..itemLast[d]
					items_add("Items/" .. itemMap1[d] .. "-" .. itemMap2[d] .. itemStatus[d] ..".png")
				else
					clickMessage = "items_add "..itemStatus[d].." "..itemLast[d]
					items_add("Items/" .. itemMap1[d] .. itemStatus[d] ..".png")
				end
				itemStatus[d] = itemLast[d]
			elseif itemLast[d] == 1 then
				itemStatus[d] = itemLast[d]
			elseif itemLast[d] == 999 then
				itemLast[d] = 998
			else
				itemStatus[d] = itemStatus[d] - 1
			end
			setUserSay(itemTalk[d])
			if getSelectItems() == itemUsed[d] then
				items_delete(getSelectItems())
			end
		end
	end
end

function item_needChangBranch(d)
	if itemStatus[d] > 0 then
		return true
	else
		return false
	end
end

function item_showDescription(d)
	if itemStatus[d] ~= itemLast[d] and itemLast[d] ~= 998 then
		setUserSay(itemDescription[d])
	end
end