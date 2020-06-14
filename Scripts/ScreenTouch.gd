extends TouchScreenButton

signal target_position(event_position)

func _input(event):
	if event is InputEventScreenTouch or event is InputEventMouseButton:
		emit_signal("target_position", event.position)
