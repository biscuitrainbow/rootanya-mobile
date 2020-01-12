import 'package:rootanya/redux/token/token_action.dart';
import 'package:redux/redux.dart';

final tokenReducers = combineReducers<String>([
  TypedReducer<String, SaveToken>(_saveToken),
  TypedReducer<String, ClearToken>(_deleteToken),
]);

String _saveToken(
  String state,
  SaveToken action,
) {
  return action.token;
}

String _deleteToken(
  String state,
  ClearToken action,
) {
  return null;
}
