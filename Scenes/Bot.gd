extends Node2D

signal step
var Hovering = false

var chargeLevel:int = 0
var currentTile

var AntennaPos:Dictionary = {
	"up":Vector2(12, -30),
	"down":Vector2(-16, -44),
	"left":Vector2(12, -44),
	"right":Vector2(-16, -30)}

func _ready():
	pass #_ready()


func _process(delta):
	if justPressed("discharge"):
		$Sprites/Antenna.frame = 0
		$Sprites/Antenna.animation = "Discharging"
		#BotError()
	if justPressed("up"):
		moveBot("up")
	elif justPressed("down"):
		moveBot("down")
	elif justPressed("right"):
		moveBot("right")
	elif justPressed("left"):
		moveBot("left")
	
	
	pass #_process()

func BotError():
	$AnimationPlayer.stop(true)
	$AnimationPlayer.play("Bot_Error",-1, 2.0)

func moveBot(dir):
	$Sprites/Body.animation = dir
	$Sprites/Antenna.position = AntennaPos[dir]
	
	$RayCast2D.cast_to = moveVec(Vector2.ZERO, dir)
	$RayCast2D.force_raycast_update()
	var collider:Area2D = $RayCast2D.get_collider()
	if collider != null:
		if collider.is_in_group("Tiles"):
			var nv:Vector2 = moveVec(position, dir)
			$Sprites.position -= (nv - position)
			position = nv
			$AnimationPlayer.stop(true)
			$AnimationPlayer.play("Move " + dir,-1, 3.0)
			
			# What kind of Tile?
			if collider.is_in_group("StaticTiles"):
				chargeLevel += 1
				$Sprites/Antenna.frame = 0
				$Sprites/Antenna.play("Charging")
			elif collider.is_in_group("NormalTiles"):
				if chargeLevel > 0:
					chargeLevel -= 1
					$Sprites/Antenna.frame = 0
					$Sprites/Antenna.play("Discharging")
				else:
					pass # Dust
			if chargeLevel > 0 :
				$"Sprites/Edge Light".show()
			else : $"Sprites/Edge Light".hide()
			# STEP
			emit_signal("step")
	else :
		BotError()

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

func isPressed(key:String):
	if Input.is_action_pressed(key):
		return true
	else : return false

func justPressed(key:String):
	if Input.is_action_just_pressed(key):
		return true
	else : return false

func justReleased(key:String):
	if Input.is_action_just_released(key):
		return true
	else : return false


func _on_Area2D_area_entered(area):
	if area.is_in_group("Tiles"):
		currentTile = area.get_parent()
		area.get_parent().find_node("Highlight FX").modulate.a = 1.0
		#area.get_parent().find_node("Highlight FX").show()
	pass # Replace with function body.


func _on_Area2D_area_exited(area):
	if area.is_in_group("Tiles"):
		area.get_parent().find_node("Highlight FX").modulate.a = 0.0
		#area.get_parent().find_node("Highlight FX").hide()
	pass # Replace with function body.


func _on_Antenna_animation_finished():
	match $Sprites/Antenna.animation:
		"Discharging":
			if chargeLevel > 0:
				$Sprites/Antenna.play("Charged")
			else:
				$Sprites/Antenna.play("Empty")
	pass # Replace with function body.
