class Vehicle {
  num id;
  String name;
  String number;
  String password;
  String lastLatitude;
  String lastLongitude;
  num profileId;

  Vehicle.fromMap(Map<String, dynamic> vehicleMap) {
    this.id = vehicleMap["id"];
    this.name = vehicleMap["name"];
    this.number = vehicleMap["number"];
    this.password = vehicleMap["password"];
    this.lastLatitude = vehicleMap["lastLatitude"];
    this.lastLongitude = vehicleMap["lastLongitude"];
    this.profileId = vehicleMap["profileId"];
  }

  Vehicle() {
    this.id = null;
    this.name = null;
    this.number = null;
    this.password = null;
    this.lastLatitude = null;
    this.lastLongitude = null;
    this.profileId = 1;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "name": this.name,
      "number": this.number,
      "password": this.password,
      "lastLatitude": this.lastLatitude,
      "lastLongitude": this.lastLongitude,
      "profileId": this.profileId
    };
  }

  /// Returns a Map representation of the vehicle, with only the data needed
  Map<String, dynamic> toUpdatableMap() {
    return {
      "name": this.name,
      "number": this.number,
      "password": this.password,
      "profileId": this.profileId
    };
  }

  /// Returns a Map to update vehicle's location
  Map<String, dynamic> toLocationUpdatableMap() {
    return {
      "id": this.id,
      "lastLatitude": this.lastLatitude,
      "lastLongitude": this.lastLongitude
    };
  }

}