extends Node2D

signal step
signal reachedGoal
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
	if justPressed("up"):
		moveBot("up")
	elif justPressed("down"):
		moveBot("down")
	elif justPressed("right"):
		moveBot("right")
	elif justPressed("left"):
		moveBot("left")
	
	elif justPressed("discharge"):
		if chargeLevel > 0:
			staticDischarge()
		else:
			BotError()
	pass #_process()

func staticDischarge():
	$Sprites/Antenna.frame = 0
	$Sprites/Antenna.play("Discharging")
	
	sparksOnTile(currentTile, 1.0, 0.1)
	var areas = $RingArea.get_overlapping_areas()
	for ar in areas:
		if ar.is_in_group("Tiles"):
			var tile = ar.get_parent()
			if tile.name != currentTile.name :
				var l = abs(tile.position.y - currentTile.position.y) + ((abs(tile.position.x - currentTile.position.x))/2)
				l /= 32
				l -= 1
				l = chargeLevel - l
				var ap:float = l / chargeLevel
				ap = max(ap, 0.1)
				ap = min(0.95, ap)
				sparksOnTile(tile, ap, (1.0-ap) * 1.2, l) # Span of 2 Seconds
	
	chargeLevel = 0
	$RingArea.scale = Vector2.ONE
	$"Sprites/Edge Light".hide()
	emit_signal("step")
	
	pass # END StaticDischarge()

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
			var tile = collider.get_parent()
			if tile.occupied:
				var obj = tile.occupier
				if obj.is_in_group("Gates") and obj.find_node("AnimatedSprite").animation != "Lowered":
					BotError()
					return
				elif obj.is_in_group("Towers"):
					pass
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
				sparksOnTile(collider.get_parent(), 1.0, 0.1)
			elif collider.is_in_group("NormalTiles"):
				if chargeLevel > 0:
					chargeLevel -= 1
					$Sprites/Antenna.frame = 0
					$Sprites/Antenna.play("Discharging")
					sparksOnTile(collider.get_parent(), 1.0, 0.1)
				else:
					pass # Dust
			if chargeLevel > 0 :
				$"Sprites/Edge Light".show()
				$RingArea.scale = Vector2(chargeLevel*2 +1, chargeLevel*2 +1)
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

func sparksOnTile(tile, alpha, waitTime, level = 0):
	if level: tile.find_node("Sprites").find_node("Label").text = str(level)
	tile.chargeLevel = level
	tile.find_node("Sprites").find_node("FX").modulate.a = alpha
	tile.find_node("FXTimer").start(waitTime)

func _on_Area2D_area_entered(area):
	if area.is_in_group("Tiles"):
		currentTile = area.get_parent()
		if area.is_in_group("GoalTiles"):
			emit_signal("reachedGoal")
			pass
		#area.get_parent().find_node("Sprites/Highlight FX").modulate.a = 0.4
	pass #


func _on_Area2D_area_exited(area):
	if area.is_in_group("Tiles"):
		#area.get_parent().find_node("Sprites/Highlight FX").modulate.a = 0.0
		pass
	pass


func _on_Antenna_animation_finished():
	match $Sprites/Antenna.animation:
		"Discharging":
			if chargeLevel > 0:
				$Sprites/Antenna.play("Charged")
			else:
				$Sprites/Antenna.play("Empty")
	pass #
