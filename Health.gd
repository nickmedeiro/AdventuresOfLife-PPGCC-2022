extends Node2D

export (int) var health = 100 setget set_health
export (int) var max_health = 100

func set_health(newHealth: int):
	health = clamp(newHealth, 0, max_health)
