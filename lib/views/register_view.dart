import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wasalny/firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }
@override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: const Text('Register'),
        backgroundColor: Colors.blue,
      ),

      body: FutureBuilder(
        future: Firebase.initializeApp(
                    options: DefaultFirebaseOptions.currentPlatform,
              ),
        builder: (context, asyncSnapshot) {
          switch(asyncSnapshot.connectionState){

            case ConnectionState.done:
              return Column(
            children: [
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Email'
                )
              ),
              TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  
                  hintText: 'Password'
                  
                )
              ),
              TextButton(onPressed: () async {
                
          
          
              final email = _email.text;
              final password = _password.text;
              try{
                
              int passwordlength = 8;
              bool hasSpecialCharacter = false;
              bool hasCapitalLetter = false;
              bool hasNumber = false;
              bool isGoodLength = false;
              for(int i = 0; i< password.length; i++){
               if(hasNumber && hasCapitalLetter && hasSpecialCharacter && isGoodLength){
                break;
               }
                    switch(password[i]){
                      case '!':
                      case '@':
                      case '#':
                      case '%':
                      case '^':
                      case '&':
                      case '*':
                      case '(':
                      case ')':
                      case '-':
                      case '_':
                      case '+':
                      case '=':
                      case '`':
                      case '~':
                      case '.':
                      case '/':
                      case '>':
                      case '<':
                      hasSpecialCharacter = true;
                      break;
                      case 'A':
                      case 'B':
                      case 'C':
                      case 'D':
                      case 'E':
                      case 'F':
                      case 'G':
                      case 'H':
                      case 'I':
                      case 'J':
                      case 'K':
                      case 'L':
                      case 'M':
                      case 'N':
                      case 'O':
                      case 'P':
                      case 'Q':
                      case 'R':
                      case 'S':
                      case 'T':
                      case 'U':
                      case 'V':
                      case 'W':
                      case 'X':
                      case 'Y':
                      case 'Z':
                      hasCapitalLetter = true;
                      break;
                      case '0':
                      case '1':
                      case '2':
                      case '3':
                      case '4':
                      case '5':
                      case '6':
                      case '7':
                      case '8':
                      case '9':
                      hasNumber = true;
                      break;
                    }
                    if(i>=passwordlength){
                      isGoodLength = true;
                    }
                  }
                  if(!(hasNumber && hasCapitalLetter && hasSpecialCharacter && isGoodLength)){
                    
                    throw FirebaseAuthException(code: 'password-weak-as-shit');
                  }
                  final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password
                  
              );
              print(userCredential);
              }
              on FirebaseAuthException catch (e){
                if(e.code == 'email-already-in-use' ){
                  print('Email already in use!');
                }
                else if(e.code == 'weak-password'){
                  print('Password weak');
                }
                else if(e.code == 'password-weak-as-shit'){
                  print('Password must be 8 characters long and contain a special character and a capital letter nigga!');
                }
                else if(e.code == 'invalid-email'){
                  print("Invalid Email Entered!");
                }
              }
              
              }, 
              child: const Text('Register')),
            ],
          );
          default:
            return const Text('Loading...');
          }
          
        }
      ),

    );
  }
  }
