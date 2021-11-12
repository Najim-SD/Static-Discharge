extends Node2D

signal step
var Hovering = false
var targetPos = Vector2.ZERO

func _ready():
	targetPos = position
	pass #_ready()


func _process(delta):
	if justPressed("up"):
		targetPos.x -= 32
		targetPos.y -= 16
	if justPressed("down"):
		targetPos.x += 32
		targetPos.y += 16
	if justPressed("right"):
		targetPos.x += 32
		targetPos.y -= 16
	if justPressed("left"):
		targetPos.x -= 32
		targetPos.y += 16
	
	position = position.linear_interpolate(targetPos, 0.5)
	
	pass #_process()


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
