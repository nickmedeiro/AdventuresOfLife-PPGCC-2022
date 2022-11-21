extends Node2D
class_name Gun

onready var Muzzle = $Muzzle
onready var Cooldown = $Cooldown
onready var AnimationPlayer = $AnimationPlayer
export (PackedScene) var Bullet


func shoot(target: Vector2):
	if(not Cooldown.is_stopped() or Bullet == null):
		return
	
	var bullet_instance = Bullet.instance()
	var direction = Muzzle.global_position.direction_to(target).normalized()
	GlobalSignals.emit_signal("bullet_fired", bullet_instance, Muzzle.global_position, direction)
	Cooldown.start()
	AnimationPlayer.play("muzzle_flash")
