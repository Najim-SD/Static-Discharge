extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func startSparks():
	var rs = int(rand_range(0.0,3.0)) + 1
	$FX.frame = 0
	$FX.play("Sparks " + str(rs))

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_FXTimer_timeout():
	startSparks()
	pass # Replace with function body.
