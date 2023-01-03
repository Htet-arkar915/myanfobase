import 'package:flutter/material.dart';
import 'dart:math';

import 'package:myanfobase/model/Files.dart';

class PostsImages extends StatefulWidget {
  final List<Files> imageList;
  const PostsImages({Key? key, required this.imageList}) : super(key: key);

  @override
  State<PostsImages> createState() => _PostsImagesState();
}

class _PostsImagesState extends State<PostsImages> {
  int maxImage =0;
  @override
  Widget build(BuildContext context) {
    if(widget.imageList.length<4){
      maxImage=widget.imageList.length;
    }else {
      maxImage=4;
    }
    var images = buildImage();
    return GridView(gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 200,
      crossAxisSpacing: 2,
      mainAxisSpacing: 2,
    ),
    shrinkWrap: true,
    children: images);
  }

  List<Widget> buildImage(){
    int numImages = widget.imageList.length;
    return List<Widget>.generate(min(numImages, maxImage), (index){
      String imageUrl = widget.imageList[index].filePath.toString();
      if(index == maxImage-1) {
        int remainingImage = numImages - maxImage;

        if(remainingImage ==0){
          return GestureDetector(
            onTap: (){},
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                child: Image.network(imageUrl,fit: BoxFit.cover,)),
          );
        }else{
          return GestureDetector(
            onTap: (){},
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    child: Image.network(imageUrl, fit: BoxFit.cover,)),
                Positioned.fill(child: Container(
                  alignment: Alignment.center,
                  color: Colors.black54,
                  child: Text(
                    '+$remainingImage',
                    style: const TextStyle(fontSize: 32,color: Colors.white),
                  ),
                ))
              ],
            ),
          );
        }
      }else{
        return GestureDetector(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          onTap: () {},
        );
      }
    });
  }
}
