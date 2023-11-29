extends Resource
class_name CharacterStats

enum Gender {
	MALE,
	FEMALE
}
enum Motivation {
	NONE,
	LITTLE,
	MUCH
}

@export var name: String
@export var gender : Gender
@export var age: int
@export var weight : int
@export var motivation : Motivation
@export var fitness_experience : int
@export var image : Texture2D
@export var target_weight : int


func _init(_name : String = "", _gender = Gender.MALE, _age = 20, 
		_weight : int = 0, _motivation = Motivation.LITTLE, 
		_fitness_experience : int = 50, _image = null,
		_target_weight : int = 0):
	name = _name
	gender = _gender
	age = _age
	weight = _weight
	motivation = _motivation
	fitness_experience = _fitness_experience
	image = _image
	target_weight = _target_weight
