extends Node2D

export var levelName:String
export var levelNumber:String
export var nextLevelPath:String

var UI_Ref:CanvasLayer
var Bot_Ref

# Called when the node enters the scene tree for the first time.
func _ready():
	UI_Ref = $"Gameplay HUD"
	Bot_Ref = $YSort/Objects/Bot
	UI_Ref.find_node("Title").text = "#" + levelNumber + " - " + levelName
	$"Gameplay HUD/UI_Player".stop(true)
	$"Gameplay HUD/UI_Player".play("LevelIntro",-1, 0.8)
	pass # Replace with function body.

func set_CL_Label(level:int):
	UI_Ref.find_node("Charge Level").text = ": " + str(level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Bot_step():
	set_CL_Label(Bot_Ref.chargeLevel)
	#step the Spikes
	if $YSort.find_node("Spikes"):
		for spike in $YSort/Spikes.get_children():
			spike.step()
	pass # Replace with function body.

func _on_Bot_reachedGoal():
	$"Gameplay HUD/UI_Player".stop(true)
	$"Gameplay HUD/UI_Player".play("LevelOutro")
	pass # Replace with function body.


func _on_GlitchTimer_timeout():
	$"Gameplay HUD/Glitch".material.set_sh
	pass # Replace with function body.


func _on_UI_Player_animation_finished(anim_name):
	if anim_name == "LevelOutro":
		#get_tree().reload_current_scene()
		get_tree().change_scene(nextLevelPath)
		pass
	pass # Replace with function body.


func _on_Bot_CamFX():
	print("BotDeath FX")
	$MultiCam.shakeCam(30, Vector2(-5,5))
	$MultiCam.playFX("WhiteScreenFX")
	$"Gameplay HUD/Glitch".modulate.a = 1.0
	pass # Replace with function body.


func _on_LR_camfx2():
	$MultiCam.shakeCam(30, Vector2(-1,1))
	$MultiCam.playFX("BlackScreenFX")
	$"Gameplay HUD/UI_Player".stop(true)
	$"Gameplay HUD/UI_Player".play("Glitch")
	pass # Replace with function body.
