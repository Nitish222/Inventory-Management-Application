
class MedicineDataModel{
  final String medicineName;
  final String Brand;
  final int quantity;
  final String medicineId;

  MedicineDataModel({this.Brand,this.medicineName,this.quantity,this.medicineId});

  factory MedicineDataModel.fromJson(Map<String,dynamic> json){
    return MedicineDataModel(
      Brand: json['brand'] as String,
      medicineName: json['medicine_name'] as String,
      quantity: int.parse(json['quantity']),
      medicineId: json['medId'] as String
    );
  }
}