class Cat {
  String name;
  int age;
  String image;
  Cat({required this.name, required this.age, required this.image});

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
