// Create a class hierarchy with a Vehicle superclass and Car and Bike subclasses. Implement methods in each subclass that print specific details, like the type of vehicle, fuel type, and max speed.

// Superclass
class Vehicle {
  String fuelType;
  int maxSpeed;

  Vehicle(this.fuelType, this.maxSpeed);

  void printDetails() {
    print('Fuel Type: $fuelType');
    print('Max Speed: $maxSpeed km/h');
  }
}

// Subclass Car
class Car extends Vehicle {
  Car(String fuelType, int maxSpeed) : super(fuelType, maxSpeed);

  void printDetails() {
    print('Vehicle Type: Car');
    super.printDetails();
  }
}

// Subclass Bike
class Bike extends Vehicle {
  Bike(String fuelType, int maxSpeed) : super(fuelType, maxSpeed);

  void printDetails() {
    print('Vehicle Type: Bike');
    super.printDetails();
  }
}

void main() {
  Car myCar = Car('Petrol', 180);
  myCar.printDetails();

  print(''); // Just for spacing

  Bike myBike = Bike('Electric', 120);
  myBike.printDetails();
}
