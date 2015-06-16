item = class:new()

function item_load()
	itemMap1 = {2, 2, 2,
			    4, 4,
				5,
				7, 7,
				8,
			    9, 9,
				10, 10, 10,
				11, 11, 11,
				13}	
	itemMap2 = {1, 2, 2,
			    1, 2,
				1,
				2, 3,
				1,
			    1, 2,
				2, 2, 2,
				2, 1, 1,
				0}
	itemMap3 = {0, 0, 1,
			    1, 0,
				1,
				3, 0,
				2,
			    1, 3,
				1, 1, 1,
				0, 0, 1,
				0}
	itemStatus = {-1, -1, -1,
				  -1, -1,
				  -1,
				  -1, -1,
				  -1,
				  -1, -1,
				  -1, -2, -3,
				  -1, -1, -1,
				  -1}
	itemId = {1, 2, 3,
			  2, 1,
			  1,
			  1, 2,
			  1,
			  1, 2,
			  1, 2, 3,
			  2, 1, 3,
			  1}
	itemX = {441, 230, 230,
			 300, 246,
			 250,
			 396, 107,
			 549,
			 677, 390,
			 404, 307, 277,
			 365, 680, 672,
			 525}
	itemY = {174, 225, 225,
			 380, 234,
			 117,
			 307, 319,
			 378,
			 389, 467,
			 179, 280, 329,
			 216, 219, 218,
			 254}
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
				0, 0,
				0,
			    0, 0,
				999, 999, 999,
				0, 1, 0,
				0}
	itemUsed = {"Items/2-2-1-1.png", 0, 0,
			    0, 0,
				0,
				0, 0,
				0,
			    0, 0,
				"Items/7-2-3-1-1.png", "Items/11-2-1.png", "Items/9-2-3-1.png",
				0, 0, "Items/9-2-3-1.png",
				0}
	itemTalk = {"使用方糖夾，獲得鑰匙", "打開糖罐", "獲得方糖夾",
			    "獲得隨身碟", "獲得鑰匙",
				"獲得磁卡",
				"獲得針", "獲得磁卡",
				"獲得珠子",
			    "獲得項鍊", "獲得剪刀",
				"使用珠子", "使用蝴蝶結", "剪開布娃娃",
				"獲得蝴蝶結", "拉短線頭", "使用剪刀，獲得線圈",
				"獲得斧頭"}
	itemDescription = {"沙發下好像有什麼東西，但是手搆不到", "有一個糖罐", "一個方糖夾，可以用來做什麼嗎",
					   "好像有用歐", "好像可以拿來開門",
					   "好像可以拿來開門",
					   "這一根尖尖的是什麼？", "好像有用歐",
					   "小珠子",
					   "好漂亮", "好像能拿來剪開東西",
					   "少一顆珠子", "好像缺少了甚麼", "好像可以剪開",
					   "好漂亮的蝴蝶結", "有線頭", "哎呀，線頭被拉長了，這條線好像蠻堅韌的",
					   "好鋒利的斧頭"}
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
			--判斷 item 拿走不會再出現 or 還未出現
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

function item_chang(d, objects)
	--clickMessage = "*** "..self.status.." "..self.last
	--不是最終狀態
	if itemStatus[d] ~= itemLast[d] then
		clickMessage = "*** "..getSelectItems().." "..itemUsed[d]
		--選對拿取的 item or 直接可拿
		if getSelectItems() == itemUsed[d] or itemUsed[d] == 0 then
			if getSelectItems() == itemUsed[d] then
				items_delete(getSelectItems())
			end
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
			elseif item_needChangBranch(d) then
				itemStatus[d] = -itemLast[d]
				for i=1,branchNum do
					local tmp = objects.branch[i]:go()
					if tmp[1] == itemMap1[d] and tmp[2] == itemMap2[d] and tmp[3] == 0 then
						tmp[3] = itemLast[d]
						clickMessage = "*** needChangBranch to: " .. tmp[1] .. "," .. tmp[2] .. "," .. tmp[3]
						moveMap(tmp[1], tmp[2], tmp[3])
					end
				end
			elseif itemLast[d] == 999 then
				itemLast[d] = 998
			else
				itemStatus[d] = itemStatus[d] - 1
			end
			setUserSay(itemTalk[d])
		end
	end
end

function item_needChangBranch(d)
	if itemLast[d] > 0 and itemLast[d] < 998 then
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