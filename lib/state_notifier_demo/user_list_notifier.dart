import 'package:flutter_riverpod/flutter_riverpod.dart';

StateNotifierProvider<UsersNotifier, List<User>> usersProivder = StateNotifierProvider<UsersNotifier, List<User>>(
  (ref) => UsersNotifier([]),
);

class User {
  String name;
  String? place;
  User({
    required this.name,
    this.place,
  });
}

class UsersNotifier extends StateNotifier<List<User>> {
  UsersNotifier(super.state);

  void addUser(User user) {
    state = List.from(state)..add(user);
  }

  void removeUser(String name) {
    state = List.from(state..removeWhere((element) => element.name == name));
  }
}
