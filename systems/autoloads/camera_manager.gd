extends Node2D

var camera: CameraFollow = null;

func set_main_camera(c: Camera2D, force_set: bool = false):
	if (camera && force_set): pass;
	elif (camera):
		print("Já existe uma câmera principal.");
		return;
	
	if (c): camera = c;

func change_camera_target(new_target: Node2D):
	if (camera): camera.set_target(new_target);
	else: print("Atenção! Tentativa de mudar o alvo da câmera, mas a câmera não existe.")

func _on_camera_follow_removed(c: CameraFollow):
	if (camera == c): camera = null;
