class DeviceInfoModel {
  final String? id;
  final String? os;
  final String? osVersion;
  final String? model;

  DeviceInfoModel({
    required this.id,
    required this.os,
    required this.osVersion,
    required this.model,
  });

  @override
  String toString() {
    return 'DeviceInfoModel(id: $id, os: $os, osVersion: $osVersion, model: $model)';
  }

  @override
  bool operator ==(covariant DeviceInfoModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.os == os &&
      other.osVersion == osVersion &&
      other.model == model;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      os.hashCode ^
      osVersion.hashCode ^
      model.hashCode;
  }
}
