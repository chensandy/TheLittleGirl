door = class:new()

function door_load() --15
	doorMap = {1, 1, 1, 1,   --4
			   3, 3, 3, 3, 3, 3,  --6
			   5,
			   6,
			   8, 8, 8, --3
			   10, 10, --2
			   11}
	doorId = {2, 4, 3, 1,
			  1, 2, 3, 4, 5, 7,
			  1,
			  1,
			  1, 2, 3,
			  1, 2,
			  1}
--[[
	doorLock = {1, 0, 1, 1,
				0, 1, 1, 0, 1, 1,
				1,
				0,--1,
				0, 0, 1,
				0, 0,
				1}
--]]
	doorLock = {0, 0, 0, 1,
				0, 0, 0, 0, 0, 0,
				0,
				0,
				0, 0, 0,
				0, 0,
				0}
--]]
	doorKey = {"Items/2-1-1.png", 0, "Items/5-1-1-1.png", -1,
			   0, "Items/4-2-1.png", "Items/10-1-4-1.png", 0, "Items/9-1-1-1.png", "Items/10-2-1-4.png",
			   "Items/9-2-5-1.png",
			   0,
			   0, 0, "Items/7-3-1.png",
			   0, 0,
			   "Items/10-2-2-2.png"}
	doorGo = {3, 2, 8, 0,
			  4, 5, 6, 1, 7, 13,
			  5,
			  6,
			  1, 9, 10,
			  8, 11,
			  11}
	doorGoBranch = {1, 0, 1, 0,
					0, 0, 0, 0, 0, 0,
					3,
					2,
					0, 0, 2,
					2, 0,
					3}
	doorOpenTalk = {"使用鑰匙，門鎖被打開了。", "", "使用磁卡，電子門打開了。", "",
					"", "使用鑰匙，馬克教授的門鎖開了。", "使用鑰匙，麥斯副教授的門鎖開了。", "", "利用項鍊機關中彈出的鑰匙，門鎖開了。", "使用鑰匙，門鎖被打開了。",
					"插入木棒後，好像撬開了什麼東西，抽屜打開了。",
					"",
					"", "", "使用磁卡，電子門打開了。",
					"", "",
					"把寶箱的鎖頭打開了。"}
	doorTalk = {"鎖著的，不知道是會通往哪裡的門。", "", "一個不知道通往哪裡的電子門，旁邊有感應區塊，要怎麼進去呢？", "我進來這裡的門，沒有任何能開啟的跡象，看來得從其他地方想辦法出去才行。",
				"", "鎖著的房門，上面寫著馬克教授。", "鎖著的房門，上面寫著麥斯副教授。", "", "鎖著的房門，上面寫著伊莉以及愛洛研究員。", "鎖著的，打不開。",
				"有一個洞。",
				"",
				"", "", "電子門，看來不能使用之前的磁卡開它。",
				"", "",
				"好大的寶箱啊，寶箱上有鎖頭打不開。"}
	doorOpenMusic = {"sounds/opendoor.mp3", "sounds/opendoor.mp3", "sounds/openDoor2.mp3", "sounds/opendoor.mp3",
					 "sounds/opendoor.mp3", "sounds/opendoor.mp3", "sounds/opendoor.mp3", "sounds/opendoor.mp3", "sounds/opendoor.mp3", "sounds/opendoor.mp3",
					 0,
					 "sounds/opendoor.mp3",
					 "sounds/openDoor2.mp3", "sounds/opendoor.mp3", "sounds/opendoor.mp3",
					 "sounds/opendoor.mp3", "sounds/opendoor.mp3",
					 0}
	doorUsedKeyMusic = {"sounds/keyOpenDoor.mp3", 0, "sounds/BB.mp3", 0,
						0, "sounds/keyOpenDoor.mp3", "sounds/keyOpenDoor.mp3", 0, "sounds/keyOpenDoor.mp3", "sounds/keyOpenDoor.mp3",
						"sounds/keyOpenDoor.mp3",
						0,--1,
						0, 0, "sounds/BB.mp3",
						0, 0,
						"sounds/keyOpenDoor.mp3"}
end
function door:init(m, id, l, k, go, b)
	self.lock = l
	self.map = m
	self.index = id
	self.key = k
	self.goto = {go, b, 0}
end

function door:islock()
	if self.lock == 1 then
		return true
	else
		return false
	end
end	

function door:open()
	self.lock = 0
end

function door:go()
	return self.goto
end
