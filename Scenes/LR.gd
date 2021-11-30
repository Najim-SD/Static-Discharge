extends Node2D

var pushable = true

func shock(chargeLevel):
	$Sprites/FX.frame = 0
	$Sprites/FX.play("FX")
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func move(dir):
	var nv:Vector2 = moveVec(position, dir)
	$Sprites.position -= (nv - position)
	position = nv
	$AnimationPlayer.stop(true)
	$AnimationPlayer.play("Move " + dir,-1, 3.0)
	pass

func moveVec(v, dir):
	match dir:
		"right" :
			v.x += 32
			v.y -= 16
		"left" : 
			v.x -= 32
			v.y += 16
		"up" :
			v.x -= 32
			v.y -= 16
		"down" : 
			v.x += 32
			v.y += 16
	return v

func _on_Area2D_area_entered(area):
	if area.is_in_group("Tiles"):
		var tile = area.get_parent()
		tile.occupied = true
		tile.occupier = self
	elif area.is_in_group("SparkField"):
		$Sprites/FX.frame = 0
		$Sprites/FX.play("FX")
		
		$AnimationPlayer.stop(true)
		$AnimationPlayer.play("Arrest")
		$CanvasLayer/Line2D.points[0] = self.get_global_transform_with_canvas().origin + Vector2(0, -50)
		$CanvasLayer/Line2D.points[1] = area.get_parent().get_global_transform_with_canvas().origin + Vector2(0, -15)
		
		area.get_parent().chargeLevel = 0
		area.get_parent().setCL()
		get_tree().root.get_child(0).set_CL_Label(0)
	pass # Replace with function body.


func _on_Area2D_area_exited(area):
	if area.is_in_group("Tiles"):
		var tile = area.get_parent()
		tile.occupied = false
		tile.occupier = null
	pass # Replace with function body.
