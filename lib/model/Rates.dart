class Rates {
  Rates({
      required this.usd,
      required this.khr,
      required this.sgd,
      required this.idr,
      required this.lkr,
      required this.nzd,
      required this.czk,
      required this.jpy,
      required this.php,
      required this.krw,
      required this.vnd,
      required this.hkd,
      required this.brl,
      required this.rsd,
      required this.myr,
      required this.cad,
      required this.gbp,
      required this.ils,
      required this.sek,
      required this.nok,
      required this.dkk,
      required this.aud,
      required this.rub,
      required this.kwd,
      required this.eur,
      required this.inr,
      required this.bnd,
      required this.zar,
      required this.npr,
      required this.cny,
      required this.chf,
      required this.pkr,
      required this.kes,
      required this.thb,
      required this.egp,
      required this.bdt,
      required this.sar,
      required this.lak,});

  factory Rates.fromJson(dynamic json) {
    return Rates(
    usd : json['USD'],
    khr : json['KHR'],
    sgd : json['SGD'],
    idr : json['IDR'],
    lkr : json['LKR'],
    nzd : json['NZD'],
    czk : json['CZK'],
    jpy : json['JPY'],
    php : json['PHP'],
    krw : json['KRW'],
    vnd : json['VND'],
    hkd : json['HKD'],
    brl : json['BRL'],
    rsd : json['RSD'],
    myr : json['MYR'],
    cad : json['CAD'],
    gbp : json['GBP'],
    ils : json['ILS'],
    sek : json['SEK'],
    nok : json['NOK'],
    dkk : json['DKK'],
    aud : json['AUD'],
    rub : json['RUB'],
    kwd : json['KWD'],
    eur : json['EUR'],
    inr : json['INR'],
    bnd : json['BND'],
    zar : json['ZAR'],
    npr : json['NPR'],
    cny : json['CNY'],
    chf : json['CHF'],
    pkr : json['PKR'],
    kes : json['KES'],
    thb : json['THB'],
    egp : json['EGP'],
    bdt : json['BDT'],
    sar : json['SAR'],
    lak : json['LAK'],
    );
  }
  String usd;
  String khr;
  String sgd;
  String idr;
  String lkr;
  String nzd;
  String czk;
  String jpy;
  String php;
  String krw;
  String vnd;
  String hkd;
  String brl;
  String rsd;
  String myr;
  String cad;
  String gbp;
  String ils;
  String sek;
  String nok;
  String dkk;
  String aud;
  String rub;
  String kwd;
  String eur;
  String inr;
  String bnd;
  String zar;
  String npr;
  String cny;
  String chf;
  String pkr;
  String kes;
  String thb;
  String egp;
  String bdt;
  String sar;
  String lak;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['USD'] = usd;
    map['KHR'] = khr;
    map['SGD'] = sgd;
    map['IDR'] = idr;
    map['LKR'] = lkr;
    map['NZD'] = nzd;
    map['CZK'] = czk;
    map['JPY'] = jpy;
    map['PHP'] = php;
    map['KRW'] = krw;
    map['VND'] = vnd;
    map['HKD'] = hkd;
    map['BRL'] = brl;
    map['RSD'] = rsd;
    map['MYR'] = myr;
    map['CAD'] = cad;
    map['GBP'] = gbp;
    map['ILS'] = ils;
    map['SEK'] = sek;
    map['NOK'] = nok;
    map['DKK'] = dkk;
    map['AUD'] = aud;
    map['RUB'] = rub;
    map['KWD'] = kwd;
    map['EUR'] = eur;
    map['INR'] = inr;
    map['BND'] = bnd;
    map['ZAR'] = zar;
    map['NPR'] = npr;
    map['CNY'] = cny;
    map['CHF'] = chf;
    map['PKR'] = pkr;
    map['KES'] = kes;
    map['THB'] = thb;
    map['EGP'] = egp;
    map['BDT'] = bdt;
    map['SAR'] = sar;
    map['LAK'] = lak;
    return map;
  }

}