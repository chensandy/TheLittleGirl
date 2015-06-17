branch = class:new()

function branch_load() --36
	branchMap = {1, 1, 1,   --3
				 2, 2,     --2
				 3, 3, 3, 3, 3, 3, 3, 3, 3, --9
				 4, 4, 4, 4, --4
				 5, 5,
				 7, 7, 7, 7, 7, --5
				 8, 8, 8, 8, 8, 8,--6
				 9, 9, 9, 9, 9, 9,--6
				 10, 10, 10, --3
				 11, 11} --2
	branchId = {2, 4, 6,
				2, 4,
				1, 2, 3, 4, 5, 6, 7, 8, 9,
				1, 2, 3, 4,
				1, 2,
				1, 2, 3, 4, 5,
				1, 2, 3, 4, 5, 6,
				1, 2, 3, 4, 5, 6,
				1, 2, 3,
				1, 2}
	branchGoBranch1 = {2, 4, 3, 
					   2, 1,
					   1, 1, 1, 2, 2, 2, 2, 2, 1,
					   1, 1, 1, 2,
					   1, 1,
					   1, 2, 2, 2, 3,
					   1, 1, 2, 1, 2, 1,
					   1, 2, 1, 2, 2, 2,
					   1, 1, 2,
					   1, 2}
	branchGoBranch2 = {0, 0, 0,
					   0, 0,
					   1, 2, 3, 1, 2, 0, 3, 4, 4,
					   0, 1, 1, 0,
					   0, 1,
					   0, 0, 1, 2, 0,
					   1, 2, 2, 0, 1, 3,
					   0, 0, 1, 1, 2, 3,
					   2, 1, 1,
					   0, 0}
end
function branch:init(m, id, b1, b2)
	self.map = m
	self.index = id
	self.goto = {m, b1, b2}
end

function branch:go()
	return self.goto
end

function branch_changBranch(m1, m2, m3, to1, to2 ,to3)
	for i=1,branchNum do
		local tmp = objects.branch[i]:go()
		if tmp[1] == m1 and tmp[2] == m2 and tmp[3] == m3 then
			tmp[1] = to1
			tmp[2] = to2
			tmp[3] = to3
			clickMessage = "*** needChangBranch to: " .. tmp[1] .. "," .. tmp[2] .. "," .. tmp[3]
			moveMap(tmp[1], tmp[2], tmp[3])
		end
	end
end
