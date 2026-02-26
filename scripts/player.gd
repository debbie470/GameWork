extends CharacterBody2D

var score := 0

func add_score(amount: int):
	score += amount
	print("Score:", score)

# Movement constants
const SPEED = 300.0
const ACCELERATION = 1800.0  # How fast you reach max speed
const FRICTION = 1200.0      # How fast you slow down
const AIR_RESISTANCE = 200.0 # Slower deceleration in air

# Jump constants
const JUMP_VELOCITY = -400.0
const JUMP_CUT_MULTIPLIER = 0.5  # Variable jump height
const COYOTE_TIME = 0.1      # Grace period after leaving platform
const JUMP_BUFFER = 0.1      # Grace period before landing

# Internal variables
var coyote_timer := 0.0
var jump_buffer_timer := 0.0
var was_on_floor := false

func _physics_process(delta: float) -> void:
	# Update timers
	var on_floor = is_on_floor()
	
	# Coyote time - allows jumping shortly after leaving platform
	if on_floor:
		coyote_timer = COYOTE_TIME
		was_on_floor = true
	else:
		coyote_timer -= delta
	
	# Jump buffer - remembers jump input before landing
	if Input.is_action_just_pressed("ui_accept"):
		jump_buffer_timer = JUMP_BUFFER
	else:
		jump_buffer_timer -= delta
	
	# Apply gravity
	if not on_floor:
		velocity += get_gravity() * delta
	
	# Handle jump with coyote time and jump buffering
	if jump_buffer_timer > 0 and coyote_timer > 0:
		velocity.y = JUMP_VELOCITY
		jump_buffer_timer = 0
		coyote_timer = 0
	
	# Variable jump height - release jump early for shorter jump
	if Input.is_action_just_released("ui_accept") and velocity.y < 0:
		velocity.y *= JUMP_CUT_MULTIPLIER
	
	# Smooth horizontal movement
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction != 0:
		# Accelerate towards max speed
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
	else:
		# Apply friction (different in air vs ground)
		var deceleration = FRICTION if on_floor else AIR_RESISTANCE
		velocity.x = move_toward(velocity.x, 0, deceleration * delta)
	
	move_and_slide()
	
	was_on_floor = on_floor
