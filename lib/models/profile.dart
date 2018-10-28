/// This class holds trackers commands

class Profile {
  num id;
  String name;
  String position;
  String cut;
  String resume;
  String status;
  String reset;
  String overSpeed;
  String centerNumber;
  String deleteCenterNumber;

  Map<String, dynamic> toMap() {
    return  {
      'id': this.id,
      'name': this.name,
      'position': this.position,
      'cut': this.cut,
      'resume': this.resume,
      'status': this.status,
      'reset': this.reset,
      'overSpeed': this.overSpeed,
      'centerNumber': this.centerNumber,
      'deleteCenterNumber': this.deleteCenterNumber,
    };
  }

  Profile.fromMap(Map<String, dynamic> mapValues) {
    this.id = mapValues['id'];
    this.name = mapValues['name'];
    this.position = mapValues['position'];
    this.cut = mapValues['cut'];
    this.resume = mapValues['resume'];
    this.status = mapValues['status'];
    this.reset = mapValues['reset'];
    this.overSpeed = mapValues['overSpeed'];
    this.centerNumber = mapValues['centerNumber'];
    this.deleteCenterNumber = mapValues['deleteCenterNumber'];
  }

}