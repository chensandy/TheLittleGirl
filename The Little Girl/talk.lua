function talk_load()
	screendarkness = 1
	m_stringLong = 48*3
	--m_userSay = "141324123412341234123412341234123412341234123412341234"
	--m_girlSay = "我是小女孩，ㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏ，ㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎ。"
	--m_userSay = "我是玩家，ㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏ，ㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎ。"
	--m_question = {"YES", "NO"}
	m_girlSay = ""
	m_userSay = ""
	m_question = ""
	
	m_girlPrintPoint = {x = 50, y = 120}
	m_userPrintPoint = {x = 50, y = 450}
	m_girlDialogPoint = {x = m_girlPrintPoint.x - 30, y = m_girlPrintPoint.y - 30}
	m_userDialogPoint = {x = m_userPrintPoint.x - 30, y = m_userPrintPoint.y - 30}

	m_selectmQuestion = 0
end

function talk_update(dt)
	if screendarkness > 0 then
		screendarkness = math.max(0, screendarkness - dt)
	end
end

function talk_draw()
	if #m_girlSay > 0 then 
		girl_printf(string.sub(m_girlSay, 1, m_stringLong))
	end
	
	if #m_userSay > 0 then 
		user_printf(string.sub(m_userSay, 1, m_stringLong))
	end
	
	if #m_question > 0 then 
		question_printf()
	end
end

function talk_mousepressed(x, y, button)
	if #m_girlSay > 0 then 
		if #m_girlSay <= m_stringLong then
			m_girlSay = ""
		else
			m_girlSay = string.sub(m_girlSay, m_stringLong + 1)
		end
	end
	
	if #m_userSay > 0 then 
		if #m_userSay <= m_stringLong then
			m_userSay = ""
		else
			m_userSay = string.sub(m_userSay, m_stringLong + 1)
		end
	end
	
	if #m_question > 0 then 
		for i = 1, #m_question do
			if x > m_userDialogPoint.x and x < m_userDialogPoint.x + 700 
				and y > m_userDialogPoint.y - 45*#m_question + (i-1)*45 and y < m_userDialogPoint.y - 45*#m_question + (i-1)*45 + 40 then
				m_selectmQuestion = i
				m_question = {}
			end
		end
	end
end

function setGirlSay(say)
	m_girlSay = say
end

function setUserSay(say)
	m_userSay = say
end

function setQuestion(que)
	m_selectmQuestion = 0
	m_question = que
end

function girl_printf(say)
	local itemGraphics = love.graphics.newImage("graphics/dialog.png")		
	love.graphics.draw(itemGraphics, m_girlDialogPoint.x, m_girlDialogPoint.y, 0)
	
	local r, g, b, a = love.graphics.getColor( )
	love.graphics.setColor( 0, 0, 0)
	love.graphics.printf(string.sub(say, 1, m_stringLong/3), m_girlPrintPoint.x, m_girlPrintPoint.y, 700, "left")
	love.graphics.printf(string.sub(say, m_stringLong/3 + 1, 2*m_stringLong/3), m_girlPrintPoint.x, m_girlPrintPoint.y + 40, 700, "left")
	love.graphics.printf(string.sub(say, 2*m_stringLong/3 + 1, m_stringLong), m_girlPrintPoint.x, m_girlPrintPoint.y + 80, 700, "left")
	love.graphics.setColor(r, g, b, a)
	
end

function user_printf(say)
	local itemGraphics = love.graphics.newImage("graphics/dialog.png")		
	love.graphics.draw(itemGraphics, m_userDialogPoint.x, m_userDialogPoint.y, 0)

	local r, g, b, a = love.graphics.getColor( )
	love.graphics.setColor( 0, 0, 0)
	love.graphics.printf(string.sub(say, 1, m_stringLong/3), m_userPrintPoint.x, m_userPrintPoint.y, 700, "left")
	love.graphics.printf(string.sub(say, m_stringLong/3 + 1, 2*m_stringLong/3), m_userPrintPoint.x, m_userPrintPoint.y + 40, 700, "left")
	love.graphics.printf(string.sub(say, 2*m_stringLong/3 + 1, m_stringLong), m_userPrintPoint.x, m_userPrintPoint.y + 80, 700, "left")
	love.graphics.setColor(r, g, b, a)
end

function question_printf()
	for i = 1, #m_question do
		local r, g, b, a = love.graphics.getColor( )
		love.graphics.setColor( 0, 0, 200)
		love.graphics.rectangle( "fill", m_userDialogPoint.x, m_userDialogPoint.y - 45*#m_question + (i-1)*45, 700, 40 )
		love.graphics.setColor( 0, 200, 0)
		love.graphics.printf(m_question[i], m_userDialogPoint.x + 5, m_userDialogPoint.y - 45*#m_question + (i-1)*45, 700, "left")
		--[[ for debug 
		if m_selectmQuestion == i then
			love.graphics.setColor( 255, 0, 0)
			
			local point1 = {x = m_userDialogPoint.x, y = m_userDialogPoint.y - 45*#m_question + (i-1)*45}
			local point2 = {x = m_userDialogPoint.x + 700, y = m_userDialogPoint.y - 45*#m_question + (i-1)*45}
			local point3 = {x = m_userDialogPoint.x + 700, y = m_userDialogPoint.y - 45*#m_question + (i-1)*45 + 40}
			local point4 = {x = m_userDialogPoint.x, y = m_userDialogPoint.y - 45*#m_question + (i-1)*45 + 40}
			
			love.graphics.line(point1.x, point1.y, point2.x, point2.y)
			love.graphics.line(point2.x, point2.y, point3.x, point3.y)
			love.graphics.line(point3.x, point3.y, point4.x, point4.y)
			love.graphics.line(point4.x, point4.y, point1.x, point1.y)
		end
		--]]
		love.graphics.setColor(r, g, b, a)
	end
end

function talk_keypressed(key)
	if key == '8' then
		setGirlSay("我是小女孩，ㄏㄏㄏㄏㄝㄝㄝㄝㄝ。")
	elseif key == '9' then
		setUserSay("我是玩家，ㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏ，ㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎ哈哈哈呵呵呵耶耶耶耶耶耶耶ㄝㄝㄝㄝㄎ。")
	elseif key == '0' then
		setQuestion({"Yes", "No"})
	end
end

function have_talk_or_question()
	if #m_girlSay > 0 or #m_userSay > 0 or #m_question > 0 then 
		return true
	else
		return false
	end
end