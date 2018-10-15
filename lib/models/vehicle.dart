class Vehicle {
  num id;
  String name;
  String number;
  String password;
  num profileId;

  Vehicle.fromVehicle(this.name, this.number, this.password, this.profileId);

  Vehicle.fromMap(Map<String, dynamic> vehicleMap) {
    this.id = vehicleMap["id"];
    this.name = vehicleMap["name"];
    this.number = vehicleMap["number"];
    this.password = vehicleMap["password"];
    this.profileId = vehicleMap["profileId"];
  }

  Vehicle() {
    this.id = null;
    this.name = null;
    this.number = null;
    this.password = null;
    this.profileId = null;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "name": this.name,
      "number": this.number,
      "password": this.password,
      "profileId": this.profileId
    };
  }

}