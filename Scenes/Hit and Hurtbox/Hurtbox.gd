extends Area2D

export(bool) var SHOW_HIT = true

const HitEffect = preload("res://Scenes/Effects/HitEffect.tscn")

func _on_Hurtbox_area_entered(area):
	if SHOW_HIT:
		var hitEffect = HitEffect.instance()
		var main = get_tree().current_scene
		main.add_child(hitEffect)
		hitEffect.position = self.global_position
		hitEffect.play("Animate")
