import 'package:flutter/material.dart';
import 'package:myanfobase/model/posts.dart';
class PopularPost extends StatefulWidget {
  const PopularPost({Key? key}) : super(key: key);

  @override
  State<PopularPost> createState() => _PopularPostState();
}

class _PopularPostState extends State<PopularPost> {
  String _getDescription(String description){
    String sampleDescription= "${description.substring(0,40)}...";
    return sampleDescription;
  }
  showPopularPosts(BuildContext context, Posts posts){
    return GestureDetector(

      onTap: (){

      },
        child: Container(
          width: 160,
          margin: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
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
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(20)),

                          child :Image(image: AssetImage(posts.image),height: 120,width: 150,
                            fit: BoxFit.fill,),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(posts.title,style: const TextStyle(
                          color: Colors.blue,
                          letterSpacing: 0.6,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),),
                      ),

                         Expanded(
                           child: Container(
                             padding: const EdgeInsets.all(8.0),
                             child: Text(_getDescription(posts.description),style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 13.5,
                               overflow: TextOverflow.clip,
                               letterSpacing: 0.4
                        ),),
                           ),
                         ),
                    ],

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
      children:  [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text("Popular Posts" ,style: TextStyle(
              fontSize: 24.0,
              color: Colors.blue,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.6,
          ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 300,
          child: ListView.builder(
              padding: const EdgeInsets.only(left: 10),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index){
                Posts p = posts[index];
                return showPopularPosts(context,p);
              }),
        )
      ],
    );
  }
}
