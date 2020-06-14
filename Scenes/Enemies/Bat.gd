extends KinematicBody2D

export(int) var ACCELERATION = 200
export(int) var FRICTION = 50
export(int) var MAX_SPEED = 50

onready var stats = $Stats

enum {
	IDLE,
	WANDER,
	CHASE
}

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
var DeathEffect = preload("res://Scenes/Effects/EnemyDeathEffect.tscn")
var state = IDLE


func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta )
		WANDER:
			pass
		CHASE:
			pass

func seek_player():
	pass


func _on_Hurtbox_area_entered(area):
	knockback = area.knockback_vector * FRICTION
	stats.health -= area.damage
	

func _on_Stats_no_health():
	var deathEffect = DeathEffect.instance()
	get_parent().add_child(deathEffect)
	deathEffect.position = self.global_position
	deathEffect.play("Animate")
	queue_free()
