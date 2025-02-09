class UnauthorizedException implements Exception{

  UnauthorizedException({required this.message});
  
  final String message;
 
}