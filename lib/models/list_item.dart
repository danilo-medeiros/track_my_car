class ListItem {
  num id;
  String name;
  String detail;

  ListItem({ this.id, this.name, this.detail });

  ListItem.fromMap(Map<int, dynamic> map) {
    this.id = map[0];
    this.name = map[1];
    this.detail = map[2];
  }

  Map<int, dynamic> toMap() => {
    0: this.id,
    1: this.name,
    2: this.detail
  };

}