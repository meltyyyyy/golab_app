import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_researcher_state.freezed.dart';

@freezed
class ResearcherState with _$ResearcherState{
  const factory ResearcherState({
    @Default('') String id,
    @Default('') String name,
    @Default('') String university,
    @Default('') String graduateSchool,
    @Default('') String avatarImageUrl,
    @Default('') String backgroundImageUrl,
    @Default('') String tagline,
    @Default('') String labName,
    @Default(false) bool hasPage,
    @Default(false) bool isLoading,
    @Default([]) List<dynamic> keywords,
  }) = _ResearcherState;
}