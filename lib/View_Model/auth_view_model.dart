import 'dart:convert';
import 'package:dio/dio.dart';
import '../Globals.dart';
import 'package:http/http.dart' as http;


userLogin(String email, String password, bool? rememberMe) async {
  final response = await Dio().post(BaseUrl + '/api/login',
      options: Options(
          validateStatus: (_) {
            return true;
          },
          responseType: ResponseType.json),
      data: jsonEncode({
        "email": email,
        "password": password,
        "remember": rememberMe,
      }));
  print(response);
  return response;
}

// func(String name, String password, bool? rememberMe) async
// {
//   final response =
//    http.post(
//     Uri.parse(BaseUrl + 'api/login/Admin'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode({
//       "username": name,
//       "password": password,
//       "remember": rememberMe,
//     }),
//   );
// }


signUp (String? name,String? email,String? phone, String password, String gender, String birthDay, String passwordConfirm) async
{
  final response = await Dio().post(BaseUrl + '/api/register',
      options: Options(
          validateStatus: (_) {
            return true;
          },
          responseType: ResponseType.json),
      data: jsonEncode({
        "name":name,
        "email": email,
        "password": password,
        "phone": phone,
        "gender": gender,
        "birth_day":birthDay,
        "password_confirmation": passwordConfirm,
      }));
  print(response);
  return response;
}

googleSignUp() async
{
  var request = await http.get(
    (Uri.parse(BaseUrl+'/api/auth/google/callback')),
  );
  print(request);
  return request;
}

facebookSignUp() async
{
  var req = await http.get(
    (Uri.parse(BaseUrl+'/api/auth/facebook')),
  );
  print(req);
  return req;
}

forgotPassword(String email) async
{
  final response = await Dio().post(BaseUrl + '/api/forgot-password',
      options: Options(
          validateStatus: (_) {
            return true;
          },
          responseType: ResponseType.json),
      data: jsonEncode({
        "email": email,
      }));
  print(response);
  return response;
}


resetPassword(String email) async
{
  final response = await Dio().post(BaseUrl + '/api/reset-password',
      options: Options(
          validateStatus: (_) {
            return true;
          },
          responseType: ResponseType.json),
      data: jsonEncode({
        "email": email,
      }));
  print(response);
  return response;
}