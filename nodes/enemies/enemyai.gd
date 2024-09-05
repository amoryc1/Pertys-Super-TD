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
	# hot camo metal fast
	if status.has("camo"):
		var cloneParticle = $particlesprite.duplicate()
		cloneParticle.frame = 3
		cloneParticle.visible = true
		add_child(cloneParticle)
	if status.has("hot"):
		var cloneParticle = $particlesprite.duplicate()
		cloneParticle.frame = 5
		cloneParticle.visible = true
		add_child(cloneParticle)
	if status.has("fast"):
		var cloneParticle = $particlesprite.duplicate()
		cloneParticle.frame = 4
		cloneParticle.visible = true
		
		speed *= 1.5
		add_child(cloneParticle)
	if status.has("metal"):
		var cloneParticle = $particlesprite.duplicate()
		cloneParticle.frame = 7
		cloneParticle.visible = true
		add_child(cloneParticle)
	if status.has("shield"):
		var cloneParticle = $particlesprite.duplicate()
		cloneParticle.frame = 8
		cloneParticle.visible = true
		
		health += 25
		add_child(cloneParticle)



func _process(_delta):
	var speedEffect = 1
	if status.has("glue") and !status.has("hot"): speedEffect = 0.5
	if status.has("glue2") and !status.has("hot"): speedEffect = 0.25
	if status.has("glue3") and !status.has("hot"): speedEffect = 0.1
	
	if speedEffect != 1 and !appliedGlue:
		speed *= speedEffect
		appliedGlue = true
		
		var cloneParticle = $particlesprite.duplicate()
		cloneParticle.frame = 6
		cloneParticle.visible = true
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
					var clone = load(GLOBALVAR_PTD.perty_stages[key][0]).instantiate()
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
		if GLOBALVAR_PTD.health <= 0 and !get_node("../../../").checked_level_outcome:
			get_node("../../../").end_game(false) # Path for enemyspawner
		get_parent().queue_free()
