extends Area2D

@onready var heart_sound = $HeartSound

func _on_body_entered(body):
	if body.name == "Player":
		$AnimatedSprite2D.visible = false  # ← langsung sembunyikan
		$CollisionShape2D.set_deferred("disabled", true)  # ← matikan collision
		heart_sound.play()
		await heart_sound.finished
		queue_free()
