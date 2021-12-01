extends CanvasLayer

var state = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().find_node("Bot").disabled = true
	$TutAnimatior.play("Movement")
	pass # Replace with function body.


func justPressed(key:String):
	if Input.is_action_just_pressed(key):
		return true
	else : return false

func _process(delta):
	if state == 0:
		if justPressed("up") or justPressed("down") or justPressed("left") or justPressed("right"):
			get_parent().find_node("Bot").disabled = false
			$TutAnimatior.stop(true)
			$TutAnimatior.play("Done")
			state += 1
	elif state == 1:
		if get_parent().find_node("Bot").chargeLevel == 5:
			get_parent().find_node("Bot").disabled = true
			$TutAnimatior.stop(true)
			$TutAnimatior.play("Discharging")
			state += 1
	elif state == 2:
		if justPressed("discharge"):
			get_parent().find_node("Bot").disabled = false
			$TutAnimatior.stop(true)
			$TutAnimatior.play("Done")
			state += 1
	pass
