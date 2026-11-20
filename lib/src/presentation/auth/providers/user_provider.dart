import 'package:gelismis_asansor_projesi/src/data/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
class CurrentUser extends _$CurrentUser {
  @override
  UserModel? build() {
    // Şimdilik mock veri dönüyoruz, ileride giriş yapan kullanıcının bilgileri veritabanından alınacak
    return UserModel(
      serverId: 'mock_user_1',
      username: 'mehmetusta',
      fullName: 'Mehmet Usta',
      companyName: 'Akel Asansör',
      token: 'mock_token',
    );
  }

  void setUser(UserModel user) {
    state = user;
  }

  void clearUser() {
    state = null;
  }
}
