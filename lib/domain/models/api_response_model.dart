class ApiResponseModel<T> {
  final String message;
  final int statusCode;
  final T? data;
  final bool isSuccess;

  const ApiResponseModel({
    required this.message,
    required this.statusCode,
    this.isSuccess = false,
    this.data,
  });
}
