import 'package:flutter/material.dart';
import 'package:myanfobase/model/Files.dart';
import 'package:myanfobase/model/Post_model.dart';

class ViewPostDetail extends StatefulWidget {
  final PostModel post;
  final String favCount;
  final List<Files> postImage;
  const ViewPostDetail({Key? key, required  this.post, required this.favCount, required this.postImage}) : super(key: key);

  @override
  State<ViewPostDetail> createState() => _ViewPostDetailState();
}

class _ViewPostDetailState extends State<ViewPostDetail> {
  _showImage(BuildContext context,String imageUrl){
    return GestureDetector(
      onTap: (){
      },
      child: Container(
        // child: Image.network(imageUrl)
      ),

    );
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
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
                      backgroundImage: NetworkImage(widget.post.userprofile.toString()),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(widget.post.username.toString(),
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(widget.post.createdAt.toString().substring(0,10),
                            style: const TextStyle(
                              fontSize: 14,
                            ),),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 8,),
                Text(widget.post.title.toString(),
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,

                  ),),
                const SizedBox(height: 8,),
                Text(widget.post.description.toString(),
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontSize: 14
                  ),),
                const SizedBox(height: 8,),
                ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: widget.postImage.length,
                    itemBuilder: (BuildContext context, int index){
                      String img = widget.postImage[index].filePath.toString();
                      return Image(image: NetworkImage(img),width: MediaQuery.of(context).size.width,fit: BoxFit.cover,);
                    }),
                const SizedBox(height: 8,),
                Row(
                  children: [
                    Row(
                        children :
                        [
                          const Icon(Icons.favorite_border_sharp,color: Colors.grey,),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              widget.favCount.toString()==""? "0" : widget.favCount,),
                          )
                        ]
                    ),
                    const Spacer(),
                    Row(
                      children:  [
                        const Icon(Icons.remove_red_eye_outlined,color: Colors.grey,),
                        Text(
                          '  ${widget.post.viewcount} views',)
                      ],
                    ),
                  ],
                ),

                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width/2-14,
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
                      width: MediaQuery.of(context).size.width/2-14,
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
        ),
      ),
    );
  }
}
