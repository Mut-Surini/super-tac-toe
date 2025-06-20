extends CanvasLayer

var victoryDetail = {}
var highScore = -1
var listWinner = []

func _ready():
	visible = false

func gameOver(gameScore):
	print(gameScore)
	var list = []
	for i in len(gameScore):
		if gameScore[i] > highScore:
			highScore = gameScore[i]
		victoryDetail["Player" + str(i)] = {
			player = "player" + str(i+1),
			score = gameScore[i]
		}
	
	for i in len(gameScore):
		if gameScore[i] == highScore:
			listWinner.append(i+1)
			list.append(victoryDetail["Player" + str(i)].player)
			
	$Control/listPlayer.text = "Player "	
		
	for i in len(listWinner):
		if i > 0:
			$Control/listPlayer.text += "'" + str(listWinner[i])
		else:
			$Control/listPlayer.text += str(listWinner[i])
	
	playRandomAnim(list)
			
	$Control/score.text = "Score : " + str(highScore)
	$AudioStreamPlayer2D.play()

func _on_confirm_pressed():
	visible = false
	get_tree().quit()

func playRandomAnim(list):
	$Control/AnimatedSprite2D.play(list.pick_random())
	$Control/AnimatedSprite2D2.play(list.pick_random())
	await get_tree().create_timer(0.5).timeout
	playRandomAnim(list)
