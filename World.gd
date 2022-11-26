extends Node2D

onready var BulletManager = $BulletManager
onready var Enemy = preload("res://Characters/Enemy/Enemy.tscn")
onready var Timer = $Timer


var MAX_ENEMIES = 10
var hordeEnemyCount = 4

func _ready():
	GlobalSignals.connect("bullet_fired", BulletManager, "on_bullet_fired")
	GlobalSignals.connect("player_kill", BulletManager, "on_player_kill")
	Timer.wait_time = 10
	Timer.start()


func _on_Timer_timeout():
	# print("new horde with ", hordeEnemyCount, " enemies")
	
	for n in hordeEnemyCount:
		var enemy = Enemy.instance()
		
		enemy.position = Vector2(rand_range(-500,500), rand_range(-400,400))
		
		add_child(enemy)
	
	hordeEnemyCount = min(MAX_ENEMIES, hordeEnemyCount + 1)
