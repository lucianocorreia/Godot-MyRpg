class_name Player extends CharacterBody2D

@export var max_health: float = 10.0
@export var max_mana: float = 10.0
@export var move_speed: float = 10.0
@export var damage: float = 10.0
@export var crit_chance: float = 10.0
@export var crit_damage: float = 10.0

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

var last_direction: String = "down"
