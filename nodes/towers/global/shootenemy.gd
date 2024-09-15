extends Node2D

var canfire = true
@export var weaponType = "particles/dart"
@export var customCode = []
var spawnedProjectiles = []
var weapon

func _ready():
	weapon = load("res://nodes/towers/" + weaponType + ".tscn")

func shoot(target, status):
	if !canfire:
		return
	
	canfire = false
	
	var clone = weapon.instantiate()
	clone.position = global_position
	
	var direction = (get_node_or_null(target).global_position - get_node_or_null("../sprite").global_position).normalized()
	var angle = atan2(direction.y, direction.x)
	
	get_parent().look_at(get_node_or_null(target).global_position)
	get_parent().rotation = angle
	
	get_node("../level").rotation = -angle
	get_node("../ring").rotation = -angle
	get_node("../other").rotation = -angle
	get_node("../RayCast2D").rotation = -angle
	
	clone.vel = direction
	clone.rotation = angle
	
	clone.damage = get_parent().projectileDamage
	clone.piercing = get_parent().projectilePiercing
	clone.speed = get_parent().projectileSpeed
	clone.trueParent = get_parent().get_path()
	clone.isAnimated = get_parent().particleAnimated
	
	for x in get_parent().ripStatus:
		clone.ripStatus.append(x)
	
	get_node("../sprite").play("default")
	for x in get_node("../sprite").get_children():
		if x is AnimatedSprite2D:
			x.play("default")
	
	get_node("../../").add_child(clone)
	spawnedProjectiles.append(str(clone.get_path()))
	
	# Check max projectiles
	if len(spawnedProjectiles) > get_parent().maxProjectiles:
		var nodePath = get_node_or_null(spawnedProjectiles[0])
		if nodePath:
			get_node(spawnedProjectiles[0]).queue_free()
			spawnedProjectiles.remove_at(0)
		else: spawnedProjectiles.remove_at(0)
	
	get_node("../waittime").start()


func _process(_delta): if get_parent().active:
	var targetlist = get_parent().targetlist
	
	if len(targetlist) > 0 and canfire:
		if get_node_or_null(targetlist[0]):
			shoot(targetlist[0], [])
		else: targetlist.erase(targetlist[0])

func _on_waittime_timeout():
	canfire = true
