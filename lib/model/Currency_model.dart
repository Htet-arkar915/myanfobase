import 'Rates.dart';

class CurrencyModel {
  CurrencyModel({
      required this.info,
      required this.description,
      required this.timestamp,
      required this.rates,});

 factory CurrencyModel.fromJson(dynamic json) {
    return CurrencyModel(
    info : json['info'],
    description : json['description'],
    timestamp : json['timestamp'],
    rates : (json['rates'] != null ? Rates.fromJson(json['rates']) : null)!,
    );
  }
  String info;
  String description;
  String timestamp;
  Rates rates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['info'] = info;
    map['description'] = description;
    map['timestamp'] = timestamp;
    if (rates != null) {
      map['rates'] = rates.toJson();
    }
    return map;
  }

}