branch = class:new()

function branch_load()
	branchMap = {1, 1, 1}
	branchId = {1, 2, 3}
	branchGoBranch1 = {2, 1, 3}
	branchGoBranch2 = {0, 0, 0}
end
function branch:init(m, id, b1, b2)
	self.map = m
	self.index = id
	self.goto = {m, b1, b2}
end

function branch:go()
	return self.goto
end
