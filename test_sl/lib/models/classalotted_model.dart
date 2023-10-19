class ClassAlottedModel{
  final String id;
  final DateTime createdAt;
  final String? classname;

  ClassAlottedModel({
    required this.id,
    required this.createdAt,
    this.classname
  });

  factory ClassAlottedModel.fromJson(Map<String, dynamic> data){
    return ClassAlottedModel(
      id: data['id'], 
      createdAt: DateTime.parse(data['created_at']),
     classname: data['className']);
  }
}