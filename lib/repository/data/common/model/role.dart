class Role {
  final int? id;
  final String? name;

  Role({this.id, this.name});

  // Convert a JSON map to a Role object
  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'], 
      name: json['name']);
  }

  // Convert a Role object to a JSON map
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
