class CustomException {
  late final String message;

  CustomException({
    this.message = 'Something went wrong!',
  });

  @override
  String toString() {
    return 'CustomException { message: $message }';
  }
}
