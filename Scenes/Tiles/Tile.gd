extends Node2D

var occupied = false
var occupier

var chargeLevel:int = 1

func animateLabel():
	$Sprites/AnimationPlayer.stop(true)
	$Sprites/AnimationPlayer.play("Label_Animation")

func quake():
	$TilePlayer.stop(true)
	$TilePlayer.play("Quake",-1, 1.5)

func startSparks():
	var rs = int(rand_range(0.0,3.0)) + 1
	$Sprites/FX.frame = 0
	$Sprites/FX.play("Sparks " + str(rs))
	
	if chargeLevel > 0: 
		animateLabel()
		#quake()
	
	# pass to object on top
	if occupied:
		occupier.shock(chargeLevel)

# Called when the node enters the scene tree for the first time.
func _ready():
	var r = int(rand_range(0.0,3.0))
	$TilePlayer.stop(true)
	$TilePlayer.play("Opacity " + str(r),-1, rand_range(1.0, 1.5))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_FXTimer_timeout():
	startSparks()
	pass # Replace with function body.
