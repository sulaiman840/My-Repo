import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LocaleState  extends Equatable {
  final Locale locale;
  const LocaleState(this.locale);

  @override
  List<Object> get props => [];
}

class SelectedLocaleState extends LocaleState {

  const SelectedLocaleState(Locale locale) : super(locale);
}