import 'package:flutter/material.dart';
import 'package:clear_finance/model/profile_model.dart';

class ProfileData {
  static ProfileModel profile = ProfileModel(
    name: 'Helena Hills',
    email: 'name@domain.com',
    age: 25,
    gender: 'Femenino',
    bio: 'Aenean at arcu at purus venenatis vulputate. Sed tellus felis, eleifend sed ligula quis, viverra convallis orci. Donec eu justo vel magna vehicula porttitor at in nunc. Duis eu orci elit. Nam et lorem in nisi facilisis eleifend. Pellentesque sit amet imperdiet felis. Proin rhoncus ligula vel tellus congue, vel.',
    avatar: AssetImage('assets/foto_perfil.jpg'),
  );
}
