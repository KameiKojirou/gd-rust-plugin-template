extends Node

@onready var rust = RustUtils.new()

func hello(name: String) -> String:
	return rust.hello(name)
