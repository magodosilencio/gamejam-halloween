extends Camera2D
class_name CameraFollow

@export var camera_follow: bool = true;
@export var follow_speed: float = 0.0;
@export var target: Node2D = null;
@export var can_change_target: bool = true;

func _ready() -> void:
	CameraManager.set_main_camera(self);

func _physics_process(delta: float) -> void:
	if (camera_follow): _follow_target(delta);

func set_target(new_target: Node2D) -> void:
	if (new_target): target = new_target;

func _follow_target(delta: float) -> void:
	if (target == null): return;
	
	var new_pos: Vector2 = target.global_position;
	global_position = lerp(global_position, new_pos, 1.0 - exp(-follow_speed * delta));
