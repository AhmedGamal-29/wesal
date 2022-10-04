import 'auth_services.dart';

const String home_url = "http://192.168.1.103:8080/";
const String base_url = "http://192.168.1.103:8080/api/";


Map<String, String> headers = {"Content-Type": "application/json",
"Authorization":AuthServices.token,
};

List<Map<String,dynamic>> friends=[];
List<Map<String,dynamic>> requests_sent=[];
List<Map<String,dynamic>> requests_recieved=[];