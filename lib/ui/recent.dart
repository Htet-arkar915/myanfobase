
import 'package:flutter/material.dart';

class Recent extends StatefulWidget {
  const Recent({Key? key}) : super(key: key);

  @override
  State<Recent> createState() => _RecentState();
}

class _RecentState extends State<Recent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text("Recent Activity" ,style: TextStyle(
              fontSize: 24.0,
              color: Colors.blue,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.6),),
        ),
        const SizedBox(height: 20,),
        Container(
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(5),
            boxShadow:const [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2,
                  offset: Offset(2,4)

              )
            ],
          ),
            child: Column(

              children:[
                Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 20),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow:const [
                            BoxShadow(
                                color: Colors.blueGrey,
                                blurRadius: 2,
                                offset: Offset(2,2)

                            )
                          ],
                        ),
                        child:Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.movie,
                                  size: 40,
                                  color: Colors.blueAccent),
                              Text("Entertainment",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold
                                ),)

                            ]
                        )
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 55),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow:const [
                            BoxShadow(
                                color: Colors.blueGrey,
                                blurRadius: 2,
                                offset: Offset(2,2)

                            )
                          ],
                        ),
                        child:Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.currency_exchange,
                                  size: 40,
                                  color: Colors.blueAccent),
                              Text("Currency",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold
                                ),)

                            ]
                        )
                    )
                  ],
              ),
                ),

                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow:const [
                              BoxShadow(
                                  color: Colors.blueGrey,
                                  blurRadius: 2,
                                  offset: Offset(2,2)

                              )
                            ],
                          ),
                          child:Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.local_movies,
                                    size: 40,
                                    color: Colors.blueAccent),
                                Text("Movies",
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold
                                  ),)

                              ]
                          )
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 55),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow:const [
                              BoxShadow(
                                  color: Colors.blueGrey,
                                  blurRadius: 2,
                                  offset: Offset(2,2)

                              )
                            ],
                          ),
                          child:Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.shop,
                                    size: 40,
                                    color: Colors.blueAccent),
                                Text("Markets",
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold
                                  ),)

                              ]
                          )
                      )
                    ],
                  ),
                )
              ],
            )

        ),
      ],
    );
  }
}
