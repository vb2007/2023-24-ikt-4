extends Button

# Link to the GitHub release
@export var exe_link := "https://github.com/vb2007/2023-24-ikt-4/releases/download/v1.0-alpha/pong.exe"
@export var exe_path := "user://pong.exe"

var http_request: HTTPRequest

func _ready() -> void:
	self.disabled = true
	check_integrity()

func file_exists(path: String) -> bool:
	var dir := DirAccess.open("user://")
	return dir.file_exists(path)

func download_file(link: String, path: String) -> void:
	http_request = HTTPRequest.new()
	add_child(http_request)

	self.text = "Downloading " + path.get_file()
	http_request.request_completed.connect(install_file.bind(path))

	var error := http_request.request(link)
	if error != OK:
		self.text = "Download Error: " + str(error)

func install_file(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray, path: String) -> void:
	var dir := DirAccess.open("user://")
	dir.make_dir_recursive(path.get_base_dir())

	var file := FileAccess.open(path, FileAccess.WRITE)
	file.store_buffer(body)
	file.close()

	self.text = "Start game"
	self.disabled = false

func check_integrity() -> void:
	if not file_exists(exe_path):
		download_file(exe_link, exe_path)
		print("No .exe file found. Downloading...")
	else:
		self.text = "Start game"
		self.disabled = false

func start_game():
	OS.shell_open(OS.get_user_data_dir() + "/snake.exe")

func _on_pressed():
	start_game()
