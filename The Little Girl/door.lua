door = class:new()

function door_load()
	doorMap = {1, 1, 1, 1,   --4
			   3, 3, 3, 3, 3}  --5
	doorId = {2, 4, 3, 1,
			  1, 2, 3, 4, 5}
	doorLock = {0, 0, 0, 1,
				0, 0, 0, 0, 0}
	doorKey = {202, 0, 501, -1,
			   0, 0, 0, 0, 0}
	doorGo = {3, 2, 8, 0,
			  4, 5, 6, 1, 7}
	doorGoBranch = {1, 0, 1, 0,
					0, 0, 0, 0, 0}
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
