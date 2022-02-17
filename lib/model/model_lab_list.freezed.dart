// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'model_lab_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$LabListStateTearOff {
  const _$LabListStateTearOff();

  _LabListState call({List<Lab> labList = const [], bool isLoading = false}) {
    return _LabListState(
      labList: labList,
      isLoading: isLoading,
    );
  }
}

/// @nodoc
const $LabListState = _$LabListStateTearOff();

/// @nodoc
mixin _$LabListState {
  List<Lab> get labList => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LabListStateCopyWith<LabListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LabListStateCopyWith<$Res> {
  factory $LabListStateCopyWith(
          LabListState value, $Res Function(LabListState) then) =
      _$LabListStateCopyWithImpl<$Res>;
  $Res call({List<Lab> labList, bool isLoading});
}

/// @nodoc
class _$LabListStateCopyWithImpl<$Res> implements $LabListStateCopyWith<$Res> {
  _$LabListStateCopyWithImpl(this._value, this._then);

  final LabListState _value;
  // ignore: unused_field
  final $Res Function(LabListState) _then;

  @override
  $Res call({
    Object? labList = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_value.copyWith(
      labList: labList == freezed
          ? _value.labList
          : labList // ignore: cast_nullable_to_non_nullable
              as List<Lab>,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$LabListStateCopyWith<$Res>
    implements $LabListStateCopyWith<$Res> {
  factory _$LabListStateCopyWith(
          _LabListState value, $Res Function(_LabListState) then) =
      __$LabListStateCopyWithImpl<$Res>;
  @override
  $Res call({List<Lab> labList, bool isLoading});
}

/// @nodoc
class __$LabListStateCopyWithImpl<$Res> extends _$LabListStateCopyWithImpl<$Res>
    implements _$LabListStateCopyWith<$Res> {
  __$LabListStateCopyWithImpl(
      _LabListState _value, $Res Function(_LabListState) _then)
      : super(_value, (v) => _then(v as _LabListState));

  @override
  _LabListState get _value => super._value as _LabListState;

  @override
  $Res call({
    Object? labList = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_LabListState(
      labList: labList == freezed
          ? _value.labList
          : labList // ignore: cast_nullable_to_non_nullable
              as List<Lab>,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_LabListState implements _LabListState {
  const _$_LabListState({this.labList = const [], this.isLoading = false});

  @JsonKey(defaultValue: const [])
  @override
  final List<Lab> labList;
  @JsonKey(defaultValue: false)
  @override
  final bool isLoading;

  @override
  String toString() {
    return 'LabListState(labList: $labList, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LabListState &&
            (identical(other.labList, labList) ||
                const DeepCollectionEquality()
                    .equals(other.labList, labList)) &&
            (identical(other.isLoading, isLoading) ||
                const DeepCollectionEquality()
                    .equals(other.isLoading, isLoading)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(labList) ^
      const DeepCollectionEquality().hash(isLoading);

  @JsonKey(ignore: true)
  @override
  _$LabListStateCopyWith<_LabListState> get copyWith =>
      __$LabListStateCopyWithImpl<_LabListState>(this, _$identity);
}

abstract class _LabListState implements LabListState {
  const factory _LabListState({List<Lab> labList, bool isLoading}) =
      _$_LabListState;

  @override
  List<Lab> get labList => throw _privateConstructorUsedError;
  @override
  bool get isLoading => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$LabListStateCopyWith<_LabListState> get copyWith =>
      throw _privateConstructorUsedError;
}
