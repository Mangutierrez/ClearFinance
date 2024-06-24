import 'package:flutter/material.dart';

class ProfileModel {
  String name;
  String email;
  int age;
  String gender;
  String bio;
  ImageProvider avatar;

  ProfileModel({
    required this.name,
    required this.email,
    required this.age,
    required this.gender,
    required this.bio,
    required this.avatar,
  });
}
