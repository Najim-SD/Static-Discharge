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
	pass # Replace with function body.

func set_CL_Label(level:int):
	UI_Ref.find_node("Charge Level").text = ": " + str(level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Bot_step():
	set_CL_Label(Bot_Ref.chargeLevel)
	pass # Replace with function body.


func _on_Bot_reachedGoal():
	get_tree().reload_current_scene() # for now
	pass # Replace with function body.
