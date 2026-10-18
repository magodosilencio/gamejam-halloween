extends CharacterBody2D
class_name Player

const TILE_SIZE: int = 16;
const MOVEMENT_DEADZONE: float = 0.25;
const SPEED: float = 5;

var can_move: bool = true;
var dir: Vector2 = Vector2.ZERO;

@onready var interaction_area: Area2D = $Areas/InteractionArea;
@onready var interaction_ray: RayCast2D = $Raycasts/InteractionRay;

func _ready() -> void:
	add_to_group("player");
	
	DialogueManager.connect("dialogue_started", _on_dialogue_started)
	DialogueManager.connect("dialogue_ended", _on_dialogue_ended)
	
	await get_tree().create_timer(0.05).timeout
	CameraManager.change_camera_target(self);

func _process(delta: float) -> void:
	_input_handling();

func _physics_process(delta: float) -> void:
	if (can_move): _move();


func _input_handling() -> void:
	dir = Input.get_vector("move_left", "move_right", "move_up", "move_down");
	_update_direction();
	
	if (Input.is_action_just_pressed("interact")): _interact();

func _update_direction():
	if (abs(dir.y) > abs(dir.x)):
		if (dir.y > 0): interaction_ray.rotation = PI / 2;
		elif (dir.y < 0): interaction_ray.rotation = -PI / 2;
	else:
		if (dir.x > 0): interaction_ray.rotation = 0;
		elif (dir.x < 0): interaction_ray.rotation = PI;

func _move():
	var abs_dir: Vector2 = dir.abs();
	if (can_move && (abs_dir.x > MOVEMENT_DEADZONE || abs_dir.y > MOVEMENT_DEADZONE)):
		velocity = dir.normalized() * SPEED * TILE_SIZE;
	else:
		velocity = Vector2.ZERO;
	
	move_and_slide();

func _interact():
	if (interaction_ray.is_colliding()):
		var object: Interactable = interaction_ray.get_collider();
		if (object != null): object.interact();

func _on_dialogue_started():
	can_move = false;

func _on_dialogue_ended():
	can_move = true;
