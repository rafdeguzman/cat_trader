class Cat {
  String name;
  int age;
  String image;
  String id;
  String nameId;
  String breed;
  String description;
  List<int> lifeSpan;
  Cat({
    required this.name,
    required this.age,
    required this.image,
    required this.nameId,
    required this.breed,
    required this.description,
    required this.id,
    required this.lifeSpan,
  });

  void meow() {
    print('$name says: Meow!');
  }

  void sleep() {
    print('$name is sleeping...');
  }

  void eat(String food) {
    print('$name is eating $food.');
  }
}
