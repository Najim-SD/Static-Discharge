extends Node2D

export var state = 0;
var pushable = false

func shock(chargeLevel):
	pass

func _ready():
	$AnimatedSprite.animation = str(state)
	pass # Replace with function body.

func step():
	state -= 1
	if state == -1: state = 2
	$AnimatedSprite.animation = str(state)
	pass

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
