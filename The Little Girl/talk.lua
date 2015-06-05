function talk_load()
	screendarkness = 1
	string_long = 48
	--user_say = "141324123412341234123412341234123412341234123412341234"
	--girl_say = "我是小女孩，ㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏ，ㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎ。"
	--user_say = "我是玩家，ㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏ，ㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎ。"
	--question = {"YES", "NO"}
	girl_say = ""
	user_say = ""
	question = ""
	
	girl_print_point = {x = 50, y = 120}
	user_print_point = {x = 50, y = 450}
	girl_dialog_point = {x = girl_print_point.x - 30, y = girl_print_point.y - 30}
	user_dialog_point = {x = user_print_point.x - 30, y = user_print_point.y - 30}

	selectQuestion = 0
end

function talk_update(dt)
	if screendarkness > 0 then
		screendarkness = math.max(0, screendarkness - dt/2)
	end
end

function talk_draw()
	if #girl_say > 0 then 
		girl_printf(string.sub(girl_say, 1, string_long))
	end
	
	if #user_say > 0 then 
		user_printf(string.sub(user_say, 1, string_long))
	end
	
	if #question > 0 then 
		question_printf()
	end
end

function talk_mousepressed(x, y, button)
	if #girl_say > 0 then 
		if #girl_say <= string_long then
			girl_say = ""
		else
			girl_say = string.sub(girl_say, string_long + 1)
		end
	end
	
	if #user_say > 0 then 
		if #user_say <= string_long then
			user_say = ""
		else
			user_say = string.sub(user_say, string_long + 1)
		end
	end
	
	if #question > 0 then 
		for i = 1, #question do
			if x > user_dialog_point.x and x < user_dialog_point.x + 700 
				and y > user_dialog_point.y - 45*#question + (i-1)*45 and y < user_dialog_point.y - 45*#question + (i-1)*45 + 40 then
				selectQuestion = i
				question = {}
			end
		end
	end
end

function girl_talk(say)
	girl_say = say
end

function user_talk(say)
	user_say = say
end

function ask_question(que)
	question = que
end

function girl_printf(say)
	local itemGraphics = love.graphics.newImage("graphics/dialog.png")		
	love.graphics.draw(itemGraphics, girl_dialog_point.x, girl_dialog_point.y, 0)
	
	local r, g, b, a = love.graphics.getColor( )
	love.graphics.setColor( 0, 0, 0)
	love.graphics.printf(say, girl_print_point.x, girl_print_point.y, 700, "left")
	love.graphics.setColor(r, g, b, a)
	
end

function user_printf(say)
	local itemGraphics = love.graphics.newImage("graphics/dialog.png")		
	love.graphics.draw(itemGraphics, user_dialog_point.x, user_dialog_point.y, 0)

	local r, g, b, a = love.graphics.getColor( )
	love.graphics.setColor( 0, 0, 0)
	love.graphics.printf(say, user_print_point.x, user_print_point.y, 700, "left")
	love.graphics.setColor(r, g, b, a)
end

function question_printf()
	for i = 1, #question do
		local r, g, b, a = love.graphics.getColor( )
		love.graphics.setColor( 0, 0, 200)
		love.graphics.rectangle( "fill", user_dialog_point.x, user_dialog_point.y - 45*#question + (i-1)*45, 700, 40 )
		love.graphics.setColor( 0, 200, 0)
		love.graphics.printf(question[i], user_dialog_point.x + 5, user_dialog_point.y - 45*#question + (i-1)*45, 700, "left")
		
		if selectQuestion == i then
			love.graphics.setColor( 255, 0, 0)
			
			local point1 = {x = user_dialog_point.x, y = user_dialog_point.y - 45*#question + (i-1)*45}
			local point2 = {x = user_dialog_point.x + 700, y = user_dialog_point.y - 45*#question + (i-1)*45}
			local point3 = {x = user_dialog_point.x + 700, y = user_dialog_point.y - 45*#question + (i-1)*45 + 40}
			local point4 = {x = user_dialog_point.x, y = user_dialog_point.y - 45*#question + (i-1)*45 + 40}
			
			love.graphics.line(point1.x, point1.y, point2.x, point2.y)
			love.graphics.line(point2.x, point2.y, point3.x, point3.y)
			love.graphics.line(point3.x, point3.y, point4.x, point4.y)
			love.graphics.line(point4.x, point4.y, point1.x, point1.y)
		end
		love.graphics.setColor(r, g, b, a)
	end
end

function talk_keypressed(key)
	if key == '8' then
		girl_talk("我是小女孩，ㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏ，ㄎㄎㄎㄎㄎㄎㄎㄎㄎ哈哈哈呵呵呵耶耶耶耶耶耶耶ㄝㄝㄝㄝㄝㄝㄝ。")
	elseif key == '9' then
		user_talk("我是玩家，ㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏㄏ，ㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎㄎ哈哈哈呵呵呵耶耶耶耶耶耶耶ㄝㄝㄝㄝㄎ。")
	elseif key == '0' then
		ask_question({"Yes", "No"})
	end
end
