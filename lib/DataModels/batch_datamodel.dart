import 'package:cloud_firestore/cloud_firestore.dart';

class BatchDataModel{
  final int Quantity;
  final String batchId;
  final Timestamp purchaseDate;
  final Timestamp expiryDate;
  final String docId;

  BatchDataModel({this.Quantity,this.batchId,this.expiryDate,this.purchaseDate,this.docId});

  factory BatchDataModel.fromJson(Map<String,dynamic>json){
    return BatchDataModel(
      Quantity: json['Quantity'] as int,
      batchId: json['batchId'] as String,
      purchaseDate: json['purchaseDate'] as Timestamp,
      expiryDate: json['expiryDate'] as Timestamp,
      docId: json['docId'] as String,
    );
  }
}