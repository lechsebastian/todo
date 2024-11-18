import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(const SettingsState(
          errorMessage: '',
          isLoading: false,
          isSignedOut: false,
        ));

  Future<void> signOut() async {
    try {
      // Przyklad wylogowania z Firebase Auth
      await FirebaseAuth.instance.signOut();
      emit(const SettingsState(isSignedOut: true));
    } catch (error) {
      emit(SettingsState(errorMessage: error.toString()));
    }
  }
}
