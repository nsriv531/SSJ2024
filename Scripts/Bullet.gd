extends Area2D

@export var bulletSpeed = 1
var velocity = Vector2.ZERO
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += delta * velocity 



func shootBullet(direction):
	print(direction)
	velocity = direction * bulletSpeed

	
	


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()





func _on_body_entered(body):
	print("hit")
	pass # Replace with function body.
