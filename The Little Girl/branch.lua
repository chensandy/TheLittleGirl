branch = class:new()

function branch_load() --12
	branchMap = {1, 1, 1,   --3
				 2, 2,     --2
				 3, 3, 3, 3, 3, 3, 3, 3, 3} --9
	branchId = {2, 4, 6,
				2, 4,
				1, 2, 3, 4, 5, 6, 7, 8, 9}
	branchGoBranch1 = {2, 4, 3, 
					   2, 1,
					   1, 1, 1, 2, 2, 2, 2, 2, 1}
	branchGoBranch2 = {0, 0, 0,
					   0, 0,
					   1, 2, 3, 1, 2, 0, 3, 4, 4}
end
function branch:init(m, id, b1, b2)
	self.map = m
	self.index = id
	self.goto = {m, b1, b2}
end

function branch:go()
	return self.goto
end
