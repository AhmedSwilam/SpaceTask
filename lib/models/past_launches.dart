class PastLaunches {
   String staticFireDateUtc;
   int staticFireDateUnix;
   bool net;
   int window;
   String rocket;
   bool success;
   String details;
   List<String> payloads;
   String launchpad;
   int flightNumber;
   String name;
   String dateUtc;
   int dateUnix;
   String dateLocal;
   String datePrecision;
   bool upcoming;
   bool autoUpdate;
   bool tbd;
   String launchLibraryId;
   String id;

  PastLaunches({
     this.staticFireDateUtc,
     this.staticFireDateUnix,
     this.net,
     this.window,
     this.rocket,
     this.success,
     this.details,
     this.payloads,
     this.launchpad,
     this.flightNumber,
     this.name,
     this.dateUtc,
     this.dateUnix,
     this.dateLocal,
     this.datePrecision,
     this.upcoming,
     this.autoUpdate,
     this.tbd,
     this.launchLibraryId,
     this.id,
  });

  PastLaunches.fromJson(Map<String, dynamic> json) {
    staticFireDateUtc = json['static_fire_date_utc'].toString();
    staticFireDateUnix = json['static_fire_date_unix']?.toInt();
    net = json['net'];
    window = json['window']?.toInt();
    rocket = json['rocket'].toString();
    success = json['success'];
    if (json['failures'] != null) {
      final v = json['failures'];
      v.forEach((v) {});
    }
    details = json['details'].toString();
    if (json['payloads'] != null) {
      final v = json['payloads'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      payloads = arr0;
    }
    launchpad = json['launchpad'].toString();
    flightNumber = json['flight_number']?.toInt();
    name = json['name'].toString();
    dateUtc = json['date_utc'].toString();
    dateUnix = json['date_unix']?.toInt();
    dateLocal = json['date_local'].toString();
    datePrecision = json['date_precision'].toString();
    upcoming = json['upcoming'];
    if (json['cores'] != null) {
      final v = json['cores'];
    }
    autoUpdate = json['auto_update'];
    tbd = json['tbd'];
    launchLibraryId = json['launch_library_id'].toString();
    id = json['id'].toString();
  }

  get links => null;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['static_fire_date_utc'] = staticFireDateUtc;
    data['static_fire_date_unix'] = staticFireDateUnix;
    data['net'] = net;
    data['window'] = window;
    data['rocket'] = rocket;
    data['success'] = success;
    data['details'] = details;

    if (payloads != null) {
      final v = payloads;
      final arr0 = [];
      v.forEach((v) {
        arr0.add(v);
      });
      data['payloads'] = arr0;
    }
    data['launchpad'] = launchpad;
    data['flight_number'] = flightNumber;
    data['name'] = name;
    data['date_utc'] = dateUtc;
    data['date_unix'] = dateUnix;
    data['date_local'] = dateLocal;
    data['date_precision'] = datePrecision;
    data['upcoming'] = upcoming;
    data['auto_update'] = autoUpdate;
    data['tbd'] = tbd;
    data['launch_library_id'] = launchLibraryId;
    data['id'] = id;
    return data;
  }
}
