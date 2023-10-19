import 'dart:math';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_sl/constants/constants.dart';
import 'package:test_sl/models/department_model.dart';
import 'package:test_sl/models/user_model.dart';
import 'package:test_sl/utils/utils.dart';

class DbService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  UserModel? userModel;
  List<DepartmentModel> allDepartmnets = [];
  int? employeeDepartment;

  String generateRandomUserId() {
    final random = Random();
    const allChars = "testTEST123456789";
    final randomString = List.generate(6, (index) => allChars[random.nextInt(allChars.length)]).join();
    return 'SL$randomString';
  }

// Future<void> fetchData() async {
//     final response = await _supabase.from(table)
//     if (response.error == null) {
//       setState(() {
//         classNames = response.data.map((entry) => entry["class_name"] as String).toList();
//       });
//     }
//   }


  Future insertNewUser(String email, var id) async {
    await _supabase.from(Constants.teststudentTable).insert({
      'id': id,
      'name': '',
      'email': email,
      'student_id': generateRandomUserId(),
      'classname': null,
    });
  }

  Future<UserModel> getUserData()async{
    final userData = await _supabase.from(Constants.teststudentTable).select().eq('id', _supabase.auth.currentUser!.id).single();
    userModel = UserModel.fromJson(userData);
    employeeDepartment == null ? employeeDepartment = userModel?.classname : null;
    return userModel!;
  }
  // Since this function can be called multiple times,then it will reset the department value
  // that is why we are using condition to assign only at the first time
  Future<void> getAllDepartments() async {
    final List result = await _supabase.from(Constants.testclassTable).select();
    allDepartmnets = result.map((department) => DepartmentModel.fromJson(department)).toList();
    notifyListeners();
  }

  Future updateProfile(String name, BuildContext context) async {
    await _supabase.from(Constants.teststudentTable).update({
      'name':name,
      'classname': employeeDepartment,
    }).eq('id', _supabase.auth.currentUser!.id);

    //if(context.mounted){
      Utils.showSnackBar("Profile Updated Successfully", context, color: Colors.green);
      notifyListeners();
    //}
  }
}
