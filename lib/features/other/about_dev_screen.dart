import 'package:flutter/material.dart';
import '../home/home_screen.dart';

class AboutdevScreen extends StatelessWidget {
  const AboutdevScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Center(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //================================Profile Image==================================================
            //image
            const CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/images/developer.jpg'),
            ),

            SizedBox(
              height: 20,
            ),
//=============================================================================================
            //text.section
            Text("A.D. Janaka Ruwan Kumara",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text("Student ID: K2557618",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 20,),
            Text("Kingston University, BSc (Hons) (top-up)",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
//=============================================================================================
            SizedBox(
              height: 100,
            ),
            //=============================================================================================
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor:Colors.black,
                  minimumSize: Size(200, 50)
              ),
              onPressed: ()
              {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen(title: 'Home Page')));
              },
              child: const Text(
                "Back",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}