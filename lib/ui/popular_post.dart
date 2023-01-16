import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myanfobase/ui/view_post_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/Files.dart';
import '../model/Post_model.dart';
import '../util/util.dart';

class PopularPost extends StatefulWidget {
  const PopularPost({Key? key}) : super(key: key);

  @override
  State<PopularPost> createState() => _PopularPostState();
}

class _PopularPostState extends State<PopularPost> {
  String favCount = "";
  List<PostModel> trendingPost = [];
  List<Files> postImageList = [];

  _getFavouriteCount(String? id) async {
    favCount = "";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    http.Response response =
        await http.post(Uri.parse(getPostFavApi), headers: {
      'Authorization': 'Bearer $token'
    }, body: {
      '_id': id,
    });
    var data = jsonDecode(response.body.toString());
    favCount = "${data['FavNumber']}";
  }

  _getPostImageList(dynamic files) {
    postImageList.clear();
    if (files.toString().length > 5) {
      var data = jsonDecode(jsonEncode(files).toString());

      for (Map<dynamic, dynamic> p in data) {
        postImageList.add(Files.fromJson(p));
      }
      print("image ${postImageList.length}");
    }
  }

  _showPost(BuildContext context, PostModel postModel) {
    _getPostImageList(postModel.files);
    _getFavouriteCount(postModel.id);
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ViewPostDetail(
                      post: postModel,
                      favCount: favCount,
                      postImage: postImageList)));
        },
        child: Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          width: 350,
          height: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                    margin: EdgeInsets.only(left: 10.0),
                    width: 350,
                    height: 150.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                            image: NetworkImage(
                                postImageList[0].filePath.toString()),
                            fit: BoxFit.cover))),
              ),
              Container(
                margin: EdgeInsets.all(8.0),
                width: 170,
                child: Text(
                  postModel.title.toString(),
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                ),
              )
            ],
          ),
        )



        );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "Trending Posts",
            style: TextStyle(
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
                future: _getGson(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: trendingPost.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(index);
                        PostModel postModel = trendingPost[index];
                        return _showPost(context, postModel);
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }))
      ],
    );
  }

  Future<List<PostModel>> _getGson() async {
    String trendingApi = getTrendingPostApi;
    http.Response response = await http.get(Uri.parse(trendingApi));
    var jsonData = json.decode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in jsonData) {
        trendingPost.add(PostModel.fromJson(i));
      }
      return trendingPost;
    } else {
      return trendingPost;
    }
  }
}
