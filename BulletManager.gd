extends Node2D

export (PackedScene) var Bullet

func on_bullet_fired(bullet: Bullet, position: Vector2, direction: Vector2):
	bullet.global_position = position
	bullet.set_direction(direction)
	add_child(bullet)
	
