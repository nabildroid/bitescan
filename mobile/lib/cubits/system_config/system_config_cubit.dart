import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SystemConfigState extends Equatable {
  final Locale? locale;

  final Color mainColor;

  const SystemConfigState({
    required this.mainColor,
    this.locale,
  });

  SystemConfigState copyWith({
    Locale? locale,
    Color? color,
  }) {
    return SystemConfigState(
      mainColor: color ?? mainColor,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [locale?.languageCode, mainColor];
}

class SystemConfigCubit extends HydratedCubit<SystemConfigState> {
  SystemConfigCubit(Color mainColor)
      : super(SystemConfigState(mainColor: mainColor)) {
    // Timer.periodic(Duration(seconds: 1), (_) {
    //   final colors = [
    //     mainColor,
    //     Colors.red,
    //     Colors.yellow,
    //     Colors.green,
    //     Colors.black
    //   ];

    //   // emit(state.copyWith(color: colors[Random().nextInt(colors.length)]));
    // });

    emit(state.copyWith(locale: Locale("fr")));
  }

  void toggleLanguage(BuildContext context) {
    if (Localizations.localeOf(context).languageCode == "fr") {
      emit(state.copyWith(locale: Locale("ar")));
    } else {
      emit(state.copyWith(locale: Locale("fr")));
    }
  }

  @override
  SystemConfigState? fromJson(Map<String, dynamic> json) {
    return state.copyWith(
      locale: json["locale"] != null ? Locale(json["locale"]) : null,
    );
  }

  @override
  Map<String, dynamic>? toJson(SystemConfigState state) {
    return {"locale": state.locale?.languageCode};
  }
}
