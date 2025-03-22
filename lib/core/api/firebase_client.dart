import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'errors.dart';

class FirebaseClient {
  final _client = FirebaseFirestore.instance;

  Future<dynamic> get({
    required String collection,
  }) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> response =
          await _client.collection(collection).get();
      final data = response.docs.map((e) => e.data()).toList();
      log(" FIREBASE GET DATA $collection\n$data", name: "FIREBASE GET");
      return data;
    } catch (error) {
      log(error.toString(), name: "ERROR GET FIREBASE");
      handleError(error);
    }
  }

  Future<dynamic> getByID({
    required String collection,
    required String id,
  }) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> response =
          await _client.collection(collection).doc(id.toString()).get();

      final data = response.data();
      log(
        " FIREBASE GET BY ID DATA $collection $id\n$data ",
        name: "FIREBASE GET BY ID",
      );
      return data;
    } catch (error) {
      handleError(error);
    }
  }

  Future<void> delete({
    required String collection,
    required String id,
  }) async {
    try {
      await _client.collection(collection).doc(id.toString()).delete();
      log(
        " FIREBASE DELETE $collection $id",
        name: "FIREBASE DELETE",
      );
    } catch (error) {
      handleError(error);
    }
  }

  Future<void> post({
    required String collection,
    required String id,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _client.collection(collection).doc(id).set(data);
      log(" FIREBASE POST DATA $collection $id $data", name: "FIREBASE POST");
    } on ExceptionWithMessage catch (error) {
      rethrow;
    } catch (error) {
      handleError(error);
    }
  }

  Future<void> put({
    required String collection,
    required String id,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _client.collection(collection).doc(id).update(data);
      log(" FIREBASE UPDATE DATA $collection $id $data",
          name: "FIREBASE UPDATE");
    } catch (error) {
      handleError(error);
    }
  }

  Future<void> putWithId({
    required String collection,
    required Map<String, dynamic> data,
  }) async {
    await put(collection: collection, id: data['id'].toString(), data: data);
  }

  Future<void> postWithId({
    required String collection,
    required Map<String, dynamic> data,
  }) async {
    throw ExceptionWithMessage('method not found');
    await post(collection: collection, id: data['id'].toString(), data: data);
  }

  void handleError(Object error) {
    if (error.toString().contains("permission-denied")){
      throw ExceptionWithMessage("Permission Denied !");
    }
    throw Exception(error.toString());
  }
}
