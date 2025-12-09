abstract class BaseModel {
  BaseModel();

  factory BaseModel.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError("Implement in subclasses.");
  }
}
