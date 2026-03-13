extends CharacterBody2D
@export var gravity = 200.0
@export var walk_speed = 200.0
@export var jump_speed = -200.0
var max_jumps = 2
var jumps_left = max_jumps
@export var dash_multiplier = 2.5
var dash_time_limit = 0.2
var dash_timer = 0.0
var is_dashing = false
var double_tap_window = 0.3
var last_left_tap = 0.0
var last_right_tap = 0.0
@export var crouch_multiplier = 0.5
@onready var jump_sound = $JumpSound
@onready var dash_sound = $DashSound

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += delta * gravity
	else:
		jumps_left = max_jumps

	var is_crouching = Input.is_action_pressed("ui_down")
	var current_speed = walk_speed
	if is_crouching:
		current_speed *= crouch_multiplier

	# ✅ Jump hanya dipanggil SEKALI di sini
	if Input.is_action_just_pressed("ui_up") and jumps_left > 0:
		velocity.y = jump_speed
		jumps_left -= 1
		jump_sound.play()

	var current_time = Time.get_ticks_msec() / 1000.0
	if Input.is_action_just_pressed("ui_left"):
		if current_time - last_left_tap <= double_tap_window and not is_crouching:
			is_dashing = true
			dash_timer = dash_time_limit
			dash_sound.play()
		last_left_tap = current_time
	if Input.is_action_just_pressed("ui_right"):
		if current_time - last_right_tap <= double_tap_window and not is_crouching:
			is_dashing = true
			dash_timer = dash_time_limit
			dash_sound.play()
		last_right_tap = current_time

	if is_dashing:
		dash_timer -= delta
		current_speed *= dash_multiplier
		if dash_timer <= 0:
			is_dashing = false

	if Input.is_action_pressed("ui_left"):
		velocity.x = -current_speed
	elif Input.is_action_pressed("ui_right"):
		velocity.x = current_speed
	else:
		velocity.x = 0

	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0

	var animation = "idle"
	if is_crouching:
		animation = "crouch"
	elif not is_on_floor():
		animation = "jump"
	elif velocity.x != 0:
		animation = "walk"

	if $AnimatedSprite2D.animation != animation:
		$AnimatedSprite2D.play(animation)

	move_and_slide()
