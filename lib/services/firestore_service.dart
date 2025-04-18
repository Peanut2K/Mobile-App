import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/user.dart';

class FirestoreService {
  final CollectionReference _usersCol =
      FirebaseFirestore.instance.collection('users');

  Future<String> createUser(UserModel user) async {
    final docRef = await _usersCol.add(user.toMap());
    return docRef.id;
  }

  Future<void> updateUser(UserModel user) async {
    await _usersCol.doc(user.id).update(user.toMap());
  }

  Future<void> deleteUser(String id) async {
    await _usersCol.doc(id).delete();
  }

  Future<UserModel?> getUserById(String id) async {
    final snap = await _usersCol.doc(id).get();
    if (snap.exists) {
      return UserModel.fromMap(snap.id, snap.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<UserModel?> signIn(String username, String password) async {
  final snap = await FirebaseFirestore.instance
    .collection('users')
    .where('username', isEqualTo: username)
    .where('password', isEqualTo: password)
    .limit(1)
    .get();
  if (snap.docs.isEmpty) return null;
  final doc = snap.docs.first;
  return UserModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
  }

  Stream<List<UserModel>> streamAllUsers() {
    return _usersCol.snapshots().map((query) =>
        query.docs.map((doc) => UserModel.fromMap(doc.id, doc.data()! as Map<String, dynamic>)).toList());
  }
}
