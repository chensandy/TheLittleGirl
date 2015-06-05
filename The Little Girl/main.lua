function love.load()
	require "class"
	require "menu"
	require "items"
	require "game"
	require "door"
	require "branch"
	require "talk"
	
	love.filesystem.setIdentity( "The Little Girl" )
	

	love.graphics.setLineWidth(1)
					
	love.window.setMode(800, 600, {resizable=false, vsync=false})
	
	--deck[i] = love.graphics.newImage("graphics/" .. i .. ".gif");

	--love.window.setIcon(love.graphics.newImage("graphics/icon.gif"))
	
	changegamestate("menu")
	--local x = love.mouse.getX()
	--if x < 10 then
		changegamestate("game")
	--end
		
	
	gameover = false
end

function love.update(dt)
	if _G[gamestate .. "_update"] then
		_G[gamestate .. "_update"](dt)
	end
end

function love.draw()
	if _G[gamestate .. "_draw"] then
		_G[gamestate .. "_draw"]()
	end
end

function playsound(s)
	love.audio.stop(s)
	love.audio.play(s)
end

function love.mousepressed(x, y, button)
	if _G[gamestate .. "_mousepressed"] then
		_G[gamestate .. "_mousepressed"](x, y, button)
	end
end

function love.mousereleased(x, y, button)
    if _G[gamestate .. "_mousereleased"] then
		_G[gamestate .. "_mousereleased"](x, y, button)
	end
end

function love.keypressed(key, unicode)
    if _G[gamestate .. "_keypressed"] then
		_G[gamestate .. "_keypressed"](key, unicode)
	end
end

function changegamestate(s)
	gamestate = s
	if _G[gamestate .. "_load"] then
		_G[gamestate .. "_load"]()
	end
end