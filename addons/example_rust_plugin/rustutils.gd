extends Node

@onready var rust = RustUtils.new()

func hello(name: String) -> void:
	print(rust.hello(name))
