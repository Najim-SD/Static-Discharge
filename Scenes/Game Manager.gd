extends Node2D

var UI_Ref:CanvasLayer
var Bot_Ref

# Called when the node enters the scene tree for the first time.
func _ready():
	UI_Ref = get_parent().find_node("UI Layer")
	Bot_Ref = get_parent().find_node("YSort").find_node("Objects").find_node("Bot")
	pass # Replace with function body.

func set_CL_Label(level:int):
	UI_Ref.find_node("Charge Level").text = "Charge Level : " + str(level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Bot_step():
	set_CL_Label(Bot_Ref.chargeLevel)
	pass # Replace with function body.
