part of 'settings_cubit.dart';

@immutable
class SettingsState {
  const SettingsState({
    this.isLoading = false,
    this.errorMessage = '',
  });

  final bool isLoading;
  final String errorMessage;
}
