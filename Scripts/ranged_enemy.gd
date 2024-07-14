extends RigidBody2D

enum EnemyState {IDLE_STATE, ATTACK_STATE,MOVEMENT_STATE}
var current_state: EnemyState = EnemyState.MOVEMENT_STATE
@onready var player := get_tree().get_first_node_in_group("player")
@export var speed = 20;

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var enemies := get_tree().get_nodes_in_group("enemy")



@export var BulletScene = preload("res://Scenes/Bullet.tscn")
@export var isattacking = false;
var attackSpeed = 200;
var direction

# Called when the node enters the scene tree for the first time.
func _ready():
	isattacking = true;



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):


	match current_state:
		EnemyState.IDLE_STATE:
			print("hi")
		EnemyState.ATTACK_STATE:
			Attack()
		EnemyState.MOVEMENT_STATE:
			DirectionProcess()
		_:
			print("Unknown state")


func DirectionProcess():
	if(global_position.distance_to(player.global_position) > 250):
		var next_position = nav_agent.get_next_path_position()
		var dir = to_local(next_position).normalized()
		move_and_collide(dir * speed )
	
	if(global_position.distance_to(player.global_position) < 450 && isattacking ):

		current_state = EnemyState.ATTACK_STATE


func  MakePath():
	nav_agent.target_position = player.global_position

func Attack():
	direction = player.position - self.position 
	var marker = get_node("AimParent")
	marker.Update_rotation(direction)
	if(isattacking):
		isattacking = false
		var bullet = BulletScene.instantiate()
		get_tree().current_scene.add_child(bullet)
		var bulpositon =  $AimParent/AimLocation.global_position
		bullet.position = bulpositon
		bullet.shootBullet(direction)
		current_state = EnemyState.MOVEMENT_STATE
		$AttackTimer.start()


func _on_timer_timeout():
	MakePath()
	pass # Replace with function body.


func _on_attack_timer_timeout():
	isattacking = true
	pass # Replace with function body.
