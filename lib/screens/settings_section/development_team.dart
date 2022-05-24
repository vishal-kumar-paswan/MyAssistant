import 'package:flutter/material.dart';

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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 0, 0, 0),
              Color.fromARGB(255, 13, 4, 44),
            ],
          ),
        ),
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
              height: 60.0,
            ),
            const Text(
              'Soumyaneel Sarkar',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Department of Computer Science',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            const SizedBox(
              height: 110,
            ),
            Transform.scale(
              scale: 4,
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/dev-Vishal.JPG'),
              ),
            ),
            const SizedBox(
              height: 60.0,
            ),
            const Text(
              'Vishal Kumar Paswan',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Department of Computer Science',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
