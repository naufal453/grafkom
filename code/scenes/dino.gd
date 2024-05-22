extends CharacterBody2D

const GRAVITY : int = 4200
const JUMP_SPEED : int = -1700
const FALL : int = 3000
const DASH : int = 200
const BACK : int = -500

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.y += GRAVITY * delta
	if is_on_floor():
		if not get_parent().game_running:
			$AnimatedSprite2D.play("idle")
		else:
			$RunCol.disabled = false
			if Input.is_action_pressed("jump"):
				velocity.y = JUMP_SPEED
			elif Input.is_action_just_pressed("ui_right"):
				velocity.x = DASH
			elif Input.is_action_just_released("ui_right"):
				velocity.x = 0
			elif Input.is_action_just_pressed("ui_left"):
				velocity.x = BACK
			elif Input.is_action_just_released("ui_left"):
				velocity.x = 0
				#$JumpSound.play()
			elif Input.is_action_pressed("ui_down"):
				$AnimatedSprite2D.play("duck")
				$RunCol.disabled = true
			else:
				$AnimatedSprite2D.play("run")
	elif !is_on_floor():
		if Input.is_action_pressed("ui_down"):
			velocity.y = FALL
		elif Input.is_action_just_pressed("ui_right"):
			velocity.x = DASH
		elif Input.is_action_just_released("ui_right"):
			velocity.x = 0
		elif Input.is_action_just_pressed("ui_left"):
			velocity.x = BACK
		elif Input.is_action_just_released("ui_left"):
			velocity.x = 0
		else:
			$AnimatedSprite2D.play("jump")
		
	else:
		$AnimatedSprite2D.play("jump")
		
	move_and_slide()
