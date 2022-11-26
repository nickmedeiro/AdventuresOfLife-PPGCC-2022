extends Node2D
class_name Gun

onready var Muzzle = $Muzzle
onready var Cooldown = $Cooldown
onready var AnimationPlayer = $AnimationPlayer
export (PackedScene) var Bullet
export (Color) var bullet_color = Color.red


func shoot(target = null):
	if(not Cooldown.is_stopped() or Bullet == null):
		return
	
	if not target == null:
		look_at(target)
	
	var bullet_instance = Bullet.instance()
	bullet_instance.gun_owner = get_owner()
	var direction = global_position.direction_to(Muzzle.global_position).normalized()
	GlobalSignals.emit_signal("bullet_fired", bullet_instance, Muzzle.global_position, direction)
	Cooldown.start()
	AnimationPlayer.play("muzzle_flash")
