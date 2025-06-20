extends Node2D

func playAnim(str):
	$AnimatedSprite2D.play(str)

func playAnimRandom(player):
	var skills = ["Switch", "Permanently", "SafeZone", "Twice", "Virus", "Blockade", "Trap", "Grenade"]
	var skill
	var skillIcon
	
	for j in randi_range(15,20):
		skill = skills.pick_random().to_lower()
		#skill = "blockade"
		skillIcon = skill
		if skill != "blockade" and skill != "trap" and skill != "grenade":
			skillIcon = skill + str(player)
		$AnimatedSprite2D.play(skillIcon)
		$AudioStreamPlayer2D2.play()
		await get_tree().create_timer(0.1).timeout
		
	$AudioStreamPlayer2D.play()
	return skill
			
	
