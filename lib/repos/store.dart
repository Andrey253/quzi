import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quzi/data/result_data.dart';

class Store {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<bool> sendResult(ResultData result) async {
    firestore.collection(ResultData.CLASS_NAME).add(result.toMap());
    return false;
  }

  Future<List<ResultData>> getResult() async {
    final d = await firestore.collection(ResultData.CLASS_NAME).orderBy('dateTime',descending: true).get();
    return d.docs.map((e) => ResultData.fromFire(e)).toList();
  }

  Future<void> delete(ResultData resultData) async {
    if (resultData.id == null) return;
    await firestore.doc(resultData.id!).delete();
  }
}
