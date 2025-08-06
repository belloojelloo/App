
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wasalny/firebase_options.dart';

import 'package:wasalny/views/login_view.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    ),
    );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: const Text('Home'),
        backgroundColor: Colors.green,
      ),

      body: FutureBuilder(
        future: Firebase.initializeApp(
                    options: DefaultFirebaseOptions.currentPlatform,
              ),
        builder: (context, asyncSnapshot) {
          switch(asyncSnapshot.connectionState){

            case ConnectionState.done:
            final user= FirebaseAuth.instance.currentUser;
            if(user?.emailVerified ?? false){
              print('Verified');
            }
            else{
              print('Verify email first');
            }
              return Text('Done');
          default:
            return const Text('Loading...');
          }
          
        }
      ),

    );
  }
}







