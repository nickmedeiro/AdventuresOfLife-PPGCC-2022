extends Node2D

signal state_changed

onready var DetectionZone = $DetectionZone

enum State {
	PATROL,
	ENGAGE
}

var state = State.PATROL setget set_state
var player: Player = null
var gun: Gun = null
var character: KinematicBody2D = null

func _physics_process(delta):
	match state:
		State.PATROL:
			pass
		State.ENGAGE:
			if player == null or gun == null:
				return
				
			gun.look_at(player.global_position)
			gun.shoot(player.global_position)
			var direction = sign(player.global_position.x - character.global_position.x);
			character.get_node("Direction").scale.x = -1 if direction <= 0 else 1


func set_state(new_state):
	if state == new_state:
		return
	
	state = new_state
	emit_signal("state_changed", state)

func initialize(character: KinematicBody2D, gun: Gun):
	self.character = character
	self.gun = gun


func _on_DetectionZone_body_entered(body: Node):
	if body.is_in_group("player"):
		set_state(State.ENGAGE)
		player = body
