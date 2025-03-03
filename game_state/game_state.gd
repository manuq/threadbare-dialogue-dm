extends Node

var _file = ConfigFile.new()
const _FILE_PATH = "user://game_state.ini"

const _INITIAL_INVENTORY: Dictionary = {
	"yarn": 100,
}

const _INITIAL_EVENTS: Dictionary = {
	"got lantern": false,
	"talked to guard 1": false,
	"talked to guard 2": false,
	"guard 2 hinted player once": false,
	"guard 2 hinted player twice": false,
	"guard 2 hinted player 3 times": false,
}

var inventory: Dictionary = {}

var events: Dictionary = {}

func _ready() -> void:
	var error = load_file()
	if error != OK:
		new_file()

func load_file() -> Error:
	var error = _file.load(_FILE_PATH)
	if error != OK:
		return error
	inventory = _INITIAL_INVENTORY.duplicate(true)
	events = _INITIAL_EVENTS.duplicate(true)
	for section in ["inventory", "events"]:
		if section not in _file.get_sections():
			return FAILED
	for key in _file.get_section_keys("inventory"):
		inventory[key] = _file.get_value("inventory", key)
	for key in _file.get_section_keys("events"):
		events[key] = _file.get_value("events", key)
	return OK

func save_file() -> Error:
	_file.clear()
	for key in inventory:
		_file.set_value("inventory", key, inventory[key])
	for key in events:
		_file.set_value("events", key, events[key])
	return _file.save(_FILE_PATH)

func new_file() -> Error:
	inventory = _INITIAL_INVENTORY.duplicate(true)
	events = _INITIAL_EVENTS.duplicate(true)
	return save_file()
	
