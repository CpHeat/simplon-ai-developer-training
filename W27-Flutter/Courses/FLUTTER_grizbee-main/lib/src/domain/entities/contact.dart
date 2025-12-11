import 'package:flutter/material.dart';

class Contact {
  UniqueKey id = UniqueKey();
  String name;
  String? picture;
  String address;
  String email;

  Contact({required this.name, this.picture, required this.address, required this.email});
}