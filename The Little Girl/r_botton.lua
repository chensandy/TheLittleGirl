r_botton = class:new()

function r_botton_load()
	rMap = {1, 1, 1, 1, 1,   --5
			2, 2, 2,  --3
			   3, 3}  --5
	rId = {1, 2, 3, 4, 5,
		   1, 2, 3,
		   4, 5}
	rGo = {1, 1, 1, 1, 1,
		   1, 2, 2,
		   }
	rGoBranch = {1, 0, 0, 0, 0,
			     0, 0, 0,
				 1, 7}
	rGoBranch2 = {0, 0, 0, 0, 0,
				  0, 0, 0,
				  0, 0}
end
function r_botton:init(m, id, go, b, b2)
	self.map = m
	self.index = id
	self.goto = {go, b, b2}
end

function r_botton:go()
	return self.goto
end
