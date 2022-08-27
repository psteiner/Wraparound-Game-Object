extends Sprite

var gameWidth: int = OS.get_window_size().x
var gameHeight: int = OS.get_window_size().y
var spriteWidth: int = get_texture().get_width()
var spriteHeight: int = get_texture().get_height()

var halfSpriteHeight: int = spriteHeight / 2
var halfSpriteWidth: int = spriteWidth / 2

var lowerLimit: int = gameHeight - halfSpriteHeight
var upperLimit: int = halfSpriteHeight
var leftLimit: int = halfSpriteWidth
var rightLimit: int = gameWidth - halfSpriteWidth

export var currentSpeed: float = 300.0
export var acceleration: float = 300.0
export var maxSpeed: float = 1500.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _enter_tree():
	positionMiddle()

func _physics_process(delta: float) -> void:

	if Input.is_action_pressed("ui_left"):
		moveLeft(delta)
	if Input.is_action_pressed("ui_right"):
		moveRight(delta)
	if Input.is_action_pressed("ui_up"):
		moveUp(delta)
	if Input.is_action_pressed("ui_down"):
		moveDown(delta)

func accelerate(delta: float) -> void:
	currentSpeed += delta * acceleration

func decelerate(delta: float) -> void:
	currentSpeed -= delta * acceleration

func moveRight(delta: float) -> void:
	if (currentSpeed < maxSpeed):
		accelerate(delta)
	if (position.x < rightLimit):
		position.x += currentSpeed * delta

func moveLeft(delta: float) -> void:
	if (position.x > leftLimit):
		position.x -= currentSpeed * delta

func moveUp(delta: float) -> void:
	if (position.y > upperLimit):
		position.y -= currentSpeed * delta

func moveDown(delta: float) -> void:
	if (position.y < lowerLimit):
		position.y += currentSpeed * delta

func positionMiddle() -> void:
	self.position.x = gameWidth / 2
	self.position.y = gameHeight / 2
