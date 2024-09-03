extends Area2D

@export var speed = 1.0 # multiply this by GLOBALVAR.basePertySpeed
@export var damage = 1 # How much damage they deal when reaching the end of its path
@export var earnings = 1 # How much is earned after this is defeated
@export var health = 1
@export var enemyStage = 1
@export var status = []
@export var spawns = {
	"normal": 1 # id in GLOBALVAR.pertyStages + amount to spawn
}

var popped = false

var appliedGlue = false

var glueLevel = 0


func _ready():
	$AnimatedSprite2D.play("default")
	# hot camo metal fast
	if status.has("camo"):
		var cloneParticle = $particlesprite.duplicate()
		cloneParticle.texture = load("res://assets/enemies/particles/camoStatus.png")
		add_child(cloneParticle)
	if status.has("hot"):
		var cloneParticle = $particlesprite.duplicate()
		cloneParticle.texture = load("res://assets/enemies/particles/fireStatus.png")
		add_child(cloneParticle)
	if status.has("fast"):
		var cloneParticle = $particlesprite.duplicate()
		cloneParticle.texture = load("res://assets/enemies/particles/fastStatus.png")
		
		speed *= 1.5
		
		add_child(cloneParticle)
	if status.has("metal"):
		var cloneParticle = $particlesprite.duplicate()
		cloneParticle.texture = load("res://assets/enemies/particles/metalStatus.png")
		add_child(cloneParticle)
	if status.has("shield"):
		var cloneParticle = $particlesprite.duplicate()
		cloneParticle.texture = load("res://assets/enemies/particles/shieldStatus.png")
		
		health += 25
		add_child(cloneParticle)



func _process(_delta):
	if status.has("glue") and !appliedGlue and !status.has("hot"):
		speed *= 0.5
		appliedGlue = true
		var cloneParticle = $particlesprite.duplicate()
		cloneParticle.texture = load("res://assets/enemies/particles/glueStatus.png")
		add_child(cloneParticle)
	if status.has("glue2") and !appliedGlue and !status.has("hot"):
		speed *= 0.25
		appliedGlue = true
		var cloneParticle = $particlesprite.duplicate()
		cloneParticle.texture = load("res://assets/enemies/particles/glueStatus.png")
		add_child(cloneParticle)
	if status.has("glue3") and !appliedGlue and !status.has("hot"):
		speed *= 0.1
		appliedGlue = true
		var cloneParticle = $particlesprite.duplicate()
		cloneParticle.texture = load("res://assets/enemies/particles/glueStatus.png")
		add_child(cloneParticle)
	
	if health <= 0 and !popped:
		popped = true
		var cloneAudio = $pop.duplicate()
		var cloneParticle = $deathPop.duplicate()
		get_node("../../../").add_child(cloneAudio)
		cloneAudio.add_child(cloneParticle)
		cloneParticle.visible = true
		cloneParticle.play("default")
		cloneParticle.position = global_position
		cloneParticle.z_index = 99
		
		cloneAudio.play()
		
		
		if len(spawns) > 0:
			for key in spawns.keys():
				for n in spawns[key]:
					var clone = load(GLOBALVAR_PTD.pertyStages[key][0]).instantiate()
					clone.progress = get_parent().progress + (n * 0.69)
					clone.name = "ENEMYCOPY_" + str(key)
					if glueLevel > 0: # Applies glue to multiple layers
						var area2dNode = clone.find_child("Area2D")
						area2dNode.status.append("glue")
						area2dNode.glueLevel = glueLevel-1
					get_node("../..").add_child(clone)
					get_parent().queue_free()
		else:
			get_parent().queue_free()
		GLOBALVAR_PTD.money += earnings

func _on_area_entered(area):
	if area.name == "death":
		GLOBALVAR_PTD.health -= damage
		get_parent().queue_free()
