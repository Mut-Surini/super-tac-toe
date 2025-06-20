extends Node2D

@export var player : int
var isActive

func _ready():
	$AnimatedSprite2D.play("player" + str(player))
	$Label.text = "Player " + str(player)
	
func setScore(score):
	$Score.text = str(score)

func _process(delta):
	$Sprite2D2.visible = isActive
