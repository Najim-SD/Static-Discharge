extends Node2D

signal step
var Hovering = false
var targetPos = Vector2.ZERO

func _ready():
	targetPos = position
	pass #_ready()


func _process(delta):
	if justPressed("up"):
		targetPos = moveVec(targetPos, "up")
		$Body.animation = "up"
	elif justPressed("down"):
		targetPos = moveVec(targetPos, "down")
		$Body.animation = "down"
	elif justPressed("right"):
		targetPos = moveVec(targetPos, "right")
		$Body.animation = "right"
	elif justPressed("left"):
		targetPos = moveVec(targetPos, "left")
		$Body.animation = "left"
	
	position = position.linear_interpolate(targetPos, 0.5)
	
	pass #_process()

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
