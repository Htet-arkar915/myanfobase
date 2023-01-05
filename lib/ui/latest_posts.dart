import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myanfobase/model/Post_model.dart';
import 'package:http/http.dart' as http;
import 'package:myanfobase/util/util.dart';

import 'package:myanfobase/model/Files.dart';

class LatestPost extends StatefulWidget {
  const LatestPost({Key? key}) : super(key: key);

  @override
  State<LatestPost> createState() => _LatestPostState();
}

class _LatestPostState extends State<LatestPost> {
  String latestPostImage ="https://myanfobase.sgp1.digitaloceanspaces.com/uploads/2022-12-28T08-07-31.687Z-arts.jpg";
  List<PostModel> latestPostList = [];

  Future<List<PostModel>> _getLatestPost() async {
    latestPostList.clear();
    http.Response response = await http.get(Uri.parse(getLatestPostApi));
    var data = jsonDecode(response.body.toString());
    for(Map<String, dynamic>lp in data){
      latestPostList.add(PostModel.fromJson(lp));
    }
    //print(latestPostList.length);
    return latestPostList;
  }
  _getPostImageList(dynamic files){
    List<Files> postImageList =[];
    if(files.toString().length> 5){
      var data = jsonDecode(jsonEncode(files).toString());

      for(Map<dynamic,dynamic> p in data){
        postImageList.add(Files.fromJson(p));
      }
      latestPostImage=postImageList[0].filePath.toString();
    }
  }


  _showLatestPost(BuildContext context, PostModel latestPost){
    _getPostImageList(latestPost.files);
    return GestureDetector(
      onTap: (){},
      child: Container(
        width: 260,
        margin: const EdgeInsets.all(8.0),
        decoration:  BoxDecoration(
          image: DecorationImage(image: NetworkImage(latestPostImage),
              fit: BoxFit.cover),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow:const [
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
            Container(
              margin: const EdgeInsets.fromLTRB(4, 4, 4, 4),
              padding: const EdgeInsets.all(5.0),
              decoration:  const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.black38,
              ),
              child: Text(latestPost.cateName.toString(),
              style: TextStyle(
                color: Colors.white
              ),),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 60),
                height: 160,
                decoration: const BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundImage: NetworkImage(latestPost.userprofile.toString()),
                          ),
                          Padding(padding: const EdgeInsets.only(left: 8),
                          child: Text(latestPost.username.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                          ),),)

                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(latestPost.title.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87
                          ),),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text("Latest Posts" ,style: TextStyle(
            fontSize: 24.0,
            color: Colors.blue,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
          ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: FutureBuilder(
              future: _getLatestPost(),
              builder: (context, snapshot){
                if(snapshot.hasData) {
                  return ListView.builder(
                      padding: const EdgeInsets.only(left: 10),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: latestPostList.length,
                      itemBuilder: (BuildContext context,int index){
                        return _showLatestPost(context,latestPostList[index]);
                      });
                }
                return const CircularProgressIndicator();
              }),
        )
      ],
    );
  }
}
