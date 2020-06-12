extends KinematicBody2D

export var speed = 250
export var img_size = 2
export var acceleration = 800
export var friction = 1000

onready var collider = $hurtbox
onready var sprite = $Sprite
onready var joystick = get_parent().get_node("Joystick/JoystickButton")
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

enum {
	MOVE,
	ATTACK
}
var state = MOVE
var velocity = Vector2.ZERO

func _ready():
	yield(get_tree(), "idle_frame")
	animationTree.active = true
	collider.scale = Vector2(img_size, img_size)
	sprite.scale = Vector2(img_size, img_size)

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state(delta)

func move_state(delta):
	var input_vector: Vector2 = joystick.get_value()
	if input_vector != Vector2.ZERO:
		animationTree.set('parameters/Idle/blend_position', input_vector)
		animationTree.set('parameters/Run/blend_position', input_vector)
		animationTree.set('parameters/Attack/blend_position', input_vector)
		animationState.travel('Run')
		velocity = velocity.move_toward(input_vector * speed, acceleration * delta)
	else:
		animationState.travel('Idle')
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	
	return true

func attack_state(delta):
	velocity = Vector2.ZERO
	animationState.travel("Attack")

func attack_finished():
	state = MOVE
