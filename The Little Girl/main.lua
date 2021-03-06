function love.load()
	require "class"
	require "menu"
	require "items"
	require "game"
	require "door"
	require "branch"
	require "r_botton"
	require "t_botton"
	require "talk"
	require "item"
	require "event"
	require "event2"
	require "map"
	require "end"
	require "ending"
	require "openingstory"
	
	love.filesystem.setIdentity( "The Little Girl" )
	love.window.setTitle( "The Little Girl" )

	love.graphics.setLineWidth(1)
					
	love.window.setMode(800, 600, {resizable=false, vsync=false})
	
	--deck[i] = love.graphics.newImage("graphics/" .. i .. ".gif");
	
	love.window.setIcon(love.image.newImageData("graphics/icon4.png"))
	--musicrev = love.audio.newSource("sounds/musicrev.ogg");musicrev:setVolume(0.1);musicrev:setLooping(true)
	music = love.audio.newSource("sounds/SecretGarden.mp3");music:setVolume(0.3)music:setLooping(true)
	gmusic = love.audio.newSource("sounds/moon1.mp3");gmusic:setVolume(1)gmusic:setLooping(true)
	music2 = love.audio.newSource("sounds/Chiisana Tameiki.mp3");music2:setVolume(0.1);music2:setLooping(true)
	changegamestate("menu")
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