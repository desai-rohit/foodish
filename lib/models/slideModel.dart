import 'dart:convert';

List<Slidemodel> slidemodelFromJson(String str) =>
    List<Slidemodel>.from(json.decode(str).map((x) => Slidemodel.fromJson(x)));

String slidemodelToJson(List<Slidemodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Slidemodel {
  String id;
  String imges;

  Slidemodel({
    required this.id,
    required this.imges,
  });

  factory Slidemodel.fromJson(Map<String, dynamic> json) => Slidemodel(
        id: json["_id"],
        imges: json["imges"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "imges": imges,
      };
}
