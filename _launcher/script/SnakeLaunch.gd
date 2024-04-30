extends Button

#link a GitHub-os release-hez
var exeLink = "https://github.com/vb2007/2023-2024-ikt-4/release..."
var exePath = "user://snake.exe"

var httpRequest = HTTPRequest

func _ready():
	self.disabled = true

func fileExists(path: String) -> bool:
	var dir = Directory.new() #lehet váltani kell EditorFileSystemDirectory.new()-ra
	return dir.file_exists(path)

func verifyGamefiles():
	if fileExists(exePath):
		pass
	else:
		pass

func downloadFile(link: String, path: String):
	httpRequest = HTTPRequest.new()
	add_child(httpRequest)
	
	self.text = "Downloading " + str(path.get_file())
	httpRequest.connect("request_completed", self, "installFile", path)
	
	#hibakezelés
	var error = httpRequest.request_raw(link)
	if error != OK:
		self.text = "Download Error: " + str(error)

#amikor a letöltés kész...
func installFile(result, reponseCode, headers, body, path):
	var dir = Directory.new()
	dir.remove(path)
	
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_buffer(body)
	file.close()

func checkIntergrity():
	if !fileExists(exePath):
		downloadFile(exeLink, exePath)
		print("No .exe file found.")
		return
	
	self.text = "Start game"
	self.disabled = false
