door = class:new()

function door_load() --14
	doorMap = {1, 1, 1, 1,   --4
			   3, 3, 3, 3, 3, 3,  --5
			   8, 8, 8, --3
			   10, 10} --2
	doorId = {2, 4, 3, 1,
			  1, 2, 3, 4, 5, 6,
			  1, 2, 3,
			  1, 2}
	doorLock = {0, 0, 0, 1,
				0, 0, 0, 0, 0, 0,
				0, 0, 0,
				0, 0}
	doorKey = {"Items/2-1-1.png", 0, "Items/5-1-1-1.png", -1,
			   0, "Items/4-2-1.png", 0, 0, 0, 0,
			   0, 0, 0,
			   0, 0}
	doorGo = {3, 2, 8, 0,
			  4, 5, 6, 1, 7, 13,
			  1, 9, 10,
			  8, 11}
	doorGoBranch = {1, 0, 1, 0,
					0, 0, 0, 0, 0, 0,
					0, 0, 2,
					2, 0}
	doorTalk = {"開啟通往走廊的門", 0, "使用磁卡，開啟通往實驗室的門", 0,
					0, "開啟馬克教授的門", 0, 0, 0, 0,
					0, 0, 0,
					0, 0}
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
