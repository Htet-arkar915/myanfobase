import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myanfobase/model/Category_model.dart';
import 'package:http/http.dart' as http;
import 'package:myanfobase/ui/news_feed.dart';
import 'package:myanfobase/util/util.dart';

class Categories extends StatefulWidget {

  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late List<CategoryModel> categories =[];
  var categoryList= ['Entertainment','Currency','Food','Transportation','Markets','Movies'];
  var colors =[Colors.blue,Colors.red,Colors.grey,Colors.green,Colors.yellow,Colors.deepOrange];
  _showCategories(BuildContext context, String category, Color randomColor, String catId){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => NewsFeed(catName : category, catId : catId)));
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            padding: const EdgeInsets.all(10.0),
            decoration:  BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: randomColor,
              boxShadow:const [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2,
                    offset: Offset(2,4)

                )
              ],
            ),
            child: Text(category,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),),
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    //getAllCategory();
    return SizedBox(
      height: 90,
        child:FutureBuilder(
          future : getAllCategory(),
          builder : (context , snapshot) {
            return ListView.builder(
                padding: const EdgeInsets.only(left: 10),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  print(index);
                  String category = categories[index].catename.toString();
                  Random rnd = Random();
                  var color = colors[0 + rnd.nextInt(colors.length-1)];
                  return _showCategories(context, category, color,categories[index].id.toString());
                });
          }

      ),
    );
  }
 
  Future<List<CategoryModel>> getAllCategory() async{
    categories.clear();
    http.Response response= await http.get(Uri.parse(getAllCategoryApi));
    var data = jsonDecode(response.body.toString());
    for(Map<String, dynamic> c in data){
      categories.add(CategoryModel.fromJson(c));
    }
    return categories;
  }
}


