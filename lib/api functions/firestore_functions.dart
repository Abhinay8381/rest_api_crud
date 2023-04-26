import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firestorefunctions {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // add booking id to the user documnent
  addID(String id) async {
    await _firebaseFirestore
        .collection("users")
        .doc(_firebaseAuth.currentUser!.uid)
        .update({
      "BookingIDs": FieldValue.arrayUnion([id]),
    });
  }

// get booking ids from the user documnent
  Future<DocumentSnapshot> getIDs() async {
    DocumentSnapshot documentSnapshot = await _firebaseFirestore
        .collection("users")
        .doc(_firebaseAuth.currentUser!.uid)
        .get();
    return documentSnapshot;
  }

// delete booking id from the user documnent
  deleteIDs(String id) async {
    await _firebaseFirestore
        .collection("users")
        .doc(_firebaseAuth.currentUser!.uid)
        .update({
      "BookingIDs": FieldValue.arrayRemove([id]),
    });
  }
}
