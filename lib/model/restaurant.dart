class Restaurant {
  int? id;
  String? name;
  String? description;
  bool? availability;
  String? image;

  Restaurant(
      {this.id, this.name, this.description, this.availability, this.image});

  void copyRestaurant(Restaurant updateRestaurant) {
    id = updateRestaurant.id;
    name = updateRestaurant.name;
    description = updateRestaurant.description;
    availability = updateRestaurant.availability;
    image = updateRestaurant.image;
  }
}
