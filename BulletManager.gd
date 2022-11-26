extends Node2D

export (PackedScene) var Bullet

var player_kill_count = 0

func on_bullet_fired(bullet: Bullet, position: Vector2, direction: Vector2):
	bullet.global_position = position
	bullet.set_direction(direction)
	add_child(bullet)
	

func on_player_kill():
	player_kill_count += 1
	get_parent().get_node("CanvasLayer/UI/NinePatchRect/Label").text = str(player_kill_count)
