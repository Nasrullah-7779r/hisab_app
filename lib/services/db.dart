import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hisaap_app/user_provider.dart';
import 'package:intl/intl.dart';

class DB with ChangeNotifier {
  static const String usersData = 'usersData',
      usersNamePassCollection = 'usersNamePassCollection',
      entries = 'entries'; // Firebase var

  // for record while posting entries(adding data)
  String getDateTime() {
    final now = DateTime.now();

    String formattedDate = DateFormat('dd-MM-yyyy hh:mm a').format(now);

    return formattedDate;
  }

  List<String>? desList;
  List<int>? amountList = [];

  void addDataToUI(String description, int amount) {
    UserProvider userProvider = UserProvider();
    desList = userProvider.getDescriptionData;
    amountList = userProvider.getAmountData;
    desList?.add(description);
    amountList?.add(amount);
    notifyListeners();
  }

// delete from UI
  void deleteDataFromUI() {
    desList?.clear();
    amountList?.clear();
    notifyListeners();
  }

  // Remove Data
  void removeDataAt(int index) {
    desList?.removeAt(index);
    amountList?.removeAt(index);
    notifyListeners();
  }

//delete from Firebase

  deleteAllEntries(String userName) async {
    final entriesRef = FirebaseFirestore.instance
        .collection(usersData)
        .doc(userName)
        .collection('entries');
    final entriesSnapshot = await entriesRef.get();
    for (DocumentSnapshot doc in entriesSnapshot.docs) {
      await doc.reference.delete();
    }
  }

// write to Firebase
  void addDataFromDesListToFirebase(String name, List<String>? description,
      List<int>? amount, String dateTime) {
    UserProvider userProvider = UserProvider();
    List<String> desList = userProvider.getDescriptionData;

    final fb = FirebaseFirestore.instance;
    final postDateTime = getDateTime();
    for (int i = 0; i < desList.length; i++) {
      fb
          .collection(usersData)
          .doc(name)
          .collection(entries)
          .doc('${amount![i]}  --- $postDateTime')
          .set({
        'name': name,
        'DateTime': dateTime,
        'description': description?[i],
        'amount': amount[i]
      });
    }
  }

// write to Firebase
  void addDataFromFieldsToFirebase(
      String name, String? description, int? amount, String dateTime) {
    final fb = FirebaseFirestore.instance;
    final postDateTime = getDateTime();

    fb
        .collection(usersData)
        .doc(name)
        .collection(entries)
        .doc('${amount!}  --- $postDateTime')
        .set({
      'name': name,
      'DateTime': dateTime,
      'description': description,
      'amount': amount,
    });
  }

// Read
  Future<List<DocumentSnapshot>> initialFetch(String name) async {
    final fb = FirebaseFirestore.instance;

    final QuerySnapshot querySnapshot =
        await fb.collection(usersData).doc(name).collection(entries).get();
    final List<DocumentSnapshot> documents = querySnapshot.docs;
    return documents;
  }

  // Read Description
  Future<List<String>> fetchDesFromFirebase(String name) async {
    List<String> descriptionList = [];

    List<DocumentSnapshot> documents = await initialFetch(name);

    for (var doc in documents) {
      descriptionList.add(doc.get('description'));
    }

    notifyListeners();
    return descriptionList;
  }

// Read Amount
  Future<List<int>> fetchAmountFromFirebase(String name) async {
    List<int> amountList = [];
    List<DocumentSnapshot> documents = await initialFetch(name);
    for (var doc in documents) {
      amountList.add(doc.get('amount'));
    }

    return amountList;
  }

// Read DateTime
  Future<List<String>?> fetchDateTimeFromFirebase(String name) async {
    List<String> dateTimeList = [];
    List<DocumentSnapshot> documents = await initialFetch(name);
    for (var doc in documents) {
      dateTimeList.add(doc.get('DateTime'));
    }

    return dateTimeList;
  }

// Read the whole amount utilized till now
// dynamic ids required
  List<String> userIds = ['Hamza', 'Nasrullah', 'Arsalan', 'Mujahid', 'Saad'];
  int amount = 0;
  int i = 0;

  Future<int> getTotalUsersAmount() async {
    final userRef = FirebaseFirestore.instance
        .collection('usersData')
        .doc(userIds[i])
        .collection('entries');

    final querySnapshot = await userRef.get();

    for (var doc in querySnapshot.docs) {
      final docData = doc.data();

      final docAmount = docData['amount'] as int;
      amount += docAmount;
    }

    ++i;
    if (i < userIds.length) {
      amount = await getTotalUsersAmount();
    }

    return amount;
  }

  Future<bool> addUserToFirebase(UserProvider user) async {
    try {
      final fb = FirebaseFirestore.instance;
      await fb
          .collection(usersNamePassCollection)
          .doc(user.getName)
          .set({'name': user.getName, 'password': user.getPassword});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

// remove user from Firebase

  String delKey = 'r'; // a key to del/remove the user
  Future<bool> removeUserFromFirebase(String name, String key) async {
    try {
      if (key == delKey) {
        final fb = FirebaseFirestore.instance;
        final docRef = fb.collection(usersNamePassCollection).doc(name);
        final docSnaposhot = await docRef.get();
        if (docSnaposhot.exists) {
          await docRef.delete();
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      print(e);
      return false;
    }
    return false;
  }

  Future<List<String>> getAllUsersFromFirebase() async {
    List<String> usersList = [];
    final fb = FirebaseFirestore.instance;
    await fb
        .collection(usersNamePassCollection)
        .get()
        .then((value) => value.docs.forEach((doc) {
              usersList.add(doc.id);
            }));

    return usersList;
  }

  Future<int> getUsersListLengthFromFirebase() async {
    List<String> userList = await getAllUsersFromFirebase();
    final length = userList.length;
    return length;
  }
}
