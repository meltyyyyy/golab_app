import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_student_state.freezed.dart';

@freezed
class StudentState with _$StudentState{
  const factory StudentState({
    @Default('') String id,
    @Default('') String name,
    @Default('') String university,
    @Default('') String school,
    @Default('') String department,
    @Default('') String avatarImageUrl,
    @Default('') String backgroundImageUrl,
    @Default('') String tagline,
    @Default(false) bool isLoading,
    @Default([]) List<dynamic> interests,
  }) = _StudentState;
}