extends KinematicBody2D

export var speed = 200
export var img_size = 0.5

onready var collider = $CollisionShape2D
onready var sprite = $Sprite
onready var joystick = get_parent().get_node("Joystick/JoystickButton")

func _ready():
	collider.scale = Vector2(img_size, img_size)
	sprite.scale = Vector2(img_size, img_size)


func _process(delta):
	# @TODO - Make Player Rotate
	move_and_slide(joystick.get_value() * speed)
