import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:myanfobase/model/Currency_model.dart';
import 'package:myanfobase/model/Rates.dart';
import 'package:myanfobase/ui/showallcurrency.dart';

class ShowCurrency extends StatefulWidget {
  const ShowCurrency({Key? key}) : super(key: key);

  @override
  State<ShowCurrency> createState() => _ShowCurrencyState();
}

class _ShowCurrencyState extends State<ShowCurrency> {

  late Future<CurrencyModel> dataFetched;

  @override
  void initState() {
    super.initState();
    dataFetched = getGson();

  }


  @override
  Widget build(BuildContext context) {
    //print(dataFetched);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text("Currency Exchange" ,style: TextStyle(
                fontSize: 24.0,
                color: Colors.black,
                fontWeight: FontWeight.w400,
                ),),
          ),
          const SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                Colors.blueGrey,
                Colors.black12,
                Colors.blueGrey
              ]),

              borderRadius: BorderRadius.circular(5),
              border: const Border.symmetric(horizontal: BorderSide(color: Colors.black12,width: 1),
                  vertical: BorderSide(color: Colors.black12,width: 1)),
              boxShadow:const [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 1,
                    offset: Offset(1,2)

                )
              ],
            ),
            child: FutureBuilder<CurrencyModel>(
              future: dataFetched,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text(snapshot.data!.info,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400
                    ),
                    ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                        child: Row(
                          children: [
                            const Text("USD",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400
                            ),),
                            const Spacer(),
                            Text(snapshot.data!.rates.usd,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400
                                ),
                            )
                          ],

                        ),
                      ),
                      const Divider(height: 1,
                      color: Colors.white38,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text("SGD",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400
                              ),),
                            const Spacer(),
                            Text(snapshot.data!.rates.sgd,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400
                              ),
                            )
                          ],

                        ),
                      ),
                      const Divider(height: 1,
                        color: Colors.white38,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text("THB",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400
                              ),),
                            const Spacer(),
                            Text(snapshot.data!.rates.thb,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400
                              ),
                            )
                          ],

                        ),
                      ),
                      const Divider(height: 1,
                        color: Colors.white38,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text("INR",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400
                              ),),
                            const Spacer(),
                            Text(snapshot.data!.rates.inr,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400
                              ),
                            )
                          ],

                        ),
                      ),
                      const Divider(height: 1,
                        color: Colors.white38,),
                       const SizedBox(height: 8,),
                       GestureDetector(
                         child: const Text("see more>>",
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 14,
                         ),),
                         onTap: (){
                           Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const ShowAllCurrency(),), (Route<dynamic> route) => false);
                         },
                       )
                    ],
                  );
                }else{
                  return const Text("Waiting Connection....");
                }
                return const CircularProgressIndicator();
              },
            )
          )
        ]
    );
  }

}
Future<CurrencyModel> getGson() async{
  String currencyApi="https://forex.cbm.gov.mm/api/latest";
  http.Response response =await http.get(Uri.parse(currencyApi));
  return CurrencyModel.fromJson(json.decode(response.body));

}
