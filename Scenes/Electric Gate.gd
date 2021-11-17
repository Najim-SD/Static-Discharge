extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var pushable = false

func shock(chargeLevel):
	if $AnimatedSprite.animation != "Lowered":
		if chargeLevel >= 2 and chargeLevel <= 4:
			$AnimatedSprite.play("Lowered")
		elif chargeLevel > 4:
			$AnimatedSprite.frame = 0
			$AnimatedSprite.play("Disrupted")
	pass

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
