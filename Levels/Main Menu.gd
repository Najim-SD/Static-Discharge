extends CanvasLayer


func _ready():
	$UI_Player.play("Intro", -1, 0.5)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartBtn_pressed():
	get_tree().change_scene("res://Levels/Level 00.tscn")
	pass # Replace with function body.
