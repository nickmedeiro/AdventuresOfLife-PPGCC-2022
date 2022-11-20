extends KinematicBody2D

export (int) var health = 100

func on_hit():
	health -= 10

	if health <= 0:
		queue_free()
