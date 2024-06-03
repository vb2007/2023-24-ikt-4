extends Button

# Link to the GitHub release
@export var exe_link := "https://github.com/vb2007/2023-2024-ikt-4/release..."
@export var exe_path := "user://snake.exe"

var http_request: HTTPRequest

func _ready() -> void:
	self.disabled = true

func file_exists(path: String) -> bool:
	var dir := DirAccess.open("res://")  # Use DirAccess instead of Directory
	return dir.file_exists(path)

func verify_gamefiles() -> void:
	if file_exists(exe_path):
		pass
	else:
		pass

func download_file(link: String, path: String) -> void:
	http_request = HTTPRequest.new()
	add_child(http_request)

	self.text = "Downloading " + path.get_file()
	http_request.request_completed.connect(install_file.bind(path))  # Use .bind() for arguments

	# Error handling
	var error := http_request.request(link)
	if error != OK:
		self.text = "Download Error: " + str(error)

# When the download is complete...
func install_file(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray, path: String) -> void:
	var dir := DirAccess.open("res://")  # Use DirAccess instead of Directory
	dir.remove(path)

	var file := FileAccess.open(path, FileAccess.WRITE)
	file.store_buffer(body)
	file.close()

func check_integrity() -> void:
	if not file_exists(exe_path):
		download_file(exe_link, exe_path)
		print("No .exe file found.")
		return

	self.text = "Start game"
	self.disabled = false
