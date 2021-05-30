class CustomException {
  String message = '';

  CustomException({
    this.message = 'Something went wrong!',
  });

  @override
  toString() {
    return 'CustomException { message: $message }';
  }
}
