import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myanfobase/model/UserData.dart';
import 'package:myanfobase/ui/register_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade700,
      /* appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        title: const Text("Singn In",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),),
        centerTitle: true,
      ),*/
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
        decoration: BoxDecoration(
            color: Colors.blue.shade700
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),

                  child: Image(image: AssetImage("images/logo.png"),
                    height: 150.0,
                    width: 150.0,),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      TextField(
                        style: const TextStyle(
                            color: Colors.white

                        ),
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Enter Email",
                          hintStyle: const TextStyle(
                              color: Colors.grey
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(width: 1.0,
                                  color: Colors.white)
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide:  BorderSide(width: 1.0,
                                color: Theme.of(context).cardColor),
                          ),

                          prefixIcon:  Icon(Icons.email,color: Theme.of(context).cardColor,),
                        ),

                      ),
                      const SizedBox(height: 20.0,),
                      TextField(
                        style: TextStyle(
                            color: Colors.white
                        ),
                        controller: passwordController,
                        decoration: InputDecoration(
                            hintText: "Enter Password",
                            hintStyle: TextStyle(
                                color: Colors.grey
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(width: 1.0,
                                    color: Colors.white)
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide:  BorderSide(width: 1.0,
                                  color: Theme.of(context).cardColor),
                            ),
                            prefixIcon:  Icon(Icons.lock,color: Theme.of(context).cardColor,)
                        ),
                      ),
                      const SizedBox(height: 40,),
                      GestureDetector(
                        onTap: (){
                          login(emailController.text.toString(),passwordController.text..toString());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(30)
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: const Center(
                            child: Text("Sign In",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
                              ),),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30,),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const UserRegister(),), (Route<dynamic> route) => false);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: const Center(
                            child: Text("Sign Up",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
                              ),),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login(String email, String password) async {
    try{
      http.Response response =await http.post(
          Uri.parse('https://www.myanfobase.com/api/users/login'),
          body: {
            'loginemail' : email,
            'loginpassword' : password
          }
      );
      if(response.statusCode==200){
        var data =jsonDecode(response.body.toString());
        print(data);
        UserData userdata = UserData.fromJson(data);
        print(userdata.username);
        SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
        if (userdata.verified == true) {
        setState(() {

            sharedPreferences.setString('login', 'success');
            sharedPreferences.setString('email', email);
            sharedPreferences.setString('token', userdata.token.toString());
            sharedPreferences.setString('username', userdata.username.toString());
            sharedPreferences.setString('userId', userdata.id.toString());
            sharedPreferences.setString('isAdmin', userdata.isAdmin.toString());
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                builder: (BuildContext context) => const MainPage()), (
                Route<dynamic> route) => false);

        }

          );
        }else{
          var snack = const SnackBar(
            content: Text("You need to verify your email"), backgroundColor: Colors.blue,);
          ScaffoldMessenger.of(context).showSnackBar(snack);
        }

        print("Login Success");
      }else{
        var snack = const SnackBar(
          content: Text("Email or password is incorrect"), backgroundColor: Colors.blue,);
        ScaffoldMessenger.of(context).showSnackBar(snack);
      }

    }catch(e){
      print(e.toString());
    }
  }
}
