
class Product {
  String? prid;
  String? pridowner;
  String? prname;
  String? prdesc;
  String? prprice;
  String? prqty;
  String? prdel;
  String? prstate;
  String? prloc;
  String? prlat;
  String? prlong;
  String? prdate;

  Product(
      {required this.prid,
      required this.prname,
      required this.pridowner,
      required this.prdesc,
      required this.prprice,
      required this.prqty,
      required this.prdel,
      required this.prstate,
      required this.prloc,
      required this.prlat,
      required this.prlong,
      required this.prdate});

  Product.fromJson(Map<String, dynamic> json) {
    prid = json['prid'];
    prname = json['prname'];
    pridowner = json['pridowner'];
    prdesc = json['prdesc'];
    prprice = json['prprice'];
    prqty = json['prqty'];
    prdel = json['prdel'];
    prstate = json['prstate'];
    prloc = json['prloc'];
    prlat = json['prlat'];
    prlong = json['prlong'];
    prdate = json['prdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['prid'] = prid;
    data['prname'] = prname;
    data['pridowner'] = pridowner;
    data['prdesc'] = prdesc;
    data['prprice'] = prprice;
    data['prqty'] = prqty;
    data['prdel'] = prdel;
    data['prstate'] = prstate;
    data['prloc'] = prloc;
    data['prlat'] = prlat;
    data['prlong'] = prlong;
    data['prdate'] = prdate;
    return data;
  }
}