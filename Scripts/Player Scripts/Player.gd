extends KinematicBody2D

export(int) var JumpForce = -100
export(int) var JumpReleaseForce = -70
export(int) var MaxSpeed = 85
export(int) var Acceleration = 15
export(int) var Friction = 10
export(int) var Gravity = 5
export(int) var AdditionalFallGravity = 2
export(int) var DoubleJumpForce = -120
export(float) var ReducedGravityDuration = 0.1
export(float) var IncreasedAirControlDuration = 0.2
export(int) var IncreasedAirControl = 20
export(int) var RunningSpeedIncrease = 20

var velocity = Vector2.ZERO
var desired_velocity = Vector2.ZERO
var double_jump_available = true # variable to keep track of whether double jump is available
var double_jump_timer = 0
var increased_air_control_timer = 0
var is_running = false

func _physics_process(_delta):
	apply_gravity()
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	if input.x == 0:
		apply_friction()
		$AnimatedSprite.animation = "Idle"
	else :
		apply_acceleration(input.x)
		is_running = Input.is_action_pressed("running")
		$AnimatedSprite.animation = "Run" if is_running else "Walk"
		
	if input.x > 0:
		$AnimatedSprite.flip_h = false
	elif input.x < 0:
		$AnimatedSprite.flip_h = true
	if is_on_floor():
		double_jump_available = true # reset double jump availability when on floor
		double_jump_timer = 0
		increased_air_control_timer = 0
		if Input.is_action_pressed("up") :
			velocity.y = JumpForce
			velocity.y += JumpForce * 0.1 # add small amount of upward velocity when first leaving the ground
	else :
		$AnimatedSprite.animation = "Jump"
		if Input.is_action_just_released("up") and velocity.y < JumpReleaseForce:
			velocity.y = JumpReleaseForce
		if velocity.y > 0:
			velocity.y += AdditionalFallGravity
		if Input.is_action_just_pressed("up") and double_jump_available: # check if double jump is available and input is pressed
			if is_running:
				velocity.y = DoubleJumpForce + RunningSpeedIncrease
			else:
				velocity.y = DoubleJumpForce
			double_jump_timer = ReducedGravityDuration
			double_jump_available = false # set double jump to unavailable
			increased_air_control_timer = IncreasedAirControlDuration
	# check if reduced gravity timer is still active
	if double_jump_timer > 0:
		double_jump_timer -= _delta
		if double_jump_timer <= 0:
			velocity.y += Gravity
		else:
			velocity.y += Gravity
	
	var was_in_air = not is_on_floor()
	velocity = move_and_slide(velocity, Vector2.UP)
	var just_landed = is_on_floor() and was_in_air
	if just_landed:
		$AnimatedSprite.animation = "Run"
		$AnimatedSprite.frame = 1
	
func apply_gravity():
	velocity.y += Gravity
	
func apply_friction():
	velocity.x = move_toward(velocity.x, 0, Friction)

func apply_acceleration(amount):
	if is_running and amount != 0 and is_on_floor():
		desired_velocity.x = (MaxSpeed + RunningSpeedIncrease) * amount
	else:
		desired_velocity.x = MaxSpeed * amount
	velocity.x = move_toward(velocity.x, desired_velocity.x, Acceleration)


	
func _input(event):
	if event.is_action_pressed("pickup"):
		if $PickupZone.items_in_range.size() > 0:
			var pickup_item = $PickupZone.items_in_range.values()[0]
			pickup_item.pick_up_item(self)
			$PickupZone.items_in_range.erase(pickup_item)
