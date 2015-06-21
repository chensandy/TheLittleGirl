item = class:new()

function item_load()
	m_itemGraphics = {}
	m_whoOpenVine = 0
	m_itemLockBranch = {}
	itemMap1 = {2, 2, 2, 2,
			    4, 4,
				5, 5,
				6,
				7, 7,
				8, 8, 8, 8, 8, 8, 8, 8, 8,
				8, 8, 8, 8, 8, 8,
			    9, 9, 9, 9,
				10, 10, 10, 10, 10, 10, 10,
				11, 11, 11, 11, 11, 11,
				13}	
	itemMap2 = {1, 2, 2, 2,
			    1, 2,
				1, 3,
				2,
				2, 3,
				1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1,
			    1, 2, 2, 2,
				2, 2, 2, 2, 1, 1, 1,
				2, 1, 1, 3, 3, 3,
				0}
	itemMap3 = {0, 0, 1, 1,
			    1, 0,
				1, 0,
				0,
				3, 0,
				2, 3, 3, 3, 3, 3, 3, 3, 3,
				3, 3, 3, 3, 3, 3,
			    1, 3, 1, 5,
				1, 1, 1, 1, 4, 6, 6, 
				0, 0, 1, 0, 0, 0,
				0}	
	itemStatus = {-1, -1, -1, -2,
				  -1, -1,
				  -1, -1,
				  -1,
				  -1, -1,
				  -1, -2, -3, -4, -5, -8, -6, -7, -9,
				  -11, -12, -13, -14, -1, -10,
				  -1, -1, -1, -1,
				  -1, -2, -3, -4, -1, -1, -2,
				  -1, -1, -1, -1, -2, -3,
				  -1}
	itemId = {1, 2, 3, 0,
			  2, 1,
			  1, 2,
			  1,
			  1, 2,
			  1, 2, 3, 4, 5, 0, 0, 0, 0,
			  7, 8, 9, 10, 6, 100,
			  1, 2, 3, 4,
			  1, 2, 3, 4, 5, 6, 7,
			  2, 1, 3, 5, 4, 6,
			  1}
	itemX = {441, 230, 230, 230,
			 300, 246,
			 250, 391,
			 381,
			 396, 107,
			 549, 696, 695, 694, 697, 181, 269, 362, 454,
			 38, 36, 79, 79, 435, 192, 
			 677, 390, 244, 292,
			 404, 307, 277, 304, 148, 176, 399,
			 365, 680, 672, 419, 216, 144,
			 525}
	itemY = {174, 225, 225, 225,
			 380, 234,
			 117, 175,
			 239,
			 307, 319,
			 378, 230, 274, 322, 367, 203, 203, 204, 204,
			 153, 212, 153, 212, 263, 297, 
			 389, 467, 87, 451,
			 179, 280, 329, 317, 293, 170, 93,
			 216, 219, 218, 336, 380, 342,
			 254}
	--[[
	itemLast=0 : 要顯示，可拿取的 item(會消失)
	itemLast>0 : 改變連結到此的 branch (itemMap1-itemMap2-0 改成 itemMap1-itemMap2-itemLast)
	itemLast<0 : 改變顯示的 item ( itemMap1-itemMap2-itemMap3-itemStatus 改成 itemMap1-itemMap2-itemMap3-(itemStatus-1) )
	itemLast=999 ：一開始不在(不顯示)，觸發後 itemLast 變成 998
	itemLast=998 ：已使用 item，或其他事件觸發後，要顯示出來，不可再拿取
	itemLast=997 ：由其他事件觸發此物件出現，出現後可拿取，itemLast 變成 0
	itemLast=996 ：由其他事件觸發此物件出現，出現後不可拿取，itemLast 變成 998
	itemLast=995 ：由其他事件觸發此物件可點擊後出現，itemLast 變成 999
	--]]
	itemLast = {0, 1, 0, 996,
			    0, 0,
				0, 0,
				0,
				0, 0,
				0, 999, 999, 999, 999, 996, 996, 996, 996,
				995, 995, 995, 995, 995, 996, 
			    0, 0, 0, 0,
				999, 999, 999, 997, 0, 999, 999,
				0, 1, 0, 0, 0, 0,
				0}
	itemUsed = {"Items/2-2-1-1.png", 0, 0, 0,
			    0, 0,
				0, 0,
				0,
				0, 0,
				0, "Items/4-1-1-1.png", "Items/5-3-1.png", "Items/6-2-1.png", "Items/11-3-3.png", 0, 0, 0, 0,
			    0, 0, 0, 0, 0, 0,
				0, 0, {"Items/13-1.png", "Items/11-3-1-1.png"}, 0,
				"Items/7-2-3-1-1-1.png", "Items/11-2-1.png", "Items/9-2-3-1.png", 0, 0, "Items/7-1-2-1.png", "Items/10-2-2-1.png",
				0, 0, "Items/9-2-3-1.png", 0, 0, 0,
				0}
	itemChangBranchTo = {0, {to1=2, to2=2, to3=1}, 0, 0,
						 0, 0,
						 0, 0,
						 0,
						 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0,
						 0, {to1=11, to2=1, to3=1}, 0, 0, 0, 0,
						 0}
	itemTalk = {"使用方糖夾，獲得鑰匙", "打開糖罐", "獲得方糖夾", "沒甚麼特別的",
			    "獲得黃色 USB", "獲得鑰匙",
				"獲得磁卡", "獲得藍色 USB",
				"獲得綠色 USB",
				"獲得針", "獲得磁卡",
				"獲得珠子", "插入愛洛的 USB", "插入馬克的 USB", "插入麥斯的 USB", "插入伊莉的 USB", "愛洛的 USB", "馬克的 USB", "麥斯的 USB", "伊莉的 USB",
			    "打開艾洛的 USB", "打開馬克的 USB", "打開麥斯的 USB", "打開伊莉的 USB", "開啟隱藏項目", "打開 Data", 
				"獲得項鍊。咦！上面有個機關，可以彈出鑰匙", "獲得剪刀", "呼~去除藤蔓了", "獲得小木棒",
				"縫上珠子", "使用蝴蝶結", "剪開布娃娃", "獲得鑰匙", "獲得鑰匙", "放入雕刻物 AL", "放入雕刻物 CE",
				"獲得蝴蝶結", "拉短線頭", "使用剪刀，獲得線圈", "獲得蠟燭", "獲得火柴", "獲得桃紅色 USB",
				"獲得斧頭"}
	itemDescription = {"沙發下好像有什麼東西，但是手搆不到", "有一個糖罐", "一個方糖夾，可以用來做什麼嗎", "沒甚麼特別的",
					   "好像有用歐", "好像可以拿來開門",
					   "好像可以拿來開門", "好像有用歐",
					   "好像有用歐",
					   "這一根尖尖的是什麼？", "好像有用歐",
					   "小珠子", "黃色的 USB 孔", "藍色的 USB 孔", "綠色的 USB 孔", "桃紅色的 USB 孔", "I", "J", "K", "H",
					   "I 槽", "J 槽", "K 槽", "H 槽", "可開啟隱藏項目", "Data", 
					   "好漂亮", "好像能拿來剪開東西", "被藤蔓擋住了", "短小的木棒",
					   "少一顆珠子", "好像缺少了甚麼", "好像可以剪開", "一把銅色鑰匙", "一把銀灰色鑰匙", "空空的", "好像少了甚麼",
					   "好漂亮的蝴蝶結", "有線頭", "哎呀，線頭被拉長了，這條線好像蠻堅韌的", "生日蠟燭？", "乾燥的火柴，可以點火", "很可疑",
					   "好鋒利的斧頭"}
	itemFirstPressed = {true, true, true, false,
						false, true,
						true, false,
						false,
						true, false,
						true, false, false, false, false, false, false, false, false,
						false, false, false, false, false, false,
						true, true, true, true,
						true, true, true, true, true, true, true,
						true, true, true, true, true, true,
						true}
	item_initial()
	item_initialLockBranch()
end

function item_initial()
	for i=1,#itemMap1 do
		if itemMap3[i] ~= 0 then
			m_itemGraphics[i] = love.graphics.newImage("maps/item" .. itemMap1[i] .. "-" .. itemMap2[i] .. "-" .. itemMap3[i] .. itemStatus[i] ..".png")
		elseif itemMap2[i]~=0 then
			m_itemGraphics[i] = love.graphics.newImage("maps/item" .. itemMap1[i] .. "-" .. itemMap2[i] .. itemStatus[i] ..".png")
		else
			m_itemGraphics[i] = love.graphics.newImage("maps/item" .. itemMap1[i] .. itemStatus[i] ..".png")
		end
	end
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
			if itemStatus[i] ~= 0 and itemLast[i] ~= 999 and itemLast[i] ~= 997 and itemLast[i] ~= 996 and itemLast[i] ~= 995 then
				love.graphics.draw(m_itemGraphics[i], itemX[i], itemY[i])
			end
		end
	end
end

function item_chang(d)
	clickMessage = "itemId: " .. itemId[d] .. " itemStatus: " .. itemStatus[d] .. "\n" .. "itemLast: " .. itemLast[d]
	
	if itemFirstPressed[d] then
		if item_isAboutOpenUSB(d) or item_isAboutDescriptionUSB(d) then
			if item_checkOpenUSB() then
				return
			end
		end	
		itemFirstPressed[d] = false
		setUserSay(itemDescription[d])
		return
	end
	
	--不是最終狀態
	if itemStatus[d] ~= itemLast[d] then
		--clickMessage = "*** "..getSelectItems().." "..itemUsed[d]
		
		bIsMachSelectItems = false
		if itemUsed[d] ~= 0 then
			if type(itemUsed[d]) == "string" then
				--選對東西先刪除 items
				if getSelectItems() == itemUsed[d] then
					bIsMachSelectItems = true
					items_delete(getSelectItems())
				end
			elseif type(itemUsed[d]) == "table" then
				clickMessage = "#itemUsed[d]: " .. #itemUsed[d]
				for i=1,#itemUsed[d] do
					--選對東西先刪除 items
					if getSelectItems() == itemUsed[d][i] then
						if itemUsed[d][i] == "Items/13-1.png" then
							m_whoOpenVine = 1
							
						elseif itemUsed[d][i] == "Items/11-3-1-1.png" then
							m_whoOpenVine = 2
						end
						bIsMachSelectItems = true
						items_delete(getSelectItems())
					end
				end
			end
		end
		--選對拿取的 item or 直接可拿
		if bIsMachSelectItems or itemUsed[d] == 0 then
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
				--itemStatus[d] = -itemLast[d]
				branch_changBranch(itemMap1[d], itemMap2[d], itemMap3[d], itemChangBranchTo[d].to1, itemChangBranchTo[d].to2, itemChangBranchTo[d].to3)
			elseif itemLast[d] == 999 then
				if item_isAboutOpenUSB(d) then
					if item_checkOpenUSB() then
						return
					end
				end
				itemLast[d] = 998
			elseif itemLast[d] == 998 then
				return
			elseif itemLast[d] == 997 then
				return
			elseif itemLast[d] == 996 then
				return
			elseif itemLast[d] == 995 then
				return
			else
				itemStatus[d] = itemStatus[d] - 1
			end
			
			setUserSay(itemTalk[d])
			
			--眼睛 + 蝴蝶結
			if itemMap1[d] == 10 and itemMap2[d] == 2 and itemMap3[d] == 1 and itemStatus[d] == -2 and itemLast[d] == 998 then
				for i=1,#itemMap1 do
					if itemMap1[i] == 10 and itemMap2[i] == 2 and itemMap3[i] == 1 and itemStatus[i] == -1 and itemLast[i] == 998 then
						--items_add("Items/10-2-2-1.png")
						--items_add("Items/10-2-2-2.png")
						event2Ing = true
						event2Id = 1
						--setUserSay(itemTalk[d] .. "，並得到鑰匙和雕刻物 \"EC\"")
					end
				end
			--蝴蝶結 + 眼睛 
			elseif itemMap1[d] == 10 and itemMap2[d] == 2 and itemMap3[d] == 1 and itemStatus[d] == -1 and itemLast[d] == 998 then
				for i=1,#itemMap1 do
					if itemMap1[i] == 10 and itemMap2[i] == 2 and itemMap3[i] == 1 and itemStatus[i] == -2 and itemLast[i] == 998 then
						--items_add("Items/10-2-2-1.png")
						--items_add("Items/10-2-2-2.png")
						event2Ing = true
						event2Id = 1
						--setUserSay(itemTalk[d] .. "，並得到鑰匙和雕刻物 \"EC\"")
					end
				end
			--剪刀剪兔娃娃，顯示鑰匙 X
			elseif itemMap1[d] == 10 and itemMap2[d] == 2 and itemMap3[d] == 1 and itemStatus[d] == -3 and itemLast[d] == 998 then
				for i=1,#itemMap1 do
					if itemMap1[i] == 10 and itemMap2[i] == 2 and itemMap3[i] == 1 and itemStatus[i] == -4 and itemLast[i] == 997 then
						itemLast[i] = 0;
						event2Ing = true
						event2Id = 2
					end
				end
			--已開啟伊莉的隨身碟，可勾選隱藏項目
			elseif itemMap1[d] == 8 and itemMap2[d] == 1 and itemMap3[d] == 3 and itemStatus[d] == -14 and itemLast[d] == 998 then
				for i=1,#itemMap1 do
					if itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -1 and itemLast[i] == 995 then
						itemLast[i] = 999;
					end
				end
			--勾伊莉隨身碟的隱藏項目
			elseif itemMap1[d] == 8 and itemMap2[d] == 1 and itemMap3[d] == 3 and itemStatus[d] == -1 and itemLast[d] == 998 then
				for i=1,#itemMap1 do
					if itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -10 and itemLast[i] == 996 then
						itemLast[i] = 998;
					end
				end
			elseif itemMap1[d] == 2 and itemMap2[d] == 2 and itemMap3[d] == 1 and itemStatus[d] == 0 and itemLast[d] == 0 then
				for i=1,#itemMap1 do
					if itemMap1[i] == 2 and itemMap2[i] == 2 and itemMap3[i] == 1 and itemStatus[i] == -2 and itemLast[i] == 996 then
						itemLast[i] = 998;
					end
				end
			end
			item_usedUSB(d)	
		end
	end
	
	--for test
	--[[
	if item_IsPushALandCE() then
		clickMessage = "t"
	else
		clickMessage = "f"
	end
	--]]
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
		if item_isAboutOpenUSB(d) or item_isAboutDescriptionUSB(d) then
			if item_checkOpenUSB() then
				return
			end
		end	
		itemFirstPressed[d] = false
		setUserSay(itemDescription[d])
	end
end

function item_usedUSB(d)
	--插入愛洛的隨身碟
	if itemMap1[d] == 8 and itemMap2[d] == 1 and itemMap3[d] == 3 and itemStatus[d] == -2 and itemLast[d] == 998 then
		for i=1,#itemMap1 do
			--顯示愛洛的隨身碟
			if itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -8 and itemLast[i] == 996 then
				itemLast[i] = 998;
			end
			--可打開愛洛的隨身碟
			if itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -11 and itemLast[i] == 995 then
				itemLast[i] = 999;
				itemDescription[i] = "可查看愛洛的隨身碟"
				itemFirstPressed[i] = true
			end
		end
	--插入馬克的隨身碟
	elseif itemMap1[d] == 8 and itemMap2[d] == 1 and itemMap3[d] == 3 and itemStatus[d] == -3 and itemLast[d] == 998 then
		for i=1,#itemMap1 do
			--顯示馬克的隨身碟
			if itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -6 and itemLast[i] == 996 then
				itemLast[i] = 998;
			end
			--可打開馬克的隨身碟
			if itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -12 and itemLast[i] == 995 then
				itemLast[i] = 999;
				itemDescription[i] = "可查看馬克的隨身碟"
				itemFirstPressed[i] = true
			end
		end
	--插入麥斯的隨身碟
	elseif itemMap1[d] == 8 and itemMap2[d] == 1 and itemMap3[d] == 3 and itemStatus[d] == -4 and itemLast[d] == 998 then
		for i=1,#itemMap1 do
			--顯示麥斯的隨身碟
			if itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -7 and itemLast[i] == 996 then
				itemLast[i] = 998;
			end
			--可打開麥斯的隨身碟
			if itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -13 and itemLast[i] == 995 then
				itemLast[i] = 999;
				itemDescription[i] = "可查看麥斯的隨身碟"
				itemFirstPressed[i] = true
			end
		end
	--插入伊莉的隨身碟
	elseif itemMap1[d] == 8 and itemMap2[d] == 1 and itemMap3[d] == 3 and itemStatus[d] == -5 and itemLast[d] == 998 then
		for i=1,#itemMap1 do
			--顯示伊莉的隨身碟
			if itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -9 and itemLast[i] == 996 then
				itemLast[i] = 998;
			end
			--可打開伊莉的隨身碟
			if itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -14 and itemLast[i] == 995 then
				itemLast[i] = 999;
				itemDescription[i] = "可查看伊莉的隨身碟"
				itemFirstPressed[i] = true
			end
		end
	end
end

--檢查是否開啟資料夾
function item_checkOpenUSB()
	for i=1,#itemMap1 do
		--已開啟愛洛的隨身碟
		if itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -11 and itemLast[i] == 998 then
			return true
		--已開啟馬克的隨身碟
		elseif itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -12 and itemLast[i] == 998 then
			return true
		--已開啟麥斯的隨身碟
		elseif itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -13 and itemLast[i] == 998 then
			return true
		--已開啟伊莉的隨身碟
		elseif itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -14 and itemLast[i] == 998 then
			return true
		end
	end
	return false
end

function item_isAboutOpenUSB(d)
	--想開啟愛洛的隨身碟
	if itemMap1[d] == 8 and itemMap2[d] == 1 and itemMap3[d] == 3 and itemStatus[d] == -11 and itemLast[d] == 999 then
		return true
	--想開啟馬克的隨身碟
	elseif itemMap1[d] == 8 and itemMap2[d] == 1 and itemMap3[d] == 3 and itemStatus[d] == -12 and itemLast[d] == 999 then
		return true
	--想開啟麥斯的隨身碟
	elseif itemMap1[d] == 8 and itemMap2[d] == 1 and itemMap3[d] == 3 and itemStatus[d] == -13 and itemLast[d] == 999 then
		return true
	--想開啟伊莉的隨身碟
	elseif itemMap1[d] == 8 and itemMap2[d] == 1 and itemMap3[d] == 3 and itemStatus[d] == -14 and itemLast[d] == 999 then
		return true
	end
	
	return false
end

function item_isAboutDescriptionUSB(d)
	--想開啟愛洛的隨身碟
	if itemMap1[d] == 8 and itemMap2[d] == 1 and itemMap3[d] == 3 and itemStatus[d] == -11 and itemLast[d] == 995 then
		return true
	--想開啟馬克的隨身碟
	elseif itemMap1[d] == 8 and itemMap2[d] == 1 and itemMap3[d] == 3 and itemStatus[d] == -12 and itemLast[d] == 995 then
		return true
	--想開啟麥斯的隨身碟
	elseif itemMap1[d] == 8 and itemMap2[d] == 1 and itemMap3[d] == 3 and itemStatus[d] == -13 and itemLast[d] == 995 then
		return true
	--想開啟伊莉的隨身碟
	elseif itemMap1[d] == 8 and itemMap2[d] == 1 and itemMap3[d] == 3 and itemStatus[d] == -14 and itemLast[d] == 995 then
		return true
	end
	
	return false
end

function item_whoOpenVine()
	return m_whoOpenVine
end

function item_IsPushALandCE()
	local temp = 0
	for i=1,#itemMap1 do
		if itemMap1[i] == 10 and itemMap2[i] == 1 and itemMap3[i] == 6 and itemStatus[i] == -1 and itemLast[i] == 998 then
			temp = temp + 1
		elseif itemMap1[i] == 10 and itemMap2[i] == 1 and itemMap3[i] == 6 and itemStatus[i] == -2 and itemLast[i] == 998 then
			temp = temp + 1
		end
	end
	if temp == 2 then
		return true
	else
		return false
	end
end

function item_initialLockBranch()
	m_itemLockBranch[1] = {item={8,1,3,-11}, last = 998, branch={8,1,4}}
	m_itemLockBranch[2] = {item={8,1,3,-12}, last = 998, branch={8,1,6}}
	m_itemLockBranch[3] = {item={8,1,3,-13}, last = 998, branch={8,1,8}}
	m_itemLockBranch[4] = {item={8,1,3,-1}, last = 998, branch={8,1,9}}
end

function item_isLockBranch(b1, b2, b3)
	--clickMessage = b1..b2..b3.." "
	for i=1,#m_itemLockBranch do
		if m_itemLockBranch[i].branch[1] == b1 and m_itemLockBranch[i].branch[2] == b2 and m_itemLockBranch[i].branch[3] == b3 then
			--clickMessage = clickMessage .. "in1 "
			for j=1,#itemMap1 do
				if itemMap1[j] == m_itemLockBranch[i].item[1] and itemMap2[j] == m_itemLockBranch[i].item[2] 
						and itemMap3[j] == m_itemLockBranch[i].item[3] and itemStatus[j] == m_itemLockBranch[i].item[4] then
					--clickMessage = clickMessage .. "in2 " .. itemLast[j]
					if itemLast[j] == m_itemLockBranch[i].last then
						return false
					else
						return true
					end
				end
			end
		end
	end
end

function item_USBback()
	for i=1,#itemMap1 do
		--已開啟愛洛的隨身碟
		if itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -11 and itemLast[i] == 998 then
			itemLast[i] = 999
			USBread[1] = true
		--已開啟馬克的隨身碟
		elseif itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -12 and itemLast[i] == 998 then
			itemLast[i] = 999
			USBread[2] = true
		--已開啟麥斯的隨身碟
		elseif itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -13 and itemLast[i] == 998 then
			itemLast[i] = 999
			USBread[3] = true
		--已開啟伊莉的隨身碟
		elseif itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -14 and itemLast[i] == 998 then
			itemLast[i] = 999
			USBread[4] = true
			for j=1,#itemMap1 do
				if itemMap1[j] == 8 and itemMap2[j] == 1 and itemMap3[j] == 3 and itemStatus[j] == -1 and itemLast[j] == 998 then
					itemLast[j] = 995
				end
				if itemMap1[j] == 8 and itemMap2[j] == 1 and itemMap3[j] == 3 and itemStatus[j] == -10 and itemLast[j] == 998 then
					itemLast[j] = 996
				end
			end
		end
	end
end

function item_USBleave()
	for i=1,#itemMap1 do
		--已插入愛洛的隨身碟
		if itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -2 and itemLast[i] == 998 then
			itemLast[i] = 999
			items_add("Items/4-1-1-1.png")
		--已插入馬克的隨身碟
		elseif itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -3 and itemLast[i] == 998 then
			itemLast[i] = 999
			items_add("Items/5-3-1.png")
		--已插入麥斯的隨身碟
		elseif itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -4 and itemLast[i] == 998 then
			itemLast[i] = 999
			items_add("Items/6-2-1.png")
		--已插入伊莉的隨身碟
		elseif itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -5 and itemLast[i] == 998 then
			itemLast[i] = 999
			items_add("Items/11-3-3.png")
		elseif itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -6 then
			itemLast[i] = 996
		elseif itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -7 then
			itemLast[i] = 996
		elseif itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -8 then
			itemLast[i] = 996
		elseif itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -9 then
			itemLast[i] = 996
		elseif itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -11 then
			itemLast[i] = 995
			itemDescription[i] = "I 槽"
		elseif itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -12 then
			itemLast[i] = 995
			itemDescription[i] = "J 槽"
		elseif itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -13 then
			itemLast[i] = 995
			itemDescription[i] = "K 槽"
		elseif itemMap1[i] == 8 and itemMap2[i] == 1 and itemMap3[i] == 3 and itemStatus[i] == -14 then
			itemLast[i] = 995
			itemDescription[i] = "H 槽"
		end
	end
end
