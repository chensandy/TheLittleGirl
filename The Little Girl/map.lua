function map_load()
	Mcount = 1
	nowM = 0
	MapTalk = false
	mapId = {{2,0,0},{3,1,0},{4,0,0},{9,1,0},{9,2,0},
			 {10,2,0},{10,2,1},{11,0,0},{11,2,0},{7,1,0},
			 {8,1,3},{8,1,0},{9,2,1}}
	mapSayTurn = {{1,1}, {2,1},{2,2,1,2,1},{2,1},{1},
				  {1},{1,2,1,2,1,1},{1},{1,1},{1},
				  {2,1,2},{1},{1,1,2,1}}
	mapSay = {{"唯一沒鎖的門，看來通往的是一個像客廳的場所。", "據一個實驗中心的規模，正確地來說，這裡應該是個會客室。"},
			  {"嗚哇～門開了耶！好厲害～～呵呵～～", "小女孩好像在看戲似地笑著。"},
			  {"這裡是給客人住的客房喔～不過因為幾乎沒客人來，所以都拿來給馬克叔叔放雜物了～", "愛洛葛格和伊莉姊姊吵架的時候偶而也會來這裡睡覺喔！",
			   "感謝小女孩的介紹，不過　　　　　　　　　「如果可以告訴我怎麼出去那就更好了呢。」", "耶嘿，才不要～", "唉 =__="},
			  {"實驗室的叔叔還有哥哥姊姊死掉後，我就叫機器人幫他們在花園做成墓了，機器人的工藝很好吧！", "小女孩的聲音好像有點難過。"},
			  {"好漂亮的花園，看起來被維護得很好。"},{"看來是個客廳。看家具擺設，覺得其實這個實驗中心的主人還蠻風雅的。"},
			  {"有一隻有點殘缺的兔娃娃，當我拿起來端詳時","啊～～～這是我最喜歡的玩偶了，不過因為一點事情他都破破爛爛的了ＱＡＱ","小女孩激動的語氣讓我好像感覺得到某些表情符號。呃，就當作是錯覺好了。",
			   "之前讓機器人幫我補過...不過機器人的手根本沒辦法處理這麼精細的動作所以縫的爛爛的還找不到眼睛ＯＡＱＱ","都想像得到一個小女孩在地上打滾的樣子了。看來她真的很重視這隻兔娃娃吶！",
			   "感覺得到兔娃娃的肚子裡好像有什麼硬硬的東西，不過如果破壞這個娃娃的話小女孩應該會很生氣吧。"},
			  {"看起來是一個小女孩的房間，頗有粉系小公主的風格。"},
			  {"哇嗚，這孩子的娃娃也太多了吧。", "最大隻的熊被蝴蝶結勒的好痛苦的樣子。"},
			  {"小女孩說的故事書應該就是在這一排書櫃了，到底要念哪一本書呢？"},
			  {"想要開電腦看資料嗎？","我點了點頭，小女孩沉吟了一會。","好吧！我幫你開電腦～"},
			  {"電子門的另外一邊是一個實驗室，以前這裡在做著什麼實驗呢？"},
			  {"據我的推估以及了解，這個圍牆的外面就已經脫離這個實驗中心了。也就是說，這個門就是我夢寐以求的出口。","不過事情果然沒有想像中的簡單，這個門前攀爬的植物非常頑強，嘗試了一段時間，確定徒手是無法把它扳開的。 ＯＴＺ",
			   "唉唷～這樣手會受傷的啦！不要再試了～～","原來小女孩也會關心我嘛？"}
			 }
	mapFirst = {true, true, true, true, true, 
				true, true, true, true, true,
				true, true, true}
end

function map_update(dt)
	if MapTalk then
		if have_talk_or_question() == false then
			if mapSayTurn[nowM][Mcount] == 1 then
				setUserSay(mapSay[nowM][Mcount])
			else
				setGirlSay(mapSay[nowM][Mcount])
			end
			Mcount = Mcount+1
			if Mcount > #mapSay[nowM] then
				Mcount = 1
				MapTalk = false
				mapFirst[nowM] = false
			end
		end
	end
end