extends AudioStreamPlayer

var musicPath = preload("res://Sound/bgMusic.ogg")
var musicLevel = preload("res://Sound/bgMusicLevel.ogg")

func playMusic():
	if stream == musicPath:
		return
		
	stream = musicPath
	play()
	
func playMusicLevel():
	if stream == musicLevel:
		return
		
	volume_db = -10
	stream = musicLevel
	play()
