extends Node2D

onready var BulletManager = $BulletManager
onready var Gun = $Player/Direction/Gun

func _ready():
	Gun.connect("bullet_fired", BulletManager, "on_bullet_fired")
	pass
