import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventar/DataModels/batch_datamodel.dart';
import 'package:inventar/DataModels/medicine_batch.dart';

class Database {
  final String docId;
  Database({this.docId});
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference medicineCollection = FirebaseFirestore.instance
      .collection('Medicines');

  Future<void> addMedicine({medicineName, brandName, Quantity, purchaseDate, expiryDate, batchQuantity}) async {
    ///add a medicine doc with doc address generated automatically
    ///@param medicineName
    ///@param brandName
    ///@param Quantity
    ///@return add method from firebasefirestore
    return await medicineCollection.add({
      'medicineName': medicineName,
      'brandName': brandName,
      'quantity': Quantity,
      }
    ).then((value) =>
      medicineCollection.doc(value.id).collection('Batches').add(
        {
          'purchaseDate': purchaseDate,
          'expiryDate': expiryDate,
          'batchQuantity': batchQuantity,
        }
      )
    );
  }

  ///Update the medicine document
  ///@param medicineName
  ///@param brandName
  ///@param Quantity
  Future<void> updateMedicine({medicineName, brandName}) async {
    DocumentSnapshot medicineDoc = await medicineCollection.doc(docId).get();
    Map<String, dynamic> mapped = medicineDoc.data();
    return await medicineCollection.doc(docId).update(
        {
          'medicineName': medicineName ?? mapped['medicineName'],
          'brandName': brandName ?? mapped['brandName'],
        }
    );
  }

  Future<void> searchMedicine({String medicineName}) async {
    return await medicineCollection.where(
        'medicineName', arrayContainsAny: [medicineName]).get();
  }


  ///this will delete the specified medicine document
  ///note: medicne document contain the batch collection deleting a medicine will delete the whole batch
  ///@return delete method from firebasefirestore
  Future<void> deleteMedicine() async {
    print(docId);
    return await medicineCollection.doc(docId).delete();
  }


  List<MedicineDataModel> _medicineListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((document) {
      Map<String, dynamic> mapped = document.data();
      return MedicineDataModel(
        medicineName: mapped['medicineName'] ?? '',
        quantity: mapped['quantity'] ?? '0',
        Brand: mapped['brandName'] ?? '',
        medicineId: document.id,
      );
    }).toList();
  }

  Stream<List<MedicineDataModel>> get medicines {
    return medicineCollection.snapshots()
        .map(_medicineListFromSnapshot);
  }

  List<BatchDataModel> _batchListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((document){
      Map<String,dynamic> mapped = document.data();
      return BatchDataModel(
        expiryDate: mapped['expiryDate'] as Timestamp,
        purchaseDate: mapped['purchaseDate'] as Timestamp,
        Quantity: mapped['batchQuantity'],
        batchId: document.id.toString(),
        docId: document.id.toString(),
      );
    }).toList();
  }

  Stream<List<BatchDataModel>> get batches{
    return medicineCollection.doc(docId).collection('Batches').snapshots().
    map(_batchListFromSnapshot);
  }

  Future<void> deleteBatch(String batchId){
    return medicineCollection.doc(docId).collection('Batches').doc(batchId).delete();
  }

  Future<void> updateBatch({String batchId,expiryDate,purchaseDate,batchQuantity}) async {
    DocumentSnapshot document = await medicineCollection.doc(docId).collection('Batches').doc(batchId).get();
    Map<String,dynamic> mapped = document.data();
    return medicineCollection.doc(docId).collection('Batches').doc(batchId).update(
      {
        'expiryDate': expiryDate ?? mapped['expiryDate'],
        'purchaseDate': purchaseDate ?? mapped['purchaseDate'],
        'batchQuantity': batchQuantity ?? mapped['batchQuantity']
      }
    );
  }
  Future<void> updateMedicineQuantity(int quantity) async {
    DocumentSnapshot medicineDoc = await medicineCollection.doc(docId).get();
    Map<String, dynamic> mapped = medicineDoc.data();
    return await medicineCollection.doc(docId).update(
        {
          'quantity': mapped['quantity']+quantity ?? mapped['quantity'],
          'medicineName':  mapped['medicineName'],
          'brandName':  mapped['brandName'],
        }
    );
  }

  Future<void> addBatch({expiryDate,purchaseDate,batchQuantity}) async {
    await updateMedicineQuantity(batchQuantity).whenComplete((){
      return medicineCollection.doc(docId).collection('Batches').add(
          {
            'expiryDate': expiryDate,
            'purchaseDate': purchaseDate,
            'batchQuantity': batchQuantity
          }
      );
    });

  }

}




