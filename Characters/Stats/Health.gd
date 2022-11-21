extends Node2D

export (int) var health = 100 setget set_health
export (int) var max_health = 100

func set_health(new_health: int):
	health = clamp(new_health, 0, max_health)
