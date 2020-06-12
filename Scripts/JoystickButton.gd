extends TouchScreenButton

 # @TODO Accept input system from anywhere on the screen
export var button_velocity = 20
var _radius = Vector2(32,32)
var _boundary = 64
var _ongoing_drag = -1
export var _threshold = 10

func _process(delta):
	if _ongoing_drag == -1:
		var pos_difference = (Vector2(0,0) - _radius) - position
		position += pos_difference * button_velocity * delta

func get_button_pos():
	return position + _radius

func _input(event):
	if event is InputEventScreenDrag or (InputEventScreenTouch and event.is_pressed()):
		
		# @TODO REMOVE INPUTMOUSE EVENT CHECK
		
		var event_dist_from_center = (event.position - get_parent().global_position).length()
		if event_dist_from_center <= _boundary * global_scale.x or (!(event is InputEventMouseButton) and event.get_index() == _ongoing_drag):
			set_global_position(event.position - _radius * global_scale)
		
			if get_button_pos().length() > _boundary:
				set_position(get_button_pos().normalized() * _boundary - _radius)
			
			if !(event is InputEventMouseButton):
				_ongoing_drag = event.get_index()
			
	if event is InputEventScreenTouch and !event.is_pressed() and  !(event is InputEventMouseButton) and event.get_index() == _ongoing_drag:
			_ongoing_drag = -1

func get_value():
	if get_button_pos().length() > _threshold:
		return get_button_pos().normalized()
	return Vector2.ZERO
