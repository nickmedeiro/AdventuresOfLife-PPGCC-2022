extends Node2D

onready var BulletManager = $BulletManager

func _ready():

	GlobalSignals.connect("bullet_fired", BulletManager, "on_bullet_fired")

