
class Category
{
  final int? id;
  final String? name;
  final String? type;

  Category({this.id, this.name, this.type});
  factory Category.fromMap(Map data)
  {
    return Category(
      id: data['id'],
      name: data['name'],
      type: data['type']
    );
  }
}