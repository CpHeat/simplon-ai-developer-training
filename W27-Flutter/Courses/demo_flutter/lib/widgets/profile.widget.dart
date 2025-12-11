import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  
  final String firstName;
  final String lastName;
  final String avatar;
  final String jobTitle;

  const ProfileWidget({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.jobTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue,
            child: Text(avatar, style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$firstName $lastName', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(jobTitle, style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
