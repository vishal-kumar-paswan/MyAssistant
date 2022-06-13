import 'package:flutter/material.dart';

import '../../constants.dart';

class DevelopmentTeamSection extends StatelessWidget {
  const DevelopmentTeamSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        centerTitle: true,
        title: const Text(
          'Development Team',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: screenBackground,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 4,
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/dev-Soumyaneel.jpeg'),
              ),
            ),
            const SizedBox(
              height: 65.0,
            ),
            const Text(
              'Soumyaneel Sarkar',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Department of Computer Science',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Kalyani Mahavidyalaya',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 120,
            ),
            Transform.scale(
              scale: 4,
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/dev-Vishal.JPG'),
              ),
            ),
            const SizedBox(
              height: 65.0,
            ),
            const Text(
              'Vishal Kumar Paswan',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Department of Computer Science',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Kalyani Mahavidyalaya',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
