import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myanfobase/main.dart';
import 'package:http/http.dart' as http;
import 'package:myanfobase/util/util.dart';

import 'package:myanfobase/model/Post_model.dart';

class NewsFeed extends StatefulWidget {
  final String catName;
  final String catId;
  const NewsFeed({Key? key, required  this.catName, required  this.catId}) : super(key: key);

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  List<PostModel> allPostList = [];
  _getAllPost() async{
    http.Response response = await http.get(Uri.parse(getAllPostApi));
    var data = jsonDecode(response.body.toString());
    allPostList.clear();
    for(Map<String, dynamic> p in data){
      if(PostModel.fromJson(p).cateId.toString() == widget.catId) {
        allPostList.add(PostModel.fromJson(p));
      }
    }
    print("data ${allPostList.length}");
  }

  _showPost(BuildContext context, PostModel post){
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(1),
      decoration:  const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
        boxShadow:[
          BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
              offset: Offset(2,4)

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
                  radius: 15,
                  backgroundImage: NetworkImage(post.userprofile.toString()),
                ),
                if(post.userprofile.toString() == "")
                  Container(
                    width: 30,
                    height: 30,
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
                    fontSize: 16,
                  ),),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 2, 10, 2),
              child: Text(post.title.toString().length >70?"${post.title.toString().substring(0,70)}..." : post.title.toString(),
              style: const TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.bold
              ),),
            )
          ],
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
          backgroundColor: Colors.white70,
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
