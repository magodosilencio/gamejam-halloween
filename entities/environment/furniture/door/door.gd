@tool
extends StaticBody2D;

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D;
@onready var collider: CollisionShape2D = $CollisionShape2D;

@export var is_locked: bool = false;
@export var is_open: bool = false:
	set (value):
		is_open = value;
		_update_door();

func _ready() -> void:
	_update_door();

func _open():
	# TO DO: play sound
	is_open = true;
	_update_door();

func _close():
	# TO DO: play sound
	is_open = false;
	_update_door();

func _unlock():
	# TO DO: Play sound
	is_locked = false;

func _update_door():
	if !is_node_ready(): return;
	
	if (is_open):
		sprite.play("open");
	else:
		sprite.play("close");
	
	collider.disabled = is_open;

func _on_animated_sprite_2d_animation_finished() -> void:
	if (sprite.animation == "close"):
		#pla sound
		print("cleck");


func _on_interactable_interacted() -> void:
	if (is_open): _close();
	else: _open();
