import 'package:freezed_annotation/freezed_annotation.dart';

part 'lifestyle_advice.freezed.dart';
part 'lifestyle_advice.g.dart';

@freezed
class LifestyleAdvice with _$LifestyleAdvice {
  const factory LifestyleAdvice({
    @JsonKey(fromJson: _intFromJson) required int id,
    @JsonKey(name: 'prescription_id', fromJson: _intFromJson)
    required int prescriptionId,
    @JsonKey(name: 'advice_type') required String adviceType, // exercise, diet, hydration, sleep, general
    required String title,
    required String description,
    String? frequency,
    @JsonKey(name: 'duration_minutes', fromJson: _intFromDynamic)
    int? durationMinutes,
  }) = _LifestyleAdvice;

  factory LifestyleAdvice.fromJson(Map<String, dynamic> json) =>
      _$LifestyleAdviceFromJson(json);
}

int _intFromJson(dynamic val) =>
    val is int ? val : int.tryParse(val?.toString() ?? '') ?? 0;

int? _intFromDynamic(dynamic val) {
  if (val == null) return null;
  if (val is int) return val;
  return int.tryParse(val.toString());
}