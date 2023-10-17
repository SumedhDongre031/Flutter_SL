import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_sl/services/db_service.dart';
import 'package:test_sl/utils/utils.dart';

class AuthService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;

  final DbService _dbService = DbService();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
// String email, String password,String Name, String confirmpassword
  Future registerUser(
      String email, String password, BuildContext context) async {
    try {
      setIsLoading = true;
      if (email == "" || password == "") {
        throw ("All Fields are required!");
      }
      //else if ()
      final AuthResponse response =
          await _supabase.auth.signUp(email: email, password: password);
      if(response != null){
        await _dbService.insertNewUser(email, response.user!.id);
        if(context.mounted){
        Utils.showSnackBar("Successfully Registered !", context,color: Colors.green);
        await loginUser(email, password, context);
        if(context.mounted){
          Navigator.pop(context);
        }
        // Navigator.of(context).pop();
        }
      }              
    } catch (e) {
      setIsLoading = false;
      if(context.mounted){
        Utils.showSnackBar(e.toString(), context, color: Colors.red);
      } 
    }
  }

  Future loginUser(String email, String password, BuildContext context) async {
    BuildContext currentContext = context;
    try {
      setIsLoading = true;
      
      if (email == "" || password == "") {
        throw ("All Fields are required!");
      }
      final AuthResponse response = await _supabase.auth
          .signInWithPassword(email: email, password: password);
      setIsLoading = false;
    } catch (e) {
      setIsLoading = false;
      if(context.mounted){
      Utils.showSnackBar(e.toString(), currentContext, color: Colors.red);
      }
    }
  }

  Future signOut() async {
    await _supabase.auth.signOut();
    notifyListeners();
  }

  User? get currentUser => _supabase.auth.currentUser;
}
