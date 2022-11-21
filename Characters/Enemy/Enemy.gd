extends KinematicBody2D

onready var Health  = $Health
onready var Gun = $Direction/Gun
onready var AI = $AI


func _ready():
	AI.initialize(self, Gun)


func on_hit():
	Health.health -= 10
	
