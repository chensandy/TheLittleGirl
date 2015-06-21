function openingstory_load()

	openingFont = love.graphics.newFont("Fonts/NotoSansCJKtc-Regular.otf", 20);
	love.graphics.setFont(openingFont);
	love.graphics.setBackgroundColor(0, 0, 0)
	love.graphics.setColor(255, 255, 255)
	
	openingText = {"———這是一個小女孩的故事",
				   "我是一個被政府雇用的賞金獵人",
				   "來到了一個據說是某祕密實驗中心的地方",
				   "任務是找出實驗中心裡的重要資料",
				   false,
				   "沒想到我一踏進實驗中心的建築物中",
				   "背後的門立刻就發出電子鎖的嗶聲———我出不去了",
				   "隨之而來的是利用建築物中隨處可見的廣播器材發出的小女孩的笑聲",
				   "？？？：「呵呵，他們怎麼還是不放棄呢？又派人來陪我玩啦？」",
				   "我：「是誰？」",
				   "？？？：「我是管理整個實驗中心的ＡＩ唷！代碼是『小女孩』。」",
				   false,
				   "「我的主人也是個可愛的小女孩喔！」",
				   "「不過自從實驗中心的人全部死光後，主人也把自己和我同化了。」",
				   "「你也是來這裡尋寶的吧？我一個人好無聊～才不會放你出去～」",
				   "「他們久久就會派一個人過來陪我玩喔～」",
				   "「像你這樣傻傻被騙來的人之前也有好多個喔～不過現在也都不在了。」",
				   "「呵呵，你想去哪裡就去哪裡吧！只要你到得了的話～」",
				   "「我最喜歡觀察人類苦惱的樣子了，才不會給你提示呢！」",
				   false,
				   "總之",
				   "有一個自稱是小女孩的ＡＩ為了娛樂而把我關了起來",
				   "看來我只好自己想辦法尋找出去的路了",
				   "（按一下滑鼠左鍵開始遊戲）"
				  }

	
	textStart = 1
	endCount = 1
	letterCount = 0
	printx = 80
	printy = 120
	dd = 0;
	ddd = 0
	music:stop()
	gmusic:stop()
	hint = false
	--musicrev:play()
end

function openingstory_update(dt)
	dd = dd+1;
	if(dd>150) then
		dd = dd-150
		letterCount = letterCount+3
	end
	ddd = ddd+1;
	if(ddd>500) then
		ddd = ddd-500
		hint = not hint
	end
end

function openingstory_draw()
	if endCount < #openingText and hint then
		love.graphics.setColor(185, 230, 240)
		love.graphics.print("（滑鼠左鍵繼續劇情，滑鼠右鍵直接進入遊戲）", 380, 560)
	end
	if endCount < #openingText+1 then
		love.graphics.setColor(255, 255, 255)
		local c = letterCount
		for i=textStart, endCount do
			if openingText[i] == false then
				textStart = i+1
				letterCount = 0
				endCount = i+1
				break
			end
			--love.graphics.setColor( EndTextColor[endId][i][1], EndTextColor[endId][i][2], EndTextColor[endId][i][3])
			if i==endCount and c<#openingText[i] then
				local tmp = string.sub(openingText[i], 1, c)
				love.graphics.print(tmp, printx, printy+50*(i-textStart))
			elseif c>0 then
				love.graphics.print(openingText[i], printx, printy+50*(i-textStart))
			end
		end
	end
end

function openingstory_mousepressed(x, y, button)
	if button=='l' then
		if endCount == #openingText and letterCount>#openingText[#openingText]then
			changegamestate("game")
		elseif letterCount > #openingText[endCount] then
			endCount = endCount+1
			if endCount == #openingText then
				textStart = #openingText
				letterCount = 0
				endCount = #openingText
			end
			letterCount = 3
		else
			letterCount = #openingText[endCount]
		end
	end
	if button=='r' then
		changegamestate("game")
	end
end

