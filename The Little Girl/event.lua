function event_load()
	nowEvent = 0
	nextEvent = 0
	count = 0
	clickEvent1Item = false
	EventItemID = 0
	Fmap7 = true
	event1Ing = false
	event1 = {}
	event1[1] = {1,1,1,2,1,2,1,2}
	event1[2] = {1,1,1,1,1,1,1,2,2,2,2,2,1}
	event1[3] = {1,1,2,1}
	event1[4] = {1,1,1}
	event1[5] = {1,1,2,1,1,1}
	event1talk = {}
	event1talk[1] = {"......",
				  "也探索不少地方了，帶來的糧食也吃光又過了一天了，唉。",
				  "肚子發出了\"咕~\"的叫聲，難道我真的要被餓死在這裡了嗎？",
				  "糧食吃完，肚子餓了嗎？",
				  "真是觀察敏銳的小女孩",
				  "旁邊的書櫃有一堆伊莉姊姊常念給我的故事喔～念我最喜歡的故事給我聽，我就送東西給你吃！",
				  "「？！」",
				  "只有一次機會喔！選錯故事就會像之前的哥哥姊姊們被餓死在這裡了～"}
	event1talk[2] = {"「我要念囉，書名：凱莉的小兔」",
				  "「凱莉有一隻很可愛的小兔子，凱莉非常地喜歡牠，有一天，因為家庭因素，凱莉要和媽媽出國，和小兔分開三年，因為凱莉很想小兔，所以爸爸每隔一段時間就會寄小兔的照片給凱莉。」",
				  "「但是凱莉出國不久，小兔因為生病死掉了。爸爸怕凱莉難過，去找了一隻和小兔長得很像的另一隻小兔作為替代小兔，繼續拍替代小兔的照片給凱莉，起初凱莉覺得小兔的毛色不太對，媽媽安慰說可能是換了相機、光線的關係、耳朵的斑紋不一樣，媽媽說可能是拍攝角度的關係。」",
				  "「久而久之，凱莉也習慣了替代小兔的照片，不再想起這和最初看到的小兔好像不同的事情。三年後，凱莉回家看到了替代小兔，也覺得她就是原本的小兔，雖然小兔對自己的態度不一樣了，但是凱莉過了三年也長的不一樣啦，所以小兔不認識凱莉也是正常的吧！」",
				  "「凱莉不知道自己幫替代小兔找了藉口。」",
				  "「從此，替代小兔就取代了凱莉心理一直鍾愛的小兔的位子。~END~」",
				  "這什麼怪故事=__=",
				  "我覺得這個故事很有趣啊！",
				  "我每次聽的時候都會想很多事，　　例如，所以替代小兔成為小兔，那原本的小兔是什麼呢？",
				  "明明是替代小兔，但是卻被當成小兔，那替代小兔會覺得自己還是自己嗎？",
				  "如果最後小女孩發現替代小兔不是小兔，那會發生什麼事呢？就像麥...不，沒什麼。",
				  "欺瞞、盲目、安於現狀～～～～　　好多的人性在這故事裡面呢。",
				  "......想的真多啊你不還是個小女孩嗎？然後那個麥是什麼意思？　　　　唉，問了他也不會回答我吧。"}
	event1talk[3] = {"「我要念囉，書名：愛麗絲夢遊仙境」",
				  "「從前從前......」",
				  "唔...雖然不是正解，但是算你過關好了＝３＝",
				  "小女孩埋怨了一下，不過還是讓我過關了。"}
	event1talk[4] = {"看到管家機器人送來的餐點，天啊我都快哭了......",
				  "接下來每到三餐時間，小女孩都會吩咐機器人送東西給我吃，看來只要小女孩心情是好的，我再來是沒有餓死的疑慮的",
				  "唔，這個雕刻物不知道是用來做什麼的，先收起來好了"}
				  
	event1talk[5] ={"「我要念囉」",
				  "「從前從前......」",
				  "噗噗～答錯了～請你餓死在這邊吧！",
				  "嗚！肚子好餓...",
				  "啊啊，突然眼前一片黑...(我使掉惹)",
				  "ＧＡＭＥ　ＯＶＥＲ"} 		  
end

function event_update(dt)
	if event1Ing then
		if nowEvent>0 then
			if nowEvent == 4 then
				moveMap(7,1,2)
				nextEvent = 10
			end
			if have_talk_or_question() == false then
				if event1[nowEvent][count] == 1 then
					setUserSay(event1talk[nowEvent][count])
				else
					setGirlSay(event1talk[nowEvent][count])
				end
				count = count+1
				if count > #event1[nowEvent] then
					nowEvent = nextEvent
					nextEvent = 0
					count = 1
				end
			end
		end
		if nowEvent == -1 then
			gameover = true
		elseif nowEvent == 10 then
			event1Ing = false
			nowEvent = 0
			nextEvent = 0
			count = 0
		end
		
		if clickEvent1Item then
			if #m_question ==0 and m_selectmQuestion == 1 then
				if EventItemID == 1 then
					nowEvent = 2
					nextEvent = 4
				elseif EventItemID == 2 then
					nowEvent = 3
					nextEvent = 4
				elseif EventItemID == 3 then
					nowEvent = 5
					nextEvent = -1
				end
				clickEvent1Item = false
				EventItemID = 0
			elseif #m_question ==0 and m_selectmQuestion == 2 then
				setGirlSay("咦～～～～～～不念嗎不念嗎不念嗎不念嗎不念嗎不念嗎")
				m_selectmQuestion = 0
			end
			
		end
	end
end

function doEvent1()
	event1Ing = true
	nowEvent = 1
	count = 1
end

function clickEventI(id)
	if event1Ing and id<=3 then
		clickEvent1Item = true
		EventItemID = id
		setQuestion({"就決定念這本書了", "還是算了"})
	else
		setUserSay("好像沒什麼特別的。")
	end
end

function event_draw()
	if event1Ing and nowEvent == 4 and count < 4 then
		event = love.graphics.newImage("maps/map7-1-1.png");
		love.graphics.draw(event, 0, 0)
	end
end