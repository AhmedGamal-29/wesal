class ApiResponse{
  var status,message;
  ApiResponse({required this.status, this.message});

  done(){
    return status == 200;
  }
}