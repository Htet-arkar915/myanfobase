import 'package:flutter/material.dart';
import 'package:myanfobase/model/Files.dart';
import 'package:myanfobase/model/Post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewPostDetail extends StatefulWidget {
  final PostModel post;
  final String favCount;
  final List<Files> postImage;

  const ViewPostDetail(
      {Key? key,
      required this.post,
      required this.favCount,
      required this.postImage})
      : super(key: key);

  @override
  State<ViewPostDetail> createState() => _ViewPostDetailState();
}

class _ViewPostDetailState extends State<ViewPostDetail> {
  var isFavorite = false;
  int favoriteItemCount = 0;
  static const likeKey = 'liked_key';

  @override
  void initState() {
    super.initState();
    getAllSaveData();
  }

  getAllSaveData() async {
    print('got preference');
    SharedPreferences pref = await SharedPreferences.getInstance();
   setState(() {

     if(isFavorite!=false){
       isFavorite=pref.getBool(likeKey)!;
     }
     else{

     }
     //isFavorite=pref.getBool(likeKey)!;
   });



  }

  /*_showImage(BuildContext context,String imageUrl){
    return GestureDetector(
      onTap: (){
      },
      child: Container(
        // child: Image.network(imageUrl)
      ),

    );
  }*/
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: const EdgeInsets.fromLTRB(12, 40, 12, 8),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          NetworkImage(widget.post.userprofile.toString()),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            widget.post.username.toString(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            widget.post.createdAt.toString().substring(0, 10),
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.post.title.toString(),
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.post.description.toString(),
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 8,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: widget.postImage.length,
                    itemBuilder: (BuildContext context, int index) {
                      String img = widget.postImage[index].filePath.toString();
                      return Image(
                        image: NetworkImage(img),
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      );
                    }),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Row(children: [
                      Icon(
                        Icons.favorite_border_sharp,
                        color: isFavorite ? Colors.red : null,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          widget.favCount.toString() == ""
                              ? "0"
                              : favoriteItemCount.toString(),
                        ),
                      )
                    ]),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(
                          Icons.remove_red_eye_outlined,
                          color: Colors.grey,
                        ),
                        Text(
                          '  ${widget.post.viewcount} views',
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 14,
                      child: OutlinedButton(
                        onLongPress: () {},
                        onPressed: () async {
                          if (isFavorite) {
                            isFavorite = !isFavorite;
                            favoriteItemCount -= 1;
                          } else {
                            isFavorite = false;
                            favoriteItemCount += 1;
                            isFavorite = !isFavorite;
                          }
                          var preference =
                              await SharedPreferences.getInstance();
                          preference.setBool(likeKey, isFavorite);
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Row(
                            children: [
                              Icon(
                                Icons.favorite_border_sharp,
                                color: isFavorite ? Colors.red : null,
                              ),
                              Text(
                                'Favourite',
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 14,
                      child: OutlinedButton(
                        onLongPress: () {},
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.share,
                                color: Colors.grey,
                              ),
                              Text(
                                'Share',
                              )
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
        ),
      ),
    );
  }
}
