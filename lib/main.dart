import 'dart:async';
import 'dart:convert';
import 'package:myanfobase/model/ProfilePicture.dart';
import 'package:myanfobase/ui/currency.dart';
import 'package:myanfobase/ui/latest_posts.dart';
import 'package:myanfobase/ui/video_player.dart';
import 'package:flutter/material.dart';
import 'package:myanfobase/ui/categories.dart';
import 'package:myanfobase/ui/login.dart';
import 'package:http/http.dart' as http;
import 'package:myanfobase/ui/popular_post.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/User_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            hintColor: Colors.white30,
            backgroundColor: Colors.blue.shade700
        ),
        home: const MainPage()
    );
  }
}
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late SharedPreferences sharedPreferences;
  late List<UserModel> usersList = [];
  late List<ProfilePicture> userProfileList =[];
  late String username ="";
  late String email ="";
  late String imageUrl="";
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    _getUserData();

  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('login') == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (BuildContext context) => const LoginScreen()), (
          Route<dynamic> route) => false);
    }

  }
  var imgnumber =0;
  var arrayImages =['images/bagan2.jpg','images/bg3.jpg'];
  void change() async {
    while(imgnumber<=arrayImages.length-1)
    {
      await Future.delayed(const Duration(seconds: 30));
      setState(() {
        if(imgnumber < arrayImages.length-1){
          imgnumber=1;

        }else if(imgnumber>= arrayImages.length-1){
          imgnumber=0;
        }
      });
    }
  }
  AssetImage imageChange(){
    change();
    return AssetImage(arrayImages[imgnumber]);

  }
  _getUserImage(dynamic profilePicture){
    imageUrl="";
    if(profilePicture.toString().length > 5){
     // print(jsonEncode(profilePicture));
      var data = jsonDecode(jsonEncode(profilePicture));

      for(Map<dynamic, dynamic> p in data){
        userProfileList.add(ProfilePicture.fromJson(p));
      }
      imageUrl=userProfileList[0].filePath.toString() ;

    }else{
      print("No Image");
    }

  }



  @override
  Widget build(BuildContext context) {
    _getUserData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyanFobase'),
        centerTitle: false,
        actions: [
          MaterialButton(onPressed: (){},
              minWidth: 30,
              child: const Icon(Icons.search,color: Colors.white,)),
          MaterialButton(onPressed: (){},
              minWidth: 30,
              child: const Icon(Icons.person,color: Colors.white,))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
                height: 250,
                child: DrawerHeader(
                    decoration: BoxDecoration(
                        color: Colors.blue.shade700,
                        image: DecorationImage(image: imageChange(),
                            fit: BoxFit.fill)

                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Expanded(child: FutureBuilder(
                            future: _getUserData(),
                            builder: (context,AsyncSnapshot<List<UserModel>> snapshot) {
                              if (snapshot.hasData) {
                                String loginMail= sharedPreferences.getString('email').toString();
                                print(sharedPreferences.getString('token'));
                                for(UserModel user in usersList){
                                  if(user.email== loginMail){
                                    username= user.username.toString();
                                    email= user.email.toString();
                                    _getUserImage(user.profilePicture);
                                  }
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    if(imageUrl != "")
                                      CircleAvatar(
                                        radius: 46,
                                        backgroundImage: NetworkImage(imageUrl),
                                      ),
                                    if(imageUrl=="")
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration:  BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.blue.shade700,
                                            ),
                                        child : const Icon(Icons.person,
                                        color: Colors.grey,
                                        size: 60.0),

                                      ),

                                    const SizedBox(height: 25,),
                                    Text(sharedPreferences.getString('username').toString(),
                                      style:const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ) ,
                                    ),
                                    const SizedBox(height: 8,),
                                    Text(sharedPreferences.getString('email').toString(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white
                                      ),)

                                  ],
                                );
                              }

                              return  Column(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration:  BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue.shade700,
                                    ),
                                    child : const Icon(Icons.person,
                                        color: Colors.grey,
                                        size: 60.0),

                                  ),
                                  const SizedBox(height: 25,),
                                  Text(usersList[0].username.toString(),
                                    style:const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ) ,
                                  ),
                                  const SizedBox(height: 8,),
                                  Text(usersList[0].email.toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white
                                    ),)

                                ],
                              );
                            }))
                      ],
                    )
                )
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              iconColor: Colors.blue.shade700,
              title: Text("Home",
                style: TextStyle(
                  color: Colors.blue.shade700,
                ),),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_as_sharp),
              iconColor: Colors.blue.shade700,
              title: Text("Saved",
                style: TextStyle(
                  color: Colors.blue.shade700,
                ),),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite_border_sharp),
              iconColor: Colors.blue.shade700,
              title: Text("Favourites",
                style: TextStyle(
                  color: Colors.blue.shade700,
                ),),
              onTap: (){
                Navigator.pop(context);
              },
            ),

            const Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18.0,0,0,0),
              child: Text("Setting",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue.shade700
                ),),
            ),
            ListTile(
              leading: const Icon(Icons.color_lens_outlined),
              iconColor: Colors.blue.shade700,
              title: Text("Theme",
                style: TextStyle(
                  color: Colors.blue.shade700,
                ),),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock_reset),
              iconColor: Colors.blue.shade700,
              title: Text("Change Password",
                style: TextStyle(
                  color: Colors.blue.shade700,
                ),),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              iconColor: Colors.blue.shade700,
              title: Text("Logout",
                style: TextStyle(
                  color: Colors.blue.shade700,
                ),),
              onTap: (){
                Navigator.pop(context);
              },
            ),

          ],
        ),
      ),
      body: ListView(
        children: const [
          Categories(),
          ShowCurrency(),
          SizedBox(height: 20,),
          PopularPost(),
          LatestPost()

        ],
      ),
    );
  }
  Future<List<UserModel>>_getUserData() async{
    String currencyApi="https://www.myanfobase.com/api/users/alluser";
    http.Response response =await http.get(Uri.parse(currencyApi));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body.toString());
      //print(data);
      usersList.clear();
      for(Map<dynamic,dynamic> i in data){
        usersList.add(UserModel.fromJson(i));
      }

      return usersList;
    }else{

      return usersList;
    }
  }
}



