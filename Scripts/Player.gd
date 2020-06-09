extends KinematicBody2D

export var speed = 250
export var img_size = 2
export var acceleration = 800
export var friction = 1000

onready var collider = $CollisionShape2D
onready var sprite = $Sprite
onready var joystick = get_parent().get_node("Joystick/JoystickButton")
onready var weapon_range = $Raycast2D

var velocity = Vector2.ZERO

func _ready():
	yield(get_tree(), "idle_frame")
	collider.scale = Vector2(img_size, img_size)
	sprite.scale = Vector2(img_size, img_size)

func _process(delta):
	var is_moving: bool = _move(delta)

func _move(delta):
	var input_vector: Vector2 = joystick.get_value()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		
	velocity = move_and_slide(velocity)
	
	return true
	

func check_shoot():
	pass
