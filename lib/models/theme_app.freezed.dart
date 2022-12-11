// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_app.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ThemeApp {
  bool get isDark => throw _privateConstructorUsedError;
  ThemeMode get themeMode => throw _privateConstructorUsedError;
  Color get winColor => throw _privateConstructorUsedError;
  WindowEffect get winEffect => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ThemeAppCopyWith<ThemeApp> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeAppCopyWith<$Res> {
  factory $ThemeAppCopyWith(ThemeApp value, $Res Function(ThemeApp) then) =
      _$ThemeAppCopyWithImpl<$Res, ThemeApp>;
  @useResult
  $Res call(
      {bool isDark,
      ThemeMode themeMode,
      Color winColor,
      WindowEffect winEffect});
}

/// @nodoc
class _$ThemeAppCopyWithImpl<$Res, $Val extends ThemeApp>
    implements $ThemeAppCopyWith<$Res> {
  _$ThemeAppCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isDark = null,
    Object? themeMode = null,
    Object? winColor = null,
    Object? winEffect = null,
  }) {
    return _then(_value.copyWith(
      isDark: null == isDark
          ? _value.isDark
          : isDark // ignore: cast_nullable_to_non_nullable
              as bool,
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      winColor: null == winColor
          ? _value.winColor
          : winColor // ignore: cast_nullable_to_non_nullable
              as Color,
      winEffect: null == winEffect
          ? _value.winEffect
          : winEffect // ignore: cast_nullable_to_non_nullable
              as WindowEffect,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ThemeAppCopyWith<$Res> implements $ThemeAppCopyWith<$Res> {
  factory _$$_ThemeAppCopyWith(
          _$_ThemeApp value, $Res Function(_$_ThemeApp) then) =
      __$$_ThemeAppCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isDark,
      ThemeMode themeMode,
      Color winColor,
      WindowEffect winEffect});
}

/// @nodoc
class __$$_ThemeAppCopyWithImpl<$Res>
    extends _$ThemeAppCopyWithImpl<$Res, _$_ThemeApp>
    implements _$$_ThemeAppCopyWith<$Res> {
  __$$_ThemeAppCopyWithImpl(
      _$_ThemeApp _value, $Res Function(_$_ThemeApp) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isDark = null,
    Object? themeMode = null,
    Object? winColor = null,
    Object? winEffect = null,
  }) {
    return _then(_$_ThemeApp(
      null == isDark
          ? _value.isDark
          : isDark // ignore: cast_nullable_to_non_nullable
              as bool,
      null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      null == winColor
          ? _value.winColor
          : winColor // ignore: cast_nullable_to_non_nullable
              as Color,
      null == winEffect
          ? _value.winEffect
          : winEffect // ignore: cast_nullable_to_non_nullable
              as WindowEffect,
    ));
  }
}

/// @nodoc

class _$_ThemeApp implements _ThemeApp {
  const _$_ThemeApp(this.isDark, this.themeMode, this.winColor, this.winEffect);

  @override
  final bool isDark;
  @override
  final ThemeMode themeMode;
  @override
  final Color winColor;
  @override
  final WindowEffect winEffect;

  @override
  String toString() {
    return 'ThemeApp(isDark: $isDark, themeMode: $themeMode, winColor: $winColor, winEffect: $winEffect)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ThemeApp &&
            (identical(other.isDark, isDark) || other.isDark == isDark) &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.winColor, winColor) ||
                other.winColor == winColor) &&
            (identical(other.winEffect, winEffect) ||
                other.winEffect == winEffect));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isDark, themeMode, winColor, winEffect);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ThemeAppCopyWith<_$_ThemeApp> get copyWith =>
      __$$_ThemeAppCopyWithImpl<_$_ThemeApp>(this, _$identity);
}

abstract class _ThemeApp implements ThemeApp {
  const factory _ThemeApp(final bool isDark, final ThemeMode themeMode,
      final Color winColor, final WindowEffect winEffect) = _$_ThemeApp;

  @override
  bool get isDark;
  @override
  ThemeMode get themeMode;
  @override
  Color get winColor;
  @override
  WindowEffect get winEffect;
  @override
  @JsonKey(ignore: true)
  _$$_ThemeAppCopyWith<_$_ThemeApp> get copyWith =>
      throw _privateConstructorUsedError;
}
