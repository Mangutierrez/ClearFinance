import 'package:flutter/material.dart';
import 'package:clear_finance/model/profile_model.dart';

class ProfileData {
  static ProfileModel profile = ProfileModel(
    name: 'Helena Ortiz',
    email: 'helena.ortiz@clearfinance.com',
    age: 30,
    gender: 'Femenino',
    bio: 'Helena es una apasionada analista financiera con más de 8 años de experiencia en la industria.',
    avatar: AssetImage('assets/images/logo.png'),
  );
}
