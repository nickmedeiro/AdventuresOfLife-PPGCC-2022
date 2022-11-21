extends KinematicBody2D
class_name Player

export (PackedScene) var Bullet
onready var Gun = $Direction/Gun
onready var Direction = $Direction
onready var AnimatedSprite  = $Direction/AnimatedSprite
onready var Health  = $Health

export (int) var max_speed = 200
export (int) var friction = 500
export (int) var acceleration = 500
export (int) var health = 100

var velocity = Vector2.ZERO

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
		AnimatedSprite.play("walk")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		AnimatedSprite.play("idle")

	flip()

	var mouse_position = get_global_mouse_position()
	Gun.look_at(mouse_position)

	# warning-ignore:return_value_discarded
	move_and_slide(velocity)
	

func _unhandled_input(event):
	if event.is_action_pressed("attack"):
		Gun.shoot(get_global_mouse_position())


func flip():
	var direction = sign(get_global_mouse_position().x - global_position.x);
	Direction.scale.x = -1 if direction <= 0 else 1

func on_hit():
	Health.health -= 10

	if health <= 0:
		queue_free()

