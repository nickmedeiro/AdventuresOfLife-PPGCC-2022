extends Node2D

onready var HealthBar = $HealthBar

export (int) var health = 100 setget set_health
export (int) var max_health = 100

func _ready():
	HealthBar._on_max_health_updated(max_health)
	HealthBar._on_health_updated(health)

func set_health(new_health: int):
	health = clamp(new_health, 0, max_health)
	HealthBar._on_health_updated(health)
