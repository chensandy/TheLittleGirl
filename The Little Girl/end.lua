function end_load()
	
	screendarkness = 1
	endFont = love.graphics.newFont("Fonts/NotoSansCJKtc-Regular.otf", 20);
	love.graphics.setFont(endFont);
	love.graphics.setBackgroundColor(0, 0, 0)
	trueEndText = {"打開密門，映入眼簾的是裝著女孩的培養槽",
				   "女孩閉著雙眼，頭髮隨著水流飄動",
				   "維生液體透出淡淡的螢光，剎那間我以為看到了天使",
				   false,
				   "「再看我就叫管家機器人把你戳瞎喔！」",
				   "從音響中傳來不同於小女孩ＡＩ的聲音，是愛莉斯嗎？",
				   "「主人一直都有透過我在看著喔～」音響中小女孩的聲音嘻嘻笑著",
				   "小女孩跟我說，愛洛研發的維生液的效果很好，確實改善了愛莉斯的體質",
				   "其實愛莉斯一直都可以出來，只是覺得被世界背叛的她，逃避現實不想醒來",
				   "就這樣僅憑意識和小女孩交流著持續了一年半",
				   false,
				   "「小女孩在這裡衷心感謝你所做的一切，雖然你也不是自願的，嘻」",
				   "「你透過在這個實驗中心的探索，了解了愛莉斯主人的一切」",
				   "「面對一個把自己關起來的討人厭ＡＩ，也還是幫忙修復她在意的娃娃」",
				   "「細心地推測，正向地思考」",
				   "「在最後也相信主人不是殺人兇手，回到這裡來找主人」",
				   "「真的很感謝你，給了我好久不曾體會的溫情，也給了我面對現實的動力」",
				   "愛莉斯的聲音感覺有點害羞",
				   false,
				   "「最後，請接受小女孩最後的請託，」",
				   "「也是麥斯主人的遺願」",
				   false,
				   "我帶著小女孩逃離了實驗中心",
				   "不意外地政府有派人在附近看守著",
				   "在裝載著小女孩ＡＩ的管家機器人的帶領之下",
				   "我們順利地抵達了安全的地方",
				   false,
				   "至於往後一起度過的生活，又是另一個故事了",
				   true
				  }
	trueEndTextColor = {{255,255,255},{255,255,255},{255,255,255},{},{255,185,200},
						{255,255,255},{255,245,80},{255,255,255},{255,255,255},{255,255,255},
						{},{255,245,80},{255,245,80},{255,245,80},{255,245,80},
						{255,245,80},{255,185,200},{255,255,255},{},{255,245,80},
						{255,245,80},{},{255,255,255},{255,255,255},{255,255,255},
						{255,255,255},{},{255,255,255},{},
	
						}
	--background = love.graphics.newImage("maps/map1.png");
	endStart = false
	textStart = 1
	endCount = 1
	letterCount = 0
	printx = 50
	printy = 160
	dd = 0;
	endToMenu = false
	--music:stop()
	--musicrev:play()
end

function end_update(dt)
	if screendarkness > 0 then
		screendarkness = math.max(0, screendarkness - dt/5)
	end
	
	if endStart then
		dd = dd+1;
		if(dd>100) then
			dd = dd-100
			letterCount = letterCount+3
		end
	end
end

function end_draw()
	if endStart then
		local c = letterCount
		for i=textStart, endCount do
			if trueEndText[i] == true then
				love.graphics.print("～ＴＲＵＥ　ＥＮＤ～", 100, 250)
				break
			end
			if trueEndText[i] == false then
				textStart = i+1
				letterCount = 0
				endCount = i+1
				break
			end
			love.graphics.setColor( trueEndTextColor[i][1], trueEndTextColor[i][2], trueEndTextColor[i][3])
			if i==endCount and c<#trueEndText[i] then
				local tmp = string.sub(trueEndText[i], 1, c)
				love.graphics.print(tmp, 100, 150+55*(i-textStart))
			elseif c>0 then
				love.graphics.print(trueEndText[i], 100, 150+55*(i-textStart))
			end
			--love.graphics.print(menuitems[i], 180, 150+55*(i-textStart))
		end
	end
	
	love.graphics.setColor(0, 0, 0, 255*screendarkness)
	love.graphics.rectangle("fill", 0, 0, 800, 600)
	love.graphics.setColor(255, 255, 255)
end

function end_mousepressed(x, y, button)
	if endStart and button=='l' then
		if endCount == #trueEndText then
			changegamestate("menu")
		elseif letterCount > #trueEndText[endCount] then
			endCount = endCount+1
			if endCount == #trueEndText then
				textStart = #trueEndText
				letterCount = 0
				endCount = #trueEndText
			end
			letterCount = 3
		else
			letterCount = #trueEndText[endCount]
		end
		if endCount == #trueEndText then
			endFont = love.graphics.newFont("Fonts/NotoSansCJKtc-Regular.otf", 60);
			love.graphics.setFont(endFont);
		end
	end
	if not endStart then
		if button=='l' then
			endStart = true
		end
	end

end

