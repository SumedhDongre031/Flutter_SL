
class UserModel{
  final String id;
  final String email;
  final String name;
  final int? classname;
  final String studentId;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.classname,
    required this.studentId  
  });

  factory UserModel.fromJson(Map<String,dynamic> data){
    return UserModel(
      id: data['id'], 
      name: data['name'], 
      email: data['email'], 
      studentId: data['student_id'],
      classname: data['classname'] );
  }
}

// 'id': id,
// 'name': '',
// 'email': email,
// 'student_id': generateRandomUserId(),
// 'classname': null,