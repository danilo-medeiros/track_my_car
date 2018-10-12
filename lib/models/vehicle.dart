class Vehicle {
  num id;
  String name;
  String number;
  String password;
  num profileId;

  Vehicle.fromVehicle(this.name, this.number, this.password, this.profileId);

  Vehicle() {
    this.id = null;
    this.name = null;
    this.number = null;
    this.password = null;
    this.profileId = null;
  }


}