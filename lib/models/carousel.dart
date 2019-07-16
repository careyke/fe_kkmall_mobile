import 'package:json_annotation/json_annotation.dart';

part 'carousel.g.dart';

@JsonSerializable()
class Carousel {
  Carousel(this.id, this.url, this.title);
  String id;
  String url;
  String title;

  factory Carousel.fromJson(Map<String, dynamic> json) =>
      _$CarouselFromJson(json);

  Map<String, dynamic> toJson() => _$CarouselToJson(this);
}
