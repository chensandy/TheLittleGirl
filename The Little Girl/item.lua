item = class:new()

function item_load()
	itemMap1 = {2, 2, 2,
			    4, 4,
				5,
				7, 7,
				8, 8, 8, 8, 8, 8, 8, 8, 8,
			    9, 9, 9,
				10, 10, 10, 10,
				11, 11, 11, 11, 11, 11,
				13}	
	itemMap2 = {1, 2, 2,
			    1, 2,
				1,
				2, 3,
				1, 1, 1, 1, 1, 1, 1, 1, 1,
			    1, 2, 2,
				2, 2, 2, 2,
				2, 1, 1, 3, 3, 3,
				0}
	itemMap3 = {0, 0, 1,
			    1, 0,
				1,
				3, 0,
				2, 3, 3, 3, 3, 3, 3, 3, 3,
			    1, 3, 1,
				1, 1, 1, 1,
				0, 0, 1, 0, 0, 0,
				0}	
	itemStatus = {-1, -1, -1,
				  -1, -1,
				  -1,
				  -1, -1,
				  -1, -2, -3, -4, -5, -8, -6, -7, -9,
				  -1, -1, -1,
				  -1, -2, -3, -4,
				  -1, -1, -1, -1, -2, -3,
				  -1}
	itemId = {1, 2, 3,
			  2, 1,
			  1,
			  1, 2,
			  1, 2, 3, 4, 5, 7, 8, 9, 10,
			  1, 2, 3,
			  1, 2, 3, 4,
			  2, 1, 3, 5, 4, 6,
			  1}
	itemX = {441, 230, 230,
			 300, 246,
			 250,
			 396, 107,
			 549, 696, 695, 694, 697, 172, 260, 353, 445,
			 677, 390, 244,
			 404, 307, 277, 304,
			 365, 680, 672, 419, 216, 144,
			 525}
	itemY = {174, 225, 225,
			 380, 234,
			 117,
			 307, 319,
			 378, 230, 274, 322, 367, 234, 234, 234, 234,
			 389, 467, 87,
			 179, 280, 329, 317,
			 216, 219, 218, 336, 380, 342,
			 254}
	--[[
	itemLast=0 : 要顯示，可拿取的 item(會消失)
	itemLast>0 : 改變連結到此的 branch (itemMap1-itemMap2-0 改成 itemMap1-itemMap2-itemLast)
	itemLast<0 : 改變顯示的 item ( itemMap1-itemMap2-itemMap3-itemStatus 改成 itemMap1-itemMap2-itemMap3-(itemStatus-1) )
	itemLast=999 ：一開始不在(不顯示)，拿了之後 itemLast 變成 998
	itemLast=998 ：已使用 item，要顯示出來，不可再拿取
	itemLast=997 ：由其他事件觸發此物件出現，出現後可拿取，itemLast 變成 0
	itemLast=996 ：由其他事件觸發此物件出現，出現後不可拿取，itemLast 變成 998
	--]]
	itemLast = {0, 1, -2,
			    0, 0,
				0,
				0, 0,
				0, 999, 999, 999, 999, 996, 996, 996, 996,
			    0, 0, 0,
				999, 999, 999, 997,
				0, 1, 0, 0, 0, 0,
				0}
	itemUsed = {"Items/2-2-1-1.png", 0, 0,
			    0, 0,
				0,
				0, 0,
				0, "Items/4-1-1-1.png", "Items/USB2.png", "Items/USB3.png", "Items/11-3-3.png", 0, 0, 0, 0,
			    0, 0, "Items/13-1.png",
				"Items/7-2-3-1-1-1.png", "Items/11-2-1.png", "Items/9-2-3-1.png", 0,
				0, 0, "Items/9-2-3-1.png", 0, 0, 0,
				0}
	itemChangBranchTo = {0, {to1=2, to2=2, to3=1}, 0,
						 0, 0,
						 0,
						 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0,
						 0, 0, 0, 0,
						 0, {to1=11, to2=1, to3=1}, 0, 0, 0, 0,
						 0}
	itemTalk = {"使用方糖夾，獲得鑰匙", "打開糖罐", "獲得方糖夾",
			    "獲得隨身碟", "獲得鑰匙",
				"獲得磁卡",
				"獲得針", "獲得磁卡",
				"獲得珠子", "插入艾洛的 USB", "插入馬克的 USB", "插入麥斯的 USB", "插入伊莉的 USB", "艾洛的 USB", "馬克的 USB", "麥斯的 USB", "伊莉的 USB",
			    "獲得項鍊", "獲得剪刀", "使用斧頭，砍掉藤蔓",
				"縫上珠子", "使用蝴蝶結", "剪開布娃娃", "獲得鑰匙",
				"獲得蝴蝶結", "拉短線頭", "使用剪刀，獲得線圈", "獲得蠟燭", "獲得火柴", "獲得伊莉 USB",
				"獲得斧頭"}
	itemDescription = {"沙發下好像有什麼東西，但是手搆不到", "有一個糖罐", "一個方糖夾，可以用來做什麼嗎",
					   "好像有用歐", "好像可以拿來開門",
					   "好像可以拿來開門",
					   "這一根尖尖的是什麼？", "好像有用歐",
					   "小珠子", "黃色的 USB 孔", "藍色的 USB 孔", "綠色的 USB 孔", "桃紅色的 USB 孔", "I 槽", "J 槽", "K 槽", "H 槽",
					   "好漂亮", "好像能拿來剪開東西", "被藤蔓擋住了",
					   "少一顆珠子", "好像缺少了甚麼", "好像可以剪開", "一把銅色鑰匙",
					   "好漂亮的蝴蝶結", "有線頭", "哎呀，線頭被拉長了，這條線好像蠻堅韌的", "生日蠟燭？", "乾燥的火柴，可以點火", "很可疑",
					   "好鋒利的斧頭"}
	itemFirstPressed = {true, true, true,
						true, true,
						true,
						true, true,
						true, true, true, true, true, true, true, true, true,
						true, true, true,
						true, true, true, true,
						true, true, true, true, true, true,
						true}
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
			if itemStatus[i] ~= 0 and itemLast[i] ~= 999 and itemLast[i] ~= 997 and itemLast[i] ~= 996 then
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
	
	if itemFirstPressed[d] then
		itemFirstPressed[d] = false
		setUserSay(itemDescription[d])
		return
	end
	
	--不是最終狀態
	if itemStatus[d] ~= itemLast[d] then
		--clickMessage = "*** "..getSelectItems().." "..itemUsed[d]
		--選對拿取的 item or 直接可拿
		if getSelectItems() == itemUsed[d] or itemUsed[d] == 0 then
			--選對東西先刪除 items
			if getSelectItems() == itemUsed[d] then
				items_delete(getSelectItems())
			end
			--拿取 items 
			if itemLast[d] == 0 or itemStatus[d] == itemLast[d] + 1 then
				if itemMap3[d] ~= 0 then
					--clickMessage = "items_add "..itemStatus[d].." "..itemLast[d]
					items_add("Items/" .. itemMap1[d] .. "-" .. itemMap2[d] .. "-" .. itemMap3[d] .. itemStatus[d] ..".png")
				elseif itemMap2[d] ~=0 then
					--clickMessage = "items_add "..itemStatus[d].." "..itemLast[d]
					items_add("Items/" .. itemMap1[d] .. "-" .. itemMap2[d] .. itemStatus[d] ..".png")
				else
					--clickMessage = "items_add "..itemStatus[d].." "..itemLast[d]
					items_add("Items/" .. itemMap1[d] .. itemStatus[d] ..".png")
				end
				itemStatus[d] = itemLast[d]
			elseif item_needChangBranch(d) then
				itemStatus[d] = -itemLast[d]
				branch_changBranch(itemMap1[d], itemMap2[d], itemMap3[d], itemChangBranchTo[d].to1, itemChangBranchTo[d].to2, itemChangBranchTo[d].to3)
			elseif itemLast[d] == 999 then
				itemLast[d] = 998
			elseif itemLast[d] == 998 then
				return
			elseif itemLast[d] == 997 then
				return
			elseif itemLast[d] == 996 then
				return
			else
				itemStatus[d] = itemStatus[d] - 1
			end
			
			setUserSay(itemTalk[d])
			
			--眼睛 + 蝴蝶結
			if itemMap1[d] == 10 and itemMap2[d] == 2 and itemMap3[d] == 1 and itemStatus[d] == -2 and itemLast[d] == 998 then
				for i=1,#itemMap1 do
					if itemMap1[i] == 10 and itemMap2[i] == 2 and itemMap3[i] == 1 and itemStatus[i] == -1 and itemLast[i] == 998 then
						items_add("Items/10-2-2-1.png")
						items_add("Items/10-2-2-2.png")
						setUserSay(itemTalk[d] .. "，並得到鑰匙和雕刻物 \"EC\"")
					end
				end
			--蝴蝶結 + 眼睛 
			elseif itemMap1[d] == 10 and itemMap2[d] == 2 and itemMap3[d] == 1 and itemStatus[d] == -1 and itemLast[d] == 998 then
				for i=1,#itemMap1 do
					if itemMap1[i] == 10 and itemMap2[i] == 2 and itemMap3[i] == 1 and itemStatus[i] == -2 and itemLast[i] == 998 then
						items_add("Items/10-2-2-1.png")
						items_add("Items/10-2-2-2.png")
						setUserSay(itemTalk[d] .. "，並得到鑰匙和雕刻物 \"EC\"")
					end
				end
			--剪刀剪兔娃娃，顯示鑰匙 X
			elseif itemMap1[d] == 10 and itemMap2[d] == 2 and itemMap3[d] == 1 and itemStatus[d] == -3 and itemLast[d] == 998 then
				for i=1,#itemMap1 do
					if itemMap1[i] == 10 and itemMap2[i] == 2 and itemMap3[i] == 1 and itemStatus[i] == -4 and itemLast[i] == 997 then
						itemLast[i] = 0;
					end
				end
			--插入艾洛的隨身碟
			elseif itemMap1[d] == 8 and itemMap2[d] == 1 and itemMap3[d] == 3 and itemStatus[d] == -2 and itemLast[d] == 998 then
				for i=1,#itemMap1 do
					if itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -8 and itemLast[i] == 996 then
						itemLast[i] = 998;
					end
				end
			--插入馬克的隨身碟
			elseif itemMap1[d] == 8 and itemMap2[d] == 1 and itemMap3[d] == 3 and itemStatus[d] == -3 and itemLast[d] == 998 then
				for i=1,#itemMap1 do
					if itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -6 and itemLast[i] == 996 then
						itemLast[i] = 998;
					end
				end
			--插入麥斯的隨身碟
			elseif itemMap1[d] == 8 and itemMap2[d] == 1 and itemMap3[d] == 3 and itemStatus[d] == -4 and itemLast[d] == 998 then
				for i=1,#itemMap1 do
					if itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -7 and itemLast[i] == 996 then
						itemLast[i] = 998;
					end
				end
			--插入伊莉的隨身碟
			elseif itemMap1[d] == 8 and itemMap2[d] == 1 and itemMap3[d] == 3 and itemStatus[d] == -5 and itemLast[d] == 998 then
				for i=1,#itemMap1 do
					if itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -9 and itemLast[i] == 996 then
						itemLast[i] = 998;
					end
				end
			end
		end
	end
end

function item_needChangBranch(d)
	if itemChangBranchTo[d] ~= 0 then
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