extends Node2D

signal bullet_fired(bullet, position, direction)

onready var Muzzle = $Muzzle
onready var CooldownTimer = $CooldownTimer
onready var AnimationPlayer = $AnimationPlayer
export (PackedScene) var Bullet
export (int) var cooldown

func _physics_process(delta):
	var mouse_position = get_global_mouse_position()
	look_at(mouse_position)


func shoot():	
	if(not CooldownTimer.is_stopped()):
		return
	
	var bullet_instance = Bullet.instance()
	var target = get_global_mouse_position()
	var direction = Muzzle.global_position.direction_to(target).normalized()	
	emit_signal("bullet_fired", bullet_instance, Muzzle.global_position, direction)
	CooldownTimer.start()
	AnimationPlayer.play("muzzle_flash")
