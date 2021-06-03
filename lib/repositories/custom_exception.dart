class CustomException {
  final String? message;

  CustomException({
    this.message = 'Something went wrong!',
  });

  @override
  String toString() => 'CustomException { message: $message }';
}
