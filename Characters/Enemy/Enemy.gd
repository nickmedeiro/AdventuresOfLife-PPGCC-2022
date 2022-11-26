extends KinematicBody2D

onready var Health  = $Health
onready var Gun = $Direction/Gun
onready var AI = $AI
onready var AnimatedSprite = $Direction/AnimatedSprite

var is_dead = false

func _ready():
	AI.initialize(self, Gun)


func on_hit(attacker: KinematicBody2D):
	Health.health -= 10
	
	AI.on_hit(attacker)
	
	if Health.health <= 0:
		is_dead = true
		attacker.Health.health += 30
		if attacker.is_in_group("player"):
			GlobalSignals.emit_signal("player_kill")
		
		Gun.hide()
		AnimatedSprite.set_deferred("disabled", true)
		AnimatedSprite.play("death")
		yield(AnimatedSprite, "animation_finished")
		queue_free()
