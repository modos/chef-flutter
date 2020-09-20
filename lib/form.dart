class form {
  String title;
  String description;
  String image;

  form(this.title, this.description, this.image);

  factory form.fromJson(dynamic json) {
    return form("${json['title']}", "${json['description']}",
        "${json['image']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
    'name': title,
    'description': description,
    'image': image,
  };
}