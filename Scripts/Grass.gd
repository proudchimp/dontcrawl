extends Node2D

var GrassEffect = preload("res://Scenes/Effects/GrassEffect.tscn")

func create_grass_effect():
	var grassEffect = GrassEffect.instance()
	get_parent().add_child(grassEffect)
	grassEffect.global_position = self.global_position
	
	queue_free()


func _on_Hurtbox_area_entered(area):
	create_grass_effect()
	queue_free()
