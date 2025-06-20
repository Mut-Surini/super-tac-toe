extends CanvasLayer

var playerActive
var turnIsActive = true
var skillActive

func _ready():
	playerActive = 1

func play(str):
	$Control/AnimatedSprite2D.play(str)

func _on_button_pressed():
	$Control/Button.visible = false
	$Control/Skills.visible = true
	$Control/desk.visible = true
	
	$Control/AnimatedSprite2D.visible = false
	$Control/tittle.text = "Rolling The Dice"
	rollDice()
	
	await get_tree().create_timer(4).timeout
	turnIsActive = false
	visible = false
	
func playTurn():
	visible = true
	$Control/Button.visible = true
	$Control/tittle.text = "Player " + str(playerActive) + " Turn"
	$Control/AnimatedSprite2D.play("player" + str(playerActive))
	$Control/Skills.visible = false
	$Control/desk.visible = false
	$Control/AnimatedSprite2D.visible = true
	
func rollDice():
	$Control/desk.text = "Rolling"
	var skill = await $Control/Skills.playAnimRandom(playerActive)
	
	if skill == "twice":
		$Control/desk.text = "You got another chance to put your piece again"
	elif skill == "permanently":
		$Control/desk.text = "Permanently your piece position and become indestructible (No Placement)"
	elif skill == "switch":
		$Control/desk.text = "Choose enemy piece position and switch it with your own piece (No Placement)"
	elif skill == "safezone":
		$Control/desk.text = "Choose an empty tile and forced the tile to become your own tile where only you can put a piece inside it (No Placement)"
	elif skill == "virus":
		$Control/desk.text = "Choose your own piece and infected 8 piece nearby and have a chance to switch it to your piece (No Placement)"
	elif skill == "blockade":
		$Control/desk.text = "Choose a tile and forced the tile to become uninhabitable"	
	elif skill == "trap":
		$Control/desk.text = "Choose a tile and place a invisble trap, if someone place their piece on that tile their piece and the trap are gone"	
	elif skill == "grenade":
		$Control/desk.text = "Choose an empty and explode the 8 tiles nearby have a chance to remove the piece from the tiles"	
	
	$Control/tittle.visible = true
	$Control/tittle.text = skill.to_upper()
	skillActive = skill
