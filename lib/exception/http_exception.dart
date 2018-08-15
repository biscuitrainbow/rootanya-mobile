class UnauthorizedException implements Exception {
  String message;

  UnauthorizedException(this.message);
}

class UnProcessableEntity implements Exception {
  String message;

  UnProcessableEntity(this.message);
}
