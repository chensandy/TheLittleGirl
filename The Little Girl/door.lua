door = class:new()

function door_load()
	doorMap = {1, 1, 1}
	doorId = {2, 1, 3}
	doorLock = {1, 0, 1}
	doorKey = {202, 0, 501}
	doorGo = {3, 2, 8}
	doorGoBranch = {1, 0, 0}
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
