extends StaticBody2D;

const ANIM_OPEN: String = "open";

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D;
@onready var collider: CollisionShape2D = $CollisionShape2D;

@export var is_locked: bool = false;
@export var is_open: bool = false:
	set (value):
		is_open = value;

var is_changing_state: bool = false;

func _ready():
	var last_frame: int = sprite.sprite_frames.get_frame_count(ANIM_OPEN);
	sprite.frame = last_frame if is_open else 0;
	collider.disabled = is_open;

func _change_door_state():
	if (!is_node_ready() || is_changing_state || is_locked): return;
	
	is_open = !is_open;
	is_changing_state = true;
	
	if (is_open):
		sprite.play(ANIM_OPEN);
	else:
		sprite.play_backwards(ANIM_OPEN);

func _unlock():
	# TO DO: Play sound
	is_locked = false;

func _on_animated_sprite_2d_animation_finished() -> void:
	collider.disabled = is_open;
	is_changing_state = false;

func _on_interactable_interacted() -> void:
	_change_door_state();
