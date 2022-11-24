extends Node2D

onready var ProgressBar = $ProgressBar
onready var DamageProgressBar = $DamageProgressBar
onready var DamageTween = $DamageTween

export (Color) var healthy_color = Color.green
export (Color) var caution_color = Color.yellow
export (Color) var danger_color = Color.red
export (float, 0, 1, 0.05) var caution_zone = 0.6
export (float, 0, 1, 0.05) var danger_zone = 0.3

func _on_health_updated(health):
	ProgressBar.value = health
	_set_color(health)
	DamageTween.interpolate_property(DamageProgressBar, "value", DamageProgressBar.value, health, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	DamageTween.start()

func _set_color(health):
	if health < ProgressBar.max_value * danger_zone:
		ProgressBar.tint_progress = danger_color
		return
	
	if health < ProgressBar.max_value * caution_zone:
		ProgressBar.tint_progress = caution_color
		return
	
	ProgressBar.tint_progress = healthy_color
	

func _on_max_health_updated(max_health):
	ProgressBar.max_value = max_health
	DamageProgressBar.max_value = max_health
