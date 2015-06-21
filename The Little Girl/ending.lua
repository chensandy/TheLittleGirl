function ending_load()
	
	screendarkness = 1
	endingFont = love.graphics.newFont("Fonts/NotoSansCJKtc-Regular.otf", 20);
	love.graphics.setFont(endingFont);
	love.graphics.setBackgroundColor(0, 0, 0)
	endingText = {"　　　　　　　國立交通大學資訊工程學系",
				  "　　　　 數位娛樂與藝術專題——遊戲設計課程",
				  "　　　　　　　　 期末Ｐｒｏｊｅｃｔ",
				  "　",
				  "　",
				  "　",
				  "　",
				  "　",
				  "　　　　　　　　　　 製作團隊",
				  "　　　　　　　 程式設計：小光、阿水",
				  "　　　　　　　　  美術設計：微米",
				  "　　　　　　　　  劇情設計：小光",
				  "　",
				  "　",
				  "　",
				  "　",
				  "　",
				  "　　　　　　　　　　 遊戲音樂",
				  "　MENU：Secret Garden-Song from a Secret Garden",
				  "Ending：",
				  "　",
				  "　",
				  "　",
				  "　",
				  "　",
				  "　　　　　　　 謝謝你／妳下載本遊戲",
				  "　　　　　　　 並恭喜你／妳玩到結局",
				  "　",
				  "　",
				  "　"
				 }
	 
	endingColor = {}
	
	ebackground = {}
	
	printx = 140
	printy = 600
	dd = 0
	stop = false
	--music:stop()
	--musicrev:play()

end

function ending_update(dt)
	if screendarkness > 0 then
		screendarkness = math.max(0, screendarkness - dt)
	end
	
	if #endingText*50+printy > 450 then
		dd = dd+1;
		if(dd>10) then
			dd = dd-10
			printy = printy-1
		end
	else 
		stop = true
	end
	
end

function ending_draw()
	for i=1, #endingText do
		if printy+i*50 < 600 and printy+i*50 > -20 then
			love.graphics.setFont(endingFont);
			love.graphics.print(endingText[i], printx, printy+50*i)
		end
	end
	
	love.graphics.setColor(0, 0, 0, 255*screendarkness)
	love.graphics.rectangle("fill", 0, 0, 800, 600)
	love.graphics.setColor(255, 255, 255)
end

function ending_mousepressed(x, y, button)
	if stop and button=='l' then
		changegamestate("menu")
	end
end

