// ignore_for_file: avoid_dynamic_calls

class PredictionModel {
  PredictionModel({
    required this.placeId,
    required this.mainText,
    required this.secondaryText,
  });

  factory PredictionModel.fromJson(Map<String, dynamic> json) {
    return PredictionModel(
      placeId: json['place_id'] as String,
      mainText: json['structured_formatting']['main_text'] as String,
      secondaryText: json['structured_formatting']['secondary_text'] as String,
    );
  }

  final String placeId;
  final String mainText;
  final String secondaryText;
}
