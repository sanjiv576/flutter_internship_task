
// class to address failure while fetching data remotely
class Failure{
  final String error;
  final String? statusCode;

  Failure({required this.error, this.statusCode});
}