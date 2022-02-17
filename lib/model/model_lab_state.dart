import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_lab_state.freezed.dart';

@freezed
class LabState with _$LabState{
  const factory LabState({
    @Default('') String university,
    @Default('') String location,
    @Default('') String labName,
    @Default('') String ownerId,
    @Default('') String email,
    @Default('') String link,
    @Default('') String tagline,
    @Default('') String field,
    @Default('') String description,
    @Default('') String application,
    @Default('') String researchImageUrl,
    @Default('') String avatarImageUrl,
    @Default([])List<dynamic> keywords,
    @Default([]) List<dynamic> features,
    @Default(false) bool isLoading
  }) = _LabState;
}