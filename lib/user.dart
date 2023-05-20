import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class User {
  late String _name, _password;

  final List<String> _descriptionData = [];
  final List<int> _amountData = [];

  get getName => _name;
  get getPassword => _password;
  get getDescriptionData => _descriptionData;
  get getAmountData => _amountData;

  void addData(String description, int amount) {
    _descriptionData.add(description);
    _amountData.add(amount);
  }

  static const String usersData = 'usersData',
      entries = 'entries'; // Firebase var

  // for record while posting entries(adding data)
  String getDateTime() {
    final now = DateTime.now();

    String formattedDate = DateFormat('dd-MM-yyyy hh:mm a').format(now);

    return formattedDate;
  }

// write to Firebase
  void addDataToFirebase(String name, List<String> description,
      List<int> amount, String dateTime) {
    final fb = FirebaseFirestore.instance;
    final postDateTime = getDateTime();
    for (int i = 0; i < _descriptionData.length; i++) {
      fb
          .collection(usersData)
          .doc(name)
          .collection(entries)
          .doc('${amount[i]}  --- $postDateTime')
          .set({
        'name': name,
        'DateTime': dateTime,
        'description': description[i],
        'amount': amount[i]
      });
    }
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
    // if (descriptionList == null) {
    //   return null;
    // }
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

// delete from UI
  void deleteDataFromUI() {
    _descriptionData.clear();
    _amountData.clear();
  }

//delete from Firebase

  void deleteAllEntries(String userName) async {
    final entriesRef = FirebaseFirestore.instance
        .collection(usersData)
        .doc(userName)
        .collection('entries');
    final entriesSnapshot = await entriesRef.get();
    for (DocumentSnapshot doc in entriesSnapshot.docs) {
      await doc.reference.delete();
    }
  }
}
