class Room{
  static const String collectionName='Room';

  String id;
  String title;
  String desc;
  String catid;
  Room({
    required this.id,
    required this.title,
    required this.desc,
    required this.catid
  });

  Room.fromJson(Map<String,dynamic>json):
        this(
        id: json['id'] as String,
        title: json['title'] as String,
        desc: json['desc'] as String,
        catid: json['catid'] as String,
      );

  Map<String,dynamic>toJson(){
    return {
      'id':id,
      'title':title,
      'desc':desc,
      'catid':catid,
    };
  }
}
