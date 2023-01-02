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
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text("Currency Exchange" ,style: TextStyle(
                fontSize: 24.0,
                color: Colors.blue,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.6),),
          ),
          const SizedBox(height: 20,),
          Container(
            width: 1024,
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
                        fontWeight: FontWeight.bold
                    ),
                    ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                        child: Row(
                          children: [
                            const Text("USD",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),),
                            const SizedBox(width: 185,),
                            Text(snapshot.data!.rates.usd,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),
                            )
                          ],

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text("SGD",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),),
                            const SizedBox(width: 185,),
                            Text(snapshot.data!.rates.sgd,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text("THB",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),),
                            const SizedBox(width: 185,),
                            Text(snapshot.data!.rates.thb,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text("INR",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),),
                            const SizedBox(width: 190,),
                            Text(snapshot.data!.rates.inr,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],

                        ),
                      ),
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
                  return Text(snapshot.error.toString());
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
