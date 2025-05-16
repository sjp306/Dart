class Animal {
  final String name;
  final String species;
  final bool canFly;
  final String imagePath;

  Animal({
    required this.name,
    required this.species,
    this.canFly = false,
    required this.imagePath,
  });
}
List<Animal> animalList = [];