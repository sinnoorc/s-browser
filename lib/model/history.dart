class History {
  String? id;
  String? url;
  String? domain;
  DateTime? createdAt;

  History({
    this.id,
    this.url,
    this.domain,
    this.createdAt,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        url: json["url"],
        domain: json["domain"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "domain": domain,
        "createdAt": createdAt?.toIso8601String(),
      };
}
