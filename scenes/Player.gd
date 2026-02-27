extends CharacterBody2D

@export var gravity = 200.0
@export var walk_speed = 200.0
@export var jump_speed = -200.0

# variabel double jump
var max_jumps = 2
var jumps_left = max_jumps

# variabel dash
@export var dash_multiplier = 2.5
var dash_time_limit = 0.2
var dash_timer = 0.0
var is_dashing = false
var double_tap_window = 0.3
var last_left_tap = 0.0
var last_right_tap = 0.0

# variabel crouch
@export var crouch_multiplier = 0.5

func _physics_process(delta):
	# apply gravitasi
	if not is_on_floor():
		velocity.y += delta * gravity
	else:
		jumps_left = max_jumps # reset lompatan klo napak

	# crouch logic
	var is_crouching = Input.is_action_pressed("ui_down")
	var current_speed = walk_speed

	if is_crouching:
		$AnimatedSprite2D.play("crouch")
		current_speed *= crouch_multiplier # jalannya diperlambat
	else:
		$AnimatedSprite2D.play("idle")

	# double jump
	if Input.is_action_just_pressed("ui_up") and jumps_left > 0:
		velocity.y = jump_speed
		jumps_left -= 1

	# dash logic pake double tap
	var current_time = Time.get_ticks_msec() / 1000.0

	# cek pencetan kiri
	if Input.is_action_just_pressed("ui_left"):
		if current_time - last_left_tap <= double_tap_window and not is_crouching:
			is_dashing = true
			dash_timer = dash_time_limit
		last_left_tap = current_time

	# cek pencetan kanan
	if Input.is_action_just_pressed("ui_right"):
		if current_time - last_right_tap <= double_tap_window and not is_crouching:
			is_dashing = true
			dash_timer = dash_time_limit
		last_right_tap = current_time

	# kurangi timer dash
	if is_dashing:
		dash_timer -= delta
		current_speed *= dash_multiplier
		if dash_timer <= 0:
			is_dashing = false

	# gerak horizontal
	if Input.is_action_pressed("ui_left"):
		velocity.x = -current_speed
	elif Input.is_action_pressed("ui_right"):
		velocity.x = current_speed
	else:
		velocity.x = 0

	# flip arah sprite sesuai arah jalan
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0

	# eksekusi pergerakan
	move_and_slide()
