@tool class_name TestWorld extends World

func _ready():
	var extensions = GDExtensionManager.get_loaded_extensions()

	print("Loaded GDExtensions:")
	for ext in extensions:
		print("- ", ext)

	pass
