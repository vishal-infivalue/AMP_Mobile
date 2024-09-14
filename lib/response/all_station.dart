class AllStations {
  int? counter;
  String? createdts;
  String? updatedts;
  int? createdby;
  int? updatedby;
  String? stationcode;
  String? stationname;
  String? stationtype;
  String? province;
  String? email1;
  String? email2;
  String? phone1;
  String? phone2;
  String? managerId;
  String? lati;
  String? longi;
  Null? geofence;
  int? clusterid;
  String? status;

  AllStations(
      {this.counter,
        this.createdts,
        this.updatedts,
        this.createdby,
        this.updatedby,
        this.stationcode,
        this.stationname,
        this.stationtype,
        this.province,
        this.email1,
        this.email2,
        this.phone1,
        this.phone2,
        this.managerId,
        this.lati,
        this.longi,
        this.geofence,
        this.clusterid,
        this.status});

  AllStations.fromJson(Map<String, dynamic> json) {
    counter = json['counter'];
    createdts = json['createdts'];
    updatedts = json['updatedts'];
    createdby = json['createdby'];
    updatedby = json['updatedby'];
    stationcode = json['stationcode'];
    stationname = json['stationname'];
    stationtype = json['stationtype'];
    province = json['province'];
    email1 = json['email1'];
    email2 = json['email2'];
    phone1 = json['phone1'];
    phone2 = json['phone2'];
    managerId = json['manager_id'];
    lati = json['lati'];
    longi = json['longi'];
    geofence = json['geofence'];
    clusterid = json['clusterid'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['counter'] = this.counter;
    data['createdts'] = this.createdts;
    data['updatedts'] = this.updatedts;
    data['createdby'] = this.createdby;
    data['updatedby'] = this.updatedby;
    data['stationcode'] = this.stationcode;
    data['stationname'] = this.stationname;
    data['stationtype'] = this.stationtype;
    data['province'] = this.province;
    data['email1'] = this.email1;
    data['email2'] = this.email2;
    data['phone1'] = this.phone1;
    data['phone2'] = this.phone2;
    data['manager_id'] = this.managerId;
    data['lati'] = this.lati;
    data['longi'] = this.longi;
    data['geofence'] = this.geofence;
    data['clusterid'] = this.clusterid;
    data['status'] = this.status;
    return data;
  }
}