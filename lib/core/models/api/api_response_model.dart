class ApiResponse<T> {
  ApiResponse({
    this.error,
    required this.success,
    this.data,
    this.message,
  });
  final bool success;
  final T? data;
  final dynamic message;
  final String? error;

  static ApiResponse<dynamic> fromJson(
      Map<String, dynamic> json, bool? isSuccses) {
    return ApiResponse<dynamic>(
      data: json,
      success: isSuccses ?? false,
    );
  }

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return 'ApiResponse(success: $success, data: $data, error: $error, messages: $message)';
  }

  factory ApiResponse.unknownError(T data) {
    return ApiResponse(
      data: data,
      error: 'Unknown Error',
      message: 'Unknown Error',
      success: false,
    );
  }
}
