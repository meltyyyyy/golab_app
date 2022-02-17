import 'package:freezed_annotation/freezed_annotation.dart';
import 'model_lab.dart';

part 'model_lab_list.freezed.dart';

@freezed
class LabListState with _$LabListState{
  const factory LabListState({
    @Default([]) List<Lab> labList,
    @Default(false) bool isLoading
  }) = _LabListState;
}