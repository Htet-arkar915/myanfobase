import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myanfobase/model/Post_model.dart';
import 'package:http/http.dart' as http;
import 'package:myanfobase/util/util.dart';

class LatestPost extends StatefulWidget {
  const LatestPost({Key? key}) : super(key: key);

  @override
  State<LatestPost> createState() => _LatestPostState();
}

class _LatestPostState extends State<LatestPost> {
  List<PostModel> latestPostList = [];

  Future<List<PostModel>> _getLatestPost() async {
    latestPostList.clear();
    http.Response response = await http.get(Uri.parse(getLatestPostApi));
    var data = jsonDecode(response.body.toString());
    for(Map<String, dynamic>lp in data){
      latestPostList.add(PostModel.fromJson(lp));
    }
    return latestPostList;
  }
  _showLatestPost(BuildContext context, PostModel latestPostList){
    return GestureDetector(
      onTap: (){},
      child: Column(
        children: [
          Text(latestPostList.viewcount.toString())
        ],
      ),
    );

}
  @override
  Widget build(BuildContext context) {
    return Column(
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
        Container(
          height: 100,
          child: FutureBuilder(
            future: _getLatestPost(),
              builder: (context, snapshot){
              if(snapshot.hasData)
                  return ListView.builder(
                      padding: const EdgeInsets.only(left: 10),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: latestPostList.length,
                      itemBuilder: (BuildContext context,int index){
                        return _showLatestPost(context,latestPostList[index]);
              });
              return Text("haha");
    }),
        )
      ],
    );
  }
}
