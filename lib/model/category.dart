class Category {
  String? id;
  String? name;
  String? icon;
  bool isFromAssets;
  DateTime? createdAt;

  Category({
    this.id,
    this.name,
    this.icon,
    this.isFromAssets = true,
    this.createdAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
        isFromAssets: json["isFromAssets"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
        "isFromAssets": isFromAssets,
        "createdAt": createdAt?.toIso8601String(),
      };
}
