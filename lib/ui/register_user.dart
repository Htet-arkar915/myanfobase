import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:myanfobase/ui/login.dart';
import 'package:http/http.dart' as http;
class UserRegister extends StatefulWidget {
  const UserRegister({Key? key}) : super(key: key);

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  String _errorMessage = "valid";
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async{
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()), (Route<dynamic> route) => false);
        return true;
      },
      child: Scaffold(

          backgroundColor: Colors.blue.shade700,
          body: Container(
            margin: const EdgeInsets.fromLTRB(0, 100, 0, 0),
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child :Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Center(
                      child: Text("Register",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          shadows: [
                            Shadow(
                              color: Colors.grey,
                              offset: Offset(2, 2),
                              blurRadius: 2
                            )
                          ],
                          fontFamily: 'Sevillana',
                          fontWeight: FontWeight.bold,
                        ),),
                    ),
                    const SizedBox(height: 80,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          style: const TextStyle(
                              color: Colors.white
                          ),
                          controller: usernameController,
                          decoration: InputDecoration(
                              hintText: "Enter Username",
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
                              prefixIcon:  Icon(Icons.person,color: Theme.of(context).cardColor,)
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
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
                              prefixIcon:  Icon(Icons.email,color: Theme.of(context).cardColor,)
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          style: const TextStyle(
                              color: Colors.white
                          ),
                          controller: passwordController,
                          decoration: InputDecoration(
                              hintText: "Enter Password",
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
                              prefixIcon:  Icon(Icons.lock,color: Theme.of(context).cardColor,)
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          style: const TextStyle(
                              color: Colors.white
                          ),
                          controller: confirmPasswordController,
                          decoration: InputDecoration(
                              hintText: "Confirm Password",
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
                              prefixIcon:  Icon(Icons.lock,color: Theme.of(context).cardColor,)
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(onPressed: (){
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=> const LoginScreen()), (Route<dynamic> route) => false);
                            },
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(const EdgeInsets.fromLTRB(40, 20, 40, 20)),


                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                        side: BorderSide(
                                            color: Colors.white
                                        )
                                    )
                                ),),
                              child: const Text("Back"),
                            ),
                            const SizedBox(width: 40,),
                            ElevatedButton(
                              onPressed: (){
                                _GoToRegister(usernameController.text.toString(),emailController.text.toString(),passwordController.text.toString(),confirmPasswordController.text.toString());
                            },
                              style: ButtonStyle(
                              padding: MaterialStateProperty.all(const EdgeInsets.fromLTRB(40, 20, 40, 20)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    side: BorderSide(color:  Colors.white)
                                  )
                                )
                              ),
                              child: const Text("Register"),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
  void _GoToRegister(String username, String email, String password, String confirmPassword){
    if(password.length <8){
      const snack = SnackBar(content: Text("Password must have at least 8 digits"),backgroundColor: Colors.blue,);
      ScaffoldMessenger.of(context).showSnackBar(snack);
    }else if(!password.contains(RegExp(r'[a-z]')) || !password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) || !password.contains(RegExp(r'[0-9]'))){
      const snack = SnackBar(content: Text("Password must have at least 1 of number, character and special character"),backgroundColor: Colors.blue,);
      ScaffoldMessenger.of(context).showSnackBar(snack);
    }else if(password!=confirmPassword){
      const snack = SnackBar(content: Text("Password and Confirm password are not matched"),backgroundColor: Colors.blue,);
      ScaffoldMessenger.of(context).showSnackBar(snack);
    }else if(username.isEmpty){
      const snack = SnackBar(content: Text("Please enter User Name"),backgroundColor: Colors.blue,);
      ScaffoldMessenger.of(context).showSnackBar(snack);
    }else{
      validateEmail(email, username, password);
    }

  }
  void validateEmail(String email,String username,String password) {
   // print("hello");
    if(email.isEmpty){
      setState(() {
        _errorMessage = "Email can not be empty";
      });
    }else if(!EmailValidator.validate(email, true)){
      setState(() {
        _errorMessage = "Invalid Email Address";
      });
    }else{
      setState(() {
        _errorMessage = "";
      });
    }
    if(_errorMessage!="") {
      var snack = SnackBar(
        content: Text(_errorMessage), backgroundColor: Colors.blue,);
      ScaffoldMessenger.of(context).showSnackBar(snack);
    }else{
      Register(username,email,password);
    }
  }
  void Register(String username, String email, String password) async{
    try{
      http.Response response = await http.post(
          Uri.parse("https://www.myanfobase.com/api/users"),
          body: {
            'username' : username,
            'email' : email,
            'password' : password
          }
      );
      if(response.statusCode ==200){
        var snack = const SnackBar(
          content: Text("Verification email sent"), backgroundColor: Colors.blue,);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(snack);
      }
    }catch(e){
      print(e.toString());
    }
    
  }
}
