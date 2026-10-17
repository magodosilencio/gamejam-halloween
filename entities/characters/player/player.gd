extends CharacterBody2D

const TILE_SIZE: int = 16;
const MOVEMENT_DEADZONE: float = 0.25;
const SPEED: float = 5;

var can_move: bool = true;
var dir: Vector2 = Vector2.ZERO;

@onready var interaction_area: Area2D = $Areas/InteractionArea;
@onready var interaction_ray: RayCast2D = $Raycasts/InteractionRay;

func _ready() -> void:
	add_to_group("player");
	pass # Replace with function body.

func _process(delta: float) -> void:
	_input_handling();

func _physics_process(delta: float) -> void:
	if (can_move): _move();


func _input_handling() -> void:
	dir = Input.get_vector("move_left", "move_right", "move_up", "move_down");
	_update_direction();
	
	if (Input.is_action_just_pressed("interact")): _interact();

func _update_direction():
	if (dir.x > 0): interaction_ray.rotation = 0;
	elif (dir.x < 0): interaction_ray.rotation = PI;
	elif (dir.y > 0): interaction_ray.rotation = PI / 2;
	elif (dir.y < 0): interaction_ray.rotation = -PI / 2;

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
		object.interact();


func _on_interaction_area_area_entered(area: Area2D) -> void:
	pass

func _on_interaction_area_area_exited(area: Area2D) -> void:
	pass # Replace with function body.
