extends Node2D

var gridSize = 2
var player = 1
var maksPlayer = 0

var inGameSet : Dictionary
var playerScore = [0,0,0,0,0,0]

var skillActive
var skills = ["Switch", "Permanently", "SafeZone", "Twice", "Virus", "Blockade", "Trap", "Grenade"]

func setTile():
	for x in gridSize:
		for y in gridSize:
			$TileMap.set_cell(0,Vector2i(x,y),0,Vector2i(0,0))
			inGameSet[str(Vector2(x,y))] = {
				player = 0,
				status = ""
			}
			
func checkTile():
	var totalLeft = gridSize*gridSize
	for x in gridSize:
		for y in gridSize:
			if inGameSet[str(Vector2(x,y))].player != 0 or inGameSet[str(Vector2(x,y))].status == "Blockade" or inGameSet[str(Vector2(x,y))].status == "Safe1" or inGameSet[str(Vector2(x,y))].status == "Safe2" or inGameSet[str(Vector2(x,y))].status == "Safe3" or inGameSet[str(Vector2(x,y))].status == "Safe4" or inGameSet[str(Vector2(x,y))].status == "Safe5" or inGameSet[str(Vector2(x,y))].status == "Safe6":
				totalLeft -= 1
				
	return totalLeft
			
func setScore(score,player):
	if score == 3:
		playerScore[player-1] += 1
	elif score == 4:
		playerScore[player-1] += 2
	elif score >= 5:
		playerScore[player-1] += 4
			
func checkPoint():
	for x in gridSize:
		for y in gridSize:
			var savedX = x
			var savedY = y
			var playerIdentity = inGameSet[str(Vector2(x,y))].player
			var straight = 1
			
			if playerIdentity == 0:
				continue
			
			x += 1
			while (x >= 0 and x < gridSize):
				if inGameSet[str(Vector2(x,y))].player != playerIdentity:
					break
				else:
					straight += 1
					x += 1
			setScore(straight,playerIdentity)
			x = savedX
			straight = 1
			
			x -= 1
			while (x >= 0 and x < gridSize):
				if inGameSet[str(Vector2(x,y))].player != playerIdentity:
					break
				else:
					straight += 1
					x -= 1
			setScore(straight,playerIdentity)
			x = savedX
			straight = 1
			
			y += 1
			while (y >= 0 and y < gridSize):
				if inGameSet[str(Vector2(x,y))].player != playerIdentity:
					break
				else:
					straight += 1
					y += 1
			setScore(straight,playerIdentity)
			y = savedY
			straight = 1
			
			y -= 1
			while (y >= 0 and y < gridSize):
				if inGameSet[str(Vector2(x,y))].player != playerIdentity:
					break
				else:
					straight += 1
					y -= 1
			setScore(straight,playerIdentity)
			y = savedY
			straight = 1
			
			y += 1
			x += 1
			while (y >= 0 and y < gridSize) and (x >= 0 and x < gridSize):
				if inGameSet[str(Vector2(x,y))].player != playerIdentity:
					break
				else:
					straight += 1
					x += 1
					y += 1
			setScore(straight,playerIdentity)
			x = savedX
			y = savedY
			straight = 1
			
			y -= 1
			x -= 1
			while (y >= 0 and y < gridSize) and (x >= 0 and x < gridSize):
				if inGameSet[str(Vector2(x,y))].player != playerIdentity:
					break
				else:
					straight += 1
					x -= 1
					y -= 1
			setScore(straight,playerIdentity)
			x = savedX
			y = savedY
			straight = 1
			
			y += 1
			x -= 1
			while (y >= 0 and y < gridSize) and (x >= 0 and x < gridSize):
				if inGameSet[str(Vector2(x,y))].player != playerIdentity:
					break
				else:
					straight += 1
					x -= 1
					y += 1
			setScore(straight,playerIdentity)
			x = savedX
			y = savedY
			straight = 1
			
			y -= 1
			x += 1
			while (y >= 0 and y < gridSize) and (x >= 0 and x < gridSize):
				if inGameSet[str(Vector2(x,y))].player != playerIdentity:
					break
				else:
					straight += 1
					x += 1
					y -= 1
			setScore(straight,playerIdentity)
			x = savedX
			y = savedY
			straight = 1

func _ready():
	maksPlayer = Global.maksPlayer
	gridSize = Global.area
	setTile()
	checkPoint()
	$CanvasLayer.playerActive = 1
	$CanvasLayer.playTurn()
	$CanvasLayer2.setActive(player)

func _input(event):
	skillActive = $CanvasLayer.skillActive
	if event.is_action_pressed("place"):
		var tile = $TileMap.local_to_map(get_global_mouse_position())
		if (tile.x >= 0 and tile.x < gridSize) and (tile.y >= 0 and tile.y < gridSize) and !$CanvasLayer.turnIsActive:
			if skillActive != "switch" and skillActive != "virus" and skillActive != "permanently":
				if inGameSet[str(tile)].player !=  0:
					return
			
			if skillActive == "virus" and inGameSet[str(tile)].player != 0:
				if inGameSet[str(tile)].player != player:
					return
				$sound/virus.play()
				if inGameSet[str(tile)].player == player:
					var x = -1
					var y = -1
					while x <= 1:
						while y <= 1:
							if (tile.x+x >= 0 and tile.x+x < gridSize) and (tile.y+y >= 0 and tile.y+y < gridSize):
								if inGameSet[str(Vector2(tile.x+x,tile.y+y))].player != 0 and inGameSet[str(Vector2(tile.x+x,tile.y+y))].status != "Permanent":
									if randi_range(1,4) == 1:
										inGameSet[str(Vector2(tile.x+x,tile.y+y))] = {
											player = player,
											status = ""
										}
										$TileMap.set_cell(1,Vector2(tile.x+x,tile.y+y),0,Vector2i(player,0))
							y += 1
						x += 1
						y = -1
			elif skillActive == "grenade" and inGameSet[str(tile)].player == 0:
				$sound/grenade.play()
				$TileMap.set_cell(2,tile,0,Vector2i(7,2))
				var x = -1
				var y = -1
				while x <= 1:
					while y <= 1:
						if (tile.x+x >= 0 and tile.x+x < gridSize) and (tile.y+y >= 0 and tile.y+y < gridSize):
							if inGameSet[str(Vector2(tile.x+x,tile.y+y))].player != 0 and inGameSet[str(Vector2(tile.x+x,tile.y+y))].status != "Permanent":
								if randi_range(1,4) == 1:
									inGameSet[str(Vector2(tile.x+x,tile.y+y))] = {
										player = 0,
										status = ""
									}
									$TileMap.erase_cell(1,Vector2(tile.x+x,tile.y+y))
						y += 1
					x += 1
					y = -1
				
				await get_tree().create_timer(0.5).timeout
				$TileMap.erase_cell(2,tile)
			elif skillActive == "permanently" and inGameSet[str(tile)].player != 0:
				if inGameSet[str(tile)].player != player or inGameSet[str(tile)].status == "Trap" or  inGameSet[str(tile)].status == "Blockade":
						return
				if inGameSet[str(tile)].player == player:
					inGameSet[str(tile)] = {
						player = player,
						status = "Permanent"
					}
					$TileMap.set_cell(2,tile,0,Vector2i(player,1))
			elif skillActive == "blockade" and inGameSet[str(tile)].player == 0:
				if inGameSet[str(tile)].status == "Blockade":
					return
				inGameSet[str(tile)] = {
						player = 0,
						status = "Blockade"
					}
				$TileMap.set_cell(1,tile,0,Vector2i(7,1))
				$sound/blockade.play()
			elif skillActive == "trap" and inGameSet[str(tile)].player == 0:
				if inGameSet[str(tile)].status == "Blockade":
					return
				inGameSet[str(tile)] = {
						player = 0,
						status = "Trap"
					}
				$sound/place.play()
			else:
				if inGameSet[str(tile)].status == "Permanent" or inGameSet[str(tile)].status == "Blockade":
					return
				if skillActive == "safezone" and inGameSet[str(tile)].status != "Safe" + str(player) and inGameSet[str(tile)].player == 0:
					inGameSet[str(tile)] = {
						player = 0,
						status = "Safe" + str(player)
					}
					$TileMap.set_cell(0,tile,0,Vector2i(player,2))
					$sound/safeZone.play()
				else:
					if inGameSet[str(tile)].status != "Safe" + str(player) or inGameSet[str(tile)].status == "Blockade":
						if inGameSet[str(tile)].status != "" and inGameSet[str(tile)].status != "Trap":
							return
					
					if inGameSet[str(tile)].status == "Trap":
						$TileMap.set_cell(1,tile,0,Vector2i(player,0))
						$sound/trap.play()
						await get_tree().create_timer(0.5).timeout
						$TileMap.erase_cell(1,tile)
						inGameSet[str(tile)] = {
							player = 0,
							status = ""
						}
					else:
						inGameSet[str(tile)] = {
							player = player,
							status = ""
						}
						$TileMap.set_cell(1,tile,0,Vector2i(player,0))
						$sound/place.play()
						
			
			if skillActive != "twice":
				if player < maksPlayer:
					player += 1
				else:
					player = 1
				$CanvasLayer.turnIsActive = true
				
			$CanvasLayer.playerActive = player
					
			playerScore = [0,0,0,0,0,0]	
			checkPoint()
			$CanvasLayer2.updateScore(playerScore)
				
			if checkTile() < 2:
				var legalPlayer = []
				for i in len(playerScore):
					if i < maksPlayer:
						legalPlayer.append(playerScore[i])
				$victoryPanel.visible = true
				$victoryPanel.gameOver(legalPlayer)
				return
			
			if skillActive != "twice":
				await  get_tree().create_timer(1).timeout
				$CanvasLayer2.setActive(player)
				$CanvasLayer.playTurn()
				
			$CanvasLayer.skillActive = ""

			
