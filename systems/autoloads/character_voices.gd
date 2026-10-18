extends Node

const DEFAULT_VOICE = preload("res://assets/audio/character_bleeps/default.ogg")
const DEFAULT_PITCH: Array[int] = [1.0, 1.0]

var voices: Dictionary = {
	"Alice": preload("res://assets/audio/character_bleeps/alice.ogg"),
};

func get_character_voice(name: String):
	return voices.get(name, DEFAULT_VOICE)

func get_character_pitch(name: String) -> Array[int]:
	return DEFAULT_PITCH
