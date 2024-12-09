extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var extensions = GDExtensionManager.get_loaded_extensions()

	print("Loaded GDExtensions:")
	for ext in extensions:
		print("- ", ext)
	
	pass
