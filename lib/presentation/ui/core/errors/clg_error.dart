import 'package:template/presentation/ui/ui.dart';

class CLGError implements Exception {
  final String name;
  final String description;
  final CLGErrorType type;

  CLGError({
    this.name = '',
    this.description = '',
    String code = '',
  }) : type = CLGErrorType.fromCode(code);

  CLGError.type(this.type, [this.name = '', this.description = '']);

  factory CLGError.fromJson(Map<String, dynamic> json) {
    return CLGError(
      name: json['name'] ?? '',
      description: json['message'] ?? '',
      code: json['code'] ?? '',
    );
  }

  @override
  String toString() {
    return '$type:$name - $description';
  }
}
