class CustomException {
  final String? message;

  const CustomException({
    this.message = 'Something went wrong!',
  });

  @override
  String toString() {
    return 'CustomException { message: $message }';
  }
}
