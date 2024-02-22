class Member {
  final String? id;
  final String? username;

  Member({
    this.id,
    this.username,
  });

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
      id: map['id'] as String,
      username: map['username'] as String,
    );
  }

  factory Member.dummy() {
    return Member(id: "id", username: "UserName");
  }
  Member copyWith({
    String? username,
  }) {
    return Member(username: username ?? this.username);
  }
}
