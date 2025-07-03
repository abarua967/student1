class Document {
  final String? name;
  final String? description;
  final String? logoUrl;

  Document({
    this.name,
    this.description,
    this.logoUrl,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      name: json['name'],
      description: json['description'],
      logoUrl: json['logoUrl'],
    );
  }
}
