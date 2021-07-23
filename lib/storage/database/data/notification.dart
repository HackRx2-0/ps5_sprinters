class Notif {
  int? id;
  String payload;

  Notif({this.id, required this.payload});

  factory Notif.fromMap(Map<String, dynamic> json) => new Notif(
        id: json["id"],
        payload: json["payload"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "payload": payload,
      };
}
