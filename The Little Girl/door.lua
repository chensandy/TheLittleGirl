door = class:new()

function door_load() --14
	doorMap = {1, 1, 1, 1,   --4
			   3, 3, 3, 3, 3, 3,  --6
			   8, 8, 8, --3
			   10, 10} --2
	doorId = {2, 4, 3, 1,
			  1, 2, 3, 4, 5, 6,
			  1, 2, 3,
			  1, 2}
--	doorLock = {1, 0, 1, 1,
--				0, 1, 1, 0, 1, 1,
--				0, 0, 1,
--				0, 0}
	doorLock = {0, 0, 0, 1,
				0, 0, 0, 0, 0, 0,
				0, 0, 0,
				0, 0}
	doorKey = {"Items/2-1-1.png", 0, "Items/5-1-1-1.png", -1,
			   0, "Items/4-2-1.png", 0, 0, "Items/9-1-1-1.png", 0,
			   0, 0, "Items/7-3-1.png",
			   0, 0}
	doorGo = {3, 2, 8, 0,
			  4, 5, 6, 1, 7, 13,
			  1, 9, 10,
			  8, 11}
	doorGoBranch = {1, 0, 1, 0,
					0, 0, 0, 0, 0, 0,
					0, 0, 2,
					2, 0}
	doorOpenTalk = {"使用鑰匙，門鎖被打開了", 0, "使用磁卡，電子門打開了", 0,
					0, "使用鑰匙，馬克教授的房門鎖開了", 0, 0, "利用項鍊機關中彈出的鑰匙，鎖開了", 0,
					0, 0, 0,
					0, 0}
	doorTalk = {"鎖著的，不知道是會通往哪裡的門", "", "一個不知道通往哪裡的電子門，旁邊有感應區塊，要怎麼進去呢", "我進來這裡的門，沒有任何能開啟的跡象，看來得從其他地方想辦法出去才行。",
				"", "鎖著的房門，上面寫著馬克教授", "鎖著的房門，上面寫著麥斯副教授", "", "鎖著的房門，上面寫著伊莉以及愛洛研究員", "鎖著的，打不開",
				"", "", "電子門，看來不能使用之前的磁卡開它",
				"", ""}
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
