import 'package:flutter_derp/common/common.dart';
import '../entity_factory.dart';

class BaseEntity<T> {
  int code;
  String message;
  T data;
  List<T> listData = [];

  BaseEntity(this.code, this.message, this.listData, this.data);

  BaseEntity.fromJSON(Map<String, dynamic> json) {
    code = json[Contant.code];
    message = json[Contant.message];
    if (json.containsKey(Contant.data)) {
      if (json[Contant.data] is List) {
         (json[Contant.data] as List).forEach((item){
          listData.add(EntityFactory.generateOBJ<T>(item));
      });
    } else {
        if (T.toString() == 'String') {
          data = json[Contant.data].toString() as T;
        } else if (T.toString() == 'Map<dynamic, dynamic>') {
          data =  json[Contant.data] as T;
        } else {
          data = EntityFactory.generateOBJ(json[Contant.data]);
        }
      }
    }
  }
}