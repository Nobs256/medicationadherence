import 'package:freezed_annotation/freezed_annotation.dart';

part 'lifestyle_advice.freezed.dart';
part 'lifestyle_advice.g.dart';

@freezed
class LifestyleAdvice with _$LifestyleAdvice {
  const factory LifestyleAdvice({
    required int id,
    @JsonKey(name: 'prescription_id') required int prescriptionId,
    @JsonKey(name: 'advice_type') required String adviceType, // exercise, diet, hydration, sleep, general
    required String title,
    required String description,
    String? frequency,
    @JsonKey(name: 'duration_minutes') int? durationMinutes,
  }) = _LifestyleAdvice;

  factory LifestyleAdvice.fromJson(Map<String, dynamic> json) =>
      _$LifestyleAdviceFromJson(json);
}