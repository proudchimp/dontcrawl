extends KinematicBody2D

export var speed = 250
export var img_size = 2
export var acceleration = 800
export var friction = 1000

onready var collider = $Collision
onready var sprite = $Sprite
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $HitboxPivot/SwordHitbox


enum {
	MOVE,
	ATTACK
}
var state = MOVE
var velocity = Vector2.ZERO
var target = Vector2.ZERO

func _ready():
	yield(get_tree(), "idle_frame")
	animationTree.active = true
	collider.scale = Vector2(img_size, img_size)
	sprite.scale = Vector2(img_size, img_size)
	swordHitbox.knockback_vector = Vector2.DOWN

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state(delta)

func move_state(delta):
	if position.distance_to(target) > 10:
		velocity = position.direction_to(target) * speed
		velocity = move_and_slide(velocity)
		var direction_vector = position.direction_to(target).normalized()
		swordHitbox.knockback_vector = direction_vector
		animationTree.set('parameters/Idle/blend_position', direction_vector)
		animationTree.set('parameters/Run/blend_position', direction_vector)
		animationTree.set('parameters/Attack/blend_position', direction_vector)
		animationState.travel('Run')
		velocity = velocity.move_toward(direction_vector * speed, acceleration * delta)
	else:
		animationState.travel('Idle')
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	
	return true

func attack_state(_delta):
	velocity = Vector2.ZERO
	animationState.travel("Attack")

func attack_finished():
	state = MOVE


func _on_TouchScreenEvent_target_position(event_position):
	target = event_position
