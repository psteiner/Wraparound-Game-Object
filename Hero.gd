extends Sprite

var gameWidth: int = OS.get_window_size().x
var gameHeight: int = OS.get_window_size().y
var spriteWidth: int = get_texture().get_width()
var spriteHeight: int = get_texture().get_height()

var halfSpriteHeight: int = spriteHeight / 2
var halfSpriteWidth: int = spriteWidth / 2

var speedOnXAxis: float = 0.0
var speedOnYAxis: float = 0.0
export var maxSpeed: float = 1500.0
export var acceleration: float = 300.00

var lowerLimit: int = gameHeight
var upperLimit: int = 0
var leftLimit: int = 0
var rightLimit: int = gameWidth

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
		
	moveHero(delta)
	clampSpeed()
	wrapAroundCheck()

func wrapAroundCheck()->void:
	if position.y > lowerLimit:
		position.y = 0
	if position.y < upperLimit:
		position.y = gameHeight
	if position.x > rightLimit:
		position.x = 0
	if position.x < leftLimit:
		position.x = gameWidth

func moveRight(delta: float) -> void:
	accelerationOnX(delta)

func moveLeft(delta: float) -> void:
	accelerationOnX(-delta)

func moveUp(delta: float) -> void:
	accelerationOnY(-delta)

func moveDown(delta: float) -> void:
	accelerationOnY(delta)

# added abs() method, abs() keeps positive numbers positive, and turns negative numbers positive
# Yas Meteora pointed out that their was no abs() method!
func accelerationOnX(delta: float) -> void:
	if abs(speedOnXAxis) <= maxSpeed:
		speedOnXAxis += acceleration * delta

# added abs() method, abs() keeps positive numbers positive, and turns negative numbers positive
# Yas Meteora pointed out that their was no abs() method!
func accelerationOnY(delta: float) -> void:
	if abs(speedOnYAxis) <= maxSpeed:
		speedOnYAxis += acceleration * delta


func moveHero(delta: float)->void:
	position.x += speedOnXAxis * delta
	position.y += speedOnYAxis * delta
	
func positionMiddle() -> void:
	self.position.x = gameWidth / 2
	self.position.y = gameHeight / 2

	
func clampSpeed()->void:
	speedOnXAxis = clamp(speedOnXAxis, -maxSpeed, maxSpeed)
	speedOnYAxis = clamp(speedOnYAxis, -maxSpeed, maxSpeed)
