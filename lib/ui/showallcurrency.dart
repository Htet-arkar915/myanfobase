import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myanfobase/main.dart';
import 'package:myanfobase/ui/currency.dart';
import 'package:myanfobase/model/Currency_model.dart';

class ShowAllCurrency extends StatefulWidget {
  const ShowAllCurrency({Key? key}) : super(key: key);

  @override
  State<ShowAllCurrency> createState() => _ShowAllCurrencyState();
}

class _ShowAllCurrencyState extends State<ShowAllCurrency> {
  late Future<CurrencyModel> dataFetched;

  ShowData(BuildContext context, String name,Map<String, dynamic> price){
    print(price);
    if(price.keys.toString()== name.toUpperCase()){
      Text(price.values.toString());
    }

  }
  var cList=[ "usd",
  "khr",
  "sgd",
  "idr",
  "lkr",
  "nzd",
  "czk",
  "jpy",
  "php",
  "krw",
  "vnd",
  "hkd",
  "brl",
  "rsd",
  "myr",
  "cad",
  "gbp",
  "ils",
  "sek",
  "nok",
  "dkk",
  "aud",
  "rub",
  "kwd",
  "eur",
  "inr",
  "bnd",
  "zar",
  "npr",
  "cny",
  "chf",
  "pkr",
  "kes",
  "thb",
  "egp",
  "bdt",
  "sar",
  "lak"];
  @override
  void initState() {
    super.initState();

    dataFetched=  getGson();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Currency"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp), onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const MainPage()), (Route<dynamic> route) => false);
        },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow:const [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 2,
                offset: Offset(2,4)

            )
          ],
        ),

        child:  FutureBuilder<CurrencyModel>(
            future: dataFetched,
            builder: (context, snapshot){
              if(snapshot.hasData){
                print(snapshot.data?.info);
                return Container(
                  child: ListView.builder(
                    itemCount: cList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context,int index){
                         var name = cList[index];
                         var price = snapshot.data?.rates.toJson();
                         return ShowData(context, name,price!);
                      }),
                );
              }else{
                Text(snapshot.error.toString());
              }
              return const Center(child: CircularProgressIndicator());
            },
            ),
      ),
    );
  }


}


