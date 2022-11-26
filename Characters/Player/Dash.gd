extends Node2D

onready var DurationTimer = $DurationTimer

export (int) var cooldown = 0.4

func start(duration: float = 0.2):
	DurationTimer.wait_time = duration

func get_is_dashing():
	return not DurationTimer.is_stopped()

func stop():
	print('stop')

func _on_DurationTimer_timeout():
	stop()
