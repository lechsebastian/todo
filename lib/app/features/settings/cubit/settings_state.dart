part of 'settings_cubit.dart';

@immutable
class SettingsState {
  const SettingsState({
    this.isLoading = false,
    this.errorMessage = '',
    this.isSignedOut = false,
  });

  final bool isLoading;
  final String errorMessage;
  final bool isSignedOut;
}
