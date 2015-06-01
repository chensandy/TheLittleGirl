door = class:new()

function door_load()
	doorMap = {1, 1}
	doorId = {1, 2}
	doorLock = {0, 1}
	doorKey = {0, 101}
	doorGo = {2, 3}
	doorGoBranch = {0, 0}
end
function door:init(m, id, l, k, go, b)
	self.lock = l
	self.map = m
	self.index = id
	self.key = k
	self.goto = go
	self.gotob = b
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
