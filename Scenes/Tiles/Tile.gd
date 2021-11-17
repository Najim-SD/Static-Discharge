extends Node2D

var occupied = false
var occupier

var chargeLevel:int = 1

func startSparks():
	var rs = int(rand_range(0.0,3.0)) + 1
	$FX.frame = 0
	$FX.play("Sparks " + str(rs))
	
	# pass to object on top
	if occupied:
		occupier.shock(chargeLevel)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_FXTimer_timeout():
	startSparks()
	pass # Replace with function body.
