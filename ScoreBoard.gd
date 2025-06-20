extends CanvasLayer

var maksPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	maksPlayer = Global.maksPlayer
	for i in $Control.get_children():
		if i.player > maksPlayer:
			i.visible = false

func setActive(player):
	for i in $Control.get_children():
		if i.player == player:
			i.isActive = true
		else:
			i.isActive = false
			
func updateScore(score):
	var idents = $Control.get_children()
	for i in maksPlayer:
		idents[i].setScore(score[i])
