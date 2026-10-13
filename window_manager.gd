extends Node

const BASE_SIZE: Vector2i = Vector2i(320, 180);
const BASE_SCALE: int = 2;
const SCALE_INCREMENT: int = 2;

var window_scale: int = 1;
var is_fullscreen: bool = false;

func _ready() -> void:
	get_tree().root.min_size = BASE_SIZE;
	
	var initial_scale = _get_max_scale();
	
	if (initial_scale % 2 == 0): initial_scale -= 2;
	else: initial_scale -= 1;
	
	_set_window_size(BASE_SIZE * initial_scale);

func _input(event: InputEvent) -> void:
	if (event.is_action_released('toggle_fullscreen')): _toggle_fullscreen();

func _toggle_fullscreen() -> void:
	is_fullscreen = !is_fullscreen;
	
	if (is_fullscreen):	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN);
	else: DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED);

func _center_window() -> void:
	var screen = DisplayServer.window_get_current_screen()
	var screen_size = DisplayServer.screen_get_size(screen)
	var window_size = DisplayServer.window_get_size()
	
	var new_pos = (screen_size - window_size) / 2
	DisplayServer.window_set_position(new_pos)

func _set_window_size(size: Vector2i) -> void:
	DisplayServer.window_set_size(size);
	_center_window();

func _get_max_scale() -> int:
	var screen_size = DisplayServer.screen_get_size();
	
	var max_size_x = screen_size.x / BASE_SIZE.x;
	var max_size_y = screen_size.y / BASE_SIZE.y;

	return round(min(max_size_x, max_size_y));
