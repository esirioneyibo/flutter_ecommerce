import 'package:meta/meta.dart';

/// @immutable metatag means that this class and all of its subtypes are immutable meaning
/// we can't mutate or change the previous state values. When there's a new action
/// dispatched we need to create a brand new copy of state with that new value
@immutable
class AppState {
  final dynamic user;

  // We don't want to create state if the user is not provided (@required)
  AppState({@required this.user});

  factory AppState.initial() {
    return AppState(
      user: null,
    );
  }
}
