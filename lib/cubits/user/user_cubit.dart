import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/user_repository.dart';
import '../../models/user.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;

  UserCubit(this._userRepository) : super(UserInitial());

  Future<void> loadUser() async {
    try {
      emit(UserLoading());
      
      final user = await _userRepository.getCurrentUser();
      
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> updateUserLocation(String location) async {
    try {
      if (state is UserLoaded) {
        final currentUser = (state as UserLoaded).user;
        final updatedUser = currentUser.copyWith(location: location);
        
        await _userRepository.updateUser(updatedUser);
        emit(UserLoaded(updatedUser));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> updateUserProfile({
    String? name,
    String? email,
    String? profileImageUrl,
  }) async {
    try {
      if (state is UserLoaded) {
        final currentUser = (state as UserLoaded).user;
        final updatedUser = currentUser.copyWith(
          name: name,
          email: email,
          profileImageUrl: profileImageUrl,
        );
        
        await _userRepository.updateUser(updatedUser);
        emit(UserLoaded(updatedUser));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  void refreshUser() {
    loadUser();
  }
}

