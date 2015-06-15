function map_load()
	count = 1
	nowM = 0
	MapTalk = false
	mapId = {{2,0,0}}
	mapSayTurn = {{1,1}}
	mapSay = {{"唯一沒鎖的門，看來通往的是一個像客廳的場所。", "據一個實驗中心的規模，正確地來說，這裡應該是個會客室。"}}
	mapFirst = {{true}}
end

function map_update(dt)
	if MapTalk then
		if have_talk_or_question() == false then
			if mapSayTurn[nowM][count] == 1 then
				setUserSay(mapSay[nowM][count])
			else
				setGirlSay(mapSay[nowM][count])
			end
			count = count+1
			if count > #mapSay[nowM] then
				count = 1
				MapTalk = false
				mapFirst[nowM] = false
			end
		end
	end
end