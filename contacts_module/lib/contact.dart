import 'dart:convert';

class Contact {
  String id;
  String name;
  String mail;
  String groupId;
  String groupName;

  Contact({
    required this.id,
    required this.name,
    required this.mail,
    required this.groupId,
    required this.groupName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mail': mail,
      'groupId': groupId,
      'groupName': groupName,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      mail: map['mail'] ?? '',
      groupId: map['groupId'] ?? '',
      groupName: map['groupName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) => Contact.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Contact(id: $id, name: $name, mail: $mail, groupId: $groupId, groupName: $groupName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Contact &&
        other.id == id &&
        other.name == name &&
        other.mail == mail &&
        other.groupId == groupId &&
        other.groupName == groupName;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ mail.hashCode ^ groupId.hashCode ^ groupName.hashCode;
  }

  Contact copyWith({
    String? id,
    String? name,
    String? mail,
    String? groupId,
    String? groupName,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      mail: mail ?? this.mail,
      groupId: groupId ?? this.groupId,
      groupName: groupName ?? this.groupName,
    );
  }
}
