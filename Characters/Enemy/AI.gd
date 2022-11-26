extends Node2D

signal state_changed

onready var DetectionZone = $DetectionZone

enum State {
	IDLE,
	ENGAGE
}

var state = State.IDLE setget set_state
var target = null
var gun: Gun = null
var character: KinematicBody2D = null

func _physics_process(_delta):
	if character.is_dead:
		return
	
	match state:
		State.IDLE:
			character.get_node("Direction/AnimatedSprite").play("idle")
			
		State.ENGAGE:
			if target == null or gun == null or not is_instance_valid(target):
				return
			
			if target.is_dead:
				return
			
			var player_direction = (target.position - character.position).normalized()
			character.move_and_slide(100 * player_direction)
			character.get_node("Direction/AnimatedSprite").play("walk")
			
			var offset = Vector2(rand_range(-100, 100), rand_range(-100, 100))
			

			gun.shoot(target.global_position + offset)
			var direction = sign(target.global_position.x - character.global_position.x);
			character.get_node("Direction").scale.x = -1 if direction <= 0 else 1


func set_state(new_state):
	if state == new_state:
		return
	
	state = new_state
	emit_signal("state_changed", state)


func initialize(character: KinematicBody2D, gun: Gun):
	self.character = character
	self.gun = gun


func on_hit(attacker):
	target = attacker
	
	set_state(State.ENGAGE)
	
	character.get_node("Direction").scale.x *= -1

func _on_DetectionZone_body_entered(body: Node):
	if not body.is_in_group("player"):
		return
	
	if target != null:
		return
	
	set_state(State.ENGAGE)
	target = body


func _on_DetectionZone_body_exited(body):
	if body != target:
		return
	
	target = null
	
	set_state(State.IDLE)
