extends Node2D

var pushable = false

func shock(chargeLevel):
	$FX.play("FX")
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	if area.is_in_group("Tiles"):
		var tile = area.get_parent()
		tile.occupied = true
		tile.occupier = self
	pass # Replace with function body.


func _on_Area2D_area_exited(area):
	if area.is_in_group("Tiles"):
		var tile = area.get_parent()
		tile.occupied = false
		tile.occupier = null
	pass # Replace with function body.
