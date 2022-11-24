extends Node

var amplitude = 0

onready var Camera = get_parent()
onready var ShakeTween = $ShakeTween
onready var FrequencyTimer = $FrequencyTimer
onready var DurationTimer = $DurationTimer

const TRANSITION = Tween.TRANS_SINE
const EASING = Tween.EASE_IN_OUT

func start(duration = 0.2, frequency = 15, amplitude = 8):
	self.amplitude = amplitude
	
	DurationTimer.wait_time = duration
	FrequencyTimer.wait_time = 1 / float(frequency)
	DurationTimer.start()
	FrequencyTimer.start()
	
	_shake()

func _shake():
	var random = Vector2()
	random.x = rand_range(-amplitude, amplitude)
	random.y = rand_range(-amplitude, amplitude)
	
	ShakeTween.interpolate_property(Camera, "offset", Camera.offset, random, FrequencyTimer.wait_time, TRANSITION, EASING)
	ShakeTween.start()

func _stop():
	ShakeTween.interpolate_property(Camera, "offset", Camera.offset, Vector2(), FrequencyTimer.wait_time, TRANSITION, EASING)
	ShakeTween.start()

func _on_FrequencyTimer_timeout():
	_shake()
 

func _on_DurationTimer_timeout():
	_stop()
	FrequencyTimer.stop()
