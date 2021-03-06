extends TouchScreenButton

signal event_position(target_position)

func _input(event):
	if event is InputEventScreenTouch or event is InputEventMouseButton:
		if event.is_pressed():
			emit_signal("event_position", event.position)
