r_botton = class:new()

function r_botton_load() --39
	rMap = {1, 1, 1, 1, 1,   --5
			2, 2, 2,  --3
			3, 3, 3, 3, 3, 3, 3, 3, 3,  --9
			4, 4, 4, --3
			5, --1
			6, --1
			7, --1
			8, 8, 8, 8, 8, --5
			9, 9, 9, 9, 9, --5
			10, 10, 10, 10, 10, --5
			11} --1
	rId = {1, 2, 3, 4, 5,
		   1, 2, 3,
		   1, 2, 3, 4, 5, 6, 7, 8, 9,
		   1, 2, 3,
		   1,
		   1,
		   1,
		   1, 2, 3, 4, 5,
		   1, 2, 3, 4, 5, 
		   1, 2, 3, 4, 5,
		   1}
	rGo = {1, 1, 1, 1, 1,
		   1, 2, 2,
		   3, 3, 3, 3, 3, 3, 3, 3, 3,
		   3, 4, 4,
		   3,
		   3,
		   3,
		   8, 8, 8, 8, 8,
		   8, 9, 9, 9, 9,
		   10, 10, 10, 10, 10,
		   10}
	rGoBranch = {1, 0, 0, 0, 0,
			     0, 0, 0,
				 1, 1, 1, 1, 1, 2, 2, 2, 2,
				 1, 0, 1,
				 1,
				 1,
				 2,
				 2, 1, 1, 2, 2,
				 2, 0, 0, 1, 2,
				 2, 1, 1, 1, 2,
				 1}
	rGoBranch2 = {0, 0, 0, 0, 0,
				  0, 0, 0,
				  0, 0, 0, 0, 0, 0, 0, 0, 0,
				  0, 0, 0,
				  0,
				  0,
				  0,
				  0, 0, 0, 0, 0,
				  0, 0, 0, 0, 0,
				  0, 0, 0, 0, 0,
				  0}
end
function r_botton:init(m, id, go, b, b2)
	self.map = m
	self.index = id
	self.goto = {go, b, b2}
end

function r_botton:go()
	return self.goto
end