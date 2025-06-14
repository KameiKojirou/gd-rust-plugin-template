@tool
extends EditorPlugin


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	print("enable example_rust_plugin")
	add_autoload_singleton("example_rust_plugin", "res://addons/example_rust_plugin/rustutils.gd")


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	print("disable example_rust_plugin")
	remove_autoload_singleton("example_rust_plugin")
