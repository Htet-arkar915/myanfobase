import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:myanfobase/main.dart';
import 'package:http/http.dart' as http;
import 'package:myanfobase/ui/PostImagesShow.dart';
import 'package:myanfobase/util/util.dart';

import 'package:myanfobase/model/Post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Files.dart';

class NewsFeed extends StatefulWidget {
  final String catName;
  final String catId;
  const NewsFeed({Key? key, required  this.catName, required  this.catId}) : super(key: key);

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  String favCount="";
  double halfScreen = 0;
  List<Files> postImageList =[];
  List<PostModel> allPostList = [];
  _getAllPost() async{
    http.Response response = await http.get(Uri.parse(getAllPostApi));
    var data = jsonDecode(response.body.toString());
    allPostList.clear();
    for(Map<String, dynamic> p in data){
      if(PostModel.fromJson(p).cateId.toString() == widget.catId && PostModel.fromJson(p).postAccept == true) {
        allPostList.add(PostModel.fromJson(p));
      }
    }
    //favCount= "${allPostList.length} favourites";
  }

  _getPostImageList(dynamic files){
    postImageList.clear();
    if(files.toString().length> 5){
      var data = jsonDecode(jsonEncode(files).toString());

      for(Map<dynamic,dynamic> p in data){
        postImageList.add(Files.fromJson(p));
      }
      print("image ${postImageList.length}");
    }
  }
  _getFavouriteCount(String? id) async{
    favCount="";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    http.Response response = await http.post(Uri.parse(getPostFavApi),
        headers: {'Authorization': 'Bearer $token'},
        body: {
      '_id' : id,
        }
    );
    var data = jsonDecode(response.body.toString());
    //print(' fav ${data['FavNumber']}');
    favCount = ' ${data['FavNumber']} ';

  }
  _showPost(BuildContext context, PostModel post){
    halfScreen = MediaQuery.of(context).size.width/2;
    _getPostImageList(post.files);
    return GestureDetector(
      onTap: (){},
      child: Container(

        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(1),
        decoration:  const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
          boxShadow:[
            BoxShadow(
                color: Colors.grey,
                blurRadius: 1,
                offset: Offset(1,2)

            )
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if(post.userprofile.toString() != "")
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(post.userprofile.toString()),
                  ),
                if(post.userprofile.toString() == "")
                  Container(
                    width: 40,
                    height: 40,
                    decoration:  BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.shade700,
                    ),
                    child : const Icon(Icons.person,
                        color: Colors.grey,
                        size: 20.0),

                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(post.username.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),),
                ),
                const Spacer(),
                IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert_sharp,))
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
              child: Text(post.title.toString().length >70?"${post.title.toString().substring(0,70)}..." : post.title.toString(),
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
              child: Text(post.description.toString().length >100?"${post.description.toString().substring(0,100)} see more..." : post.description.toString(),
                style: const TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.normal
                ),),
            ),

            if(postImageList.length ==2 || postImageList.length>=4)
              PostsImages(imageList :postImageList),
            if(postImageList.length==1)
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                child: Image.network(postImageList[0].filePath.toString(),
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            if(postImageList.length ==3)
              Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                        child: Image.network(postImageList[0].filePath.toString(),
                          fit: BoxFit.cover,
                          width: halfScreen-12,
                          height: halfScreen,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                          child: Image.network(postImageList[1].filePath.toString(),
                            fit: BoxFit.cover,
                            width: halfScreen-12,
                            height: halfScreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2,),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    child: Image.network(postImageList[2].filePath.toString(),
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 5,),
            Row(
              children: [
                FutureBuilder(
                    future: _getFavouriteCount(post.id),
                    builder: (context, snapshot){
                      return Row(
                        children :
                            [
                          const Icon(Icons.favorite_border_sharp,color: Colors.grey,),
                          Text(
                            favCount,)
                      ]
                      );
                    }),
                const Spacer(),
                Row(
                  children:  [
                    const Icon(Icons.remove_red_eye_outlined,color: Colors.grey,),
                    Text(
                      '  ${post.viewcount} views',)
                  ],
                ),
              ],
            ),
            /*const Divider(height: 5,
              color: Colors.grey,),*/
            Row(
              children: [
                SizedBox(
                  width: halfScreen-10,
                    child: OutlinedButton(
                      onLongPress: (){
                      },
                      onPressed: () {  },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Row(
                          children:  const [
                            Icon(Icons.favorite_border_sharp,color: Colors.grey,),
                            Text(
                              'Favourite',)
                          ],
                        ),
                      ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: halfScreen-10,
                  child: OutlinedButton(
                    onLongPress: (){
                    },
                    onPressed: () {  },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Row(
                        children:  const [
                          Icon(Icons.share,color: Colors.grey,),
                          Text(
                            'Share',)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    //print('${widget.catName}');
    _getAllPost();
    return WillPopScope(
        onWillPop: () async{
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const MainPage()), (Route<dynamic> route) => false);
          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.blue.shade700,
            title: Text(widget.catName),
            leading: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: (const Icon(Icons.arrow_back_sharp))),
          ),
          body: Container(
            margin: const EdgeInsets.only(top: 2),
            child: FutureBuilder(
              future: _getAllPost(),
              builder: (context, snapshot) {
                return ListView.builder(
                    itemCount: allPostList.length,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context,int index){
                      return _showPost(context, allPostList[index]);
                    });
              },

            ),
          ),
        ));
  }
}
