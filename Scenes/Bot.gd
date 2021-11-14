extends Node2D

signal step
var Hovering = false

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
		$Sprites/Antenna.animation = "Charging"
		BotError()
		#$AnimationPlayer.stop(true)
		#$AnimationPlayer.play("Move Up",-1, 1.0)
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

func checkAndMove(v):
	# Fire Ray and make sure there is a Tile in that place!
	$Sprites.position -= (v - position)
	position = v
	#spt = v
	return true

func moveBot(dir):
	$Sprites/Body.animation = dir
	$Sprites/Antenna.position = AntennaPos[dir]
	
	$RayCast2D.cast_to = moveVec(Vector2.ZERO, dir)
	$RayCast2D.force_raycast_update()
	var collider:Area2D = $RayCast2D.get_collider()
	if collider != null:
		if collider.get_parent().is_in_group("Tiles"):
			var nv:Vector2 = moveVec(position, dir)
			$Sprites.position -= (nv - position)
			position = nv
			$AnimationPlayer.stop(true)
			$AnimationPlayer.play("Move " + dir,-1, 3.0)
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
