function event2_load()
	nextEvent2 = 10
	count2 = 1

	event2Ing = false
	event2Id = 1
	
	event2 = {}
	event2[1] = {2,2,1,1,2,2,1}
	event2[2] = {2,1,2,1,2}
	event2talk = {}
	event2talk[1] = {"小兔！真的是原本小兔的眼睛！",
					 "蝴蝶結也在！你怎麼知道蝴...啊！是因為牆壁的畫嗎？",
					 "小女孩超級激動，好像很開心。",
					 "想像了一下一個小女孩幸福的抱著兔娃娃的樣子，我的嘴角也不經意地露出了一抹微笑。",
					 "我想要謝謝你！唔，等我一下！",
					 "好了，給你！",
					 "機器人送上了和之前相同款式的雕刻物以及一把鑰匙，總而言之先收下吧。"}
	event2talk[2] = {"呀！！！！！！！！！！！！！！　　　　　你做了什麼？！！？！！？！！！！",
					 "小女孩大聲尖叫，非常震驚且生氣。",
					 "為什麼？你怎麼可以這樣？",
					 "「......」",
					 "我不想再和你講話了。"
					}
end

function event2_update(dt)
	if event2Ing then
		if event2Id>0 then
			if event2Id==1 and count2==5 then
				moveMap(10,2,2)
			end
			if have_talk_or_question() == false and count2>0 then
				if event2[event2Id][count2] == 1 then
					setUserSay(event2talk[event2Id][count2])
				else
					setGirlSay(event2talk[event2Id][count2])
				end
				
				count2 = count2+1
				if count2 > #event2[event2Id] then
					count2 = #event2[event2Id]
					if event2Id==1 then
						items_add("Items/10-2-2-1.png")
						items_add("Items/10-2-2-2.png")
					end
					event2Ing = false
				end
				
			end
		end
	end
end

function event2_draw()
	if event2Ing and event2Id == 1 and count2>5 and count2<9 then
		--event2 = love.graphics.newImage("maps/map10-2-2.png");
		--love.graphics.draw(event2, 0, 0)
	end
end