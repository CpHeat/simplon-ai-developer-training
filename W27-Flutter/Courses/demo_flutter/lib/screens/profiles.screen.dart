import 'package:demo_flutter/data/person.data.dart';
import 'package:flutter/material.dart';
import '../widgets/profile.widget.dart';

class ProfilesScreen extends StatelessWidget {
  const ProfilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: people.map((person) {
              return ProfileWidget(
                firstName: person.firstName,
                lastName: person.lastName,
                avatar: person.avatar,
                jobTitle: person.jobTitle,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
