extends Area2D
class_name Bullet

export (int) var speed = 20

onready var DestroyTimer = $DestroyTimer

var direction := Vector2.ZERO
var gun_owner

func _ready():
	DestroyTimer.start()


func _physics_process(_delta):
	if direction == Vector2.ZERO:
		return
	
	var velocity = direction * speed
	global_position += velocity


func set_direction(direction: Vector2):
	self.direction = direction
	

func _on_DestroyTimer_timeout():
	queue_free()


func _on_Bullet_body_entered(body: Node):
	if not body.has_method("on_hit"):
		return
		
	if body == gun_owner:
		return
	
	body.on_hit(gun_owner)
	queue_free()
