import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  late String _name, _password;

  final List<String> _descriptionData = [];
  final List<int> _amountData = [];

  UserProvider({String name = '', String password = ''}) {
    _name = name;
    _password = password;
  }

  // final List<Map<String, dynamic>> _usersName = [
  //   {'name': 'Hamza', 'isChecked': false},
  //   {'name': 'Nasrullah', 'isChecked': false},
  //   {'name': 'Arsalan', 'isChecked': false},
  //   {'name': 'Mujahid', 'isChecked': false},
  //   {'name': 'Saad', 'isChecked': false},
  // ];

  final List<UserProvider> _usersNameToBeAdded = [];
  get getName => _name;
  get getPassword => _password;
  get getDescriptionData => _descriptionData;
  get getAmountData => _amountData;
  // get getToogleUsersName => _usersName;

  // void addDataToUI(String description, int amount) {
  //   _descriptionData.add(description);
  //   _amountData.add(amount);
  //   notifyListeners();
  // }

// // delete from UI
//   void deleteDataFromUI() {
//     _descriptionData.clear();
//     _amountData.clear();
//     notifyListeners();
//   }

//   // Remove Data
//   void removeDataAt(int index) {
//     _descriptionData.removeAt(index);
//     _amountData.removeAt(index);
//     notifyListeners();
//   }

  // static const String usersData = 'usersData',
  //     usersNamePassCollection = 'usersNamePassCollection',
  //     entries = 'entries'; // Firebase var

  // // for record while posting entries(adding data)
  // String getDateTime() {
  //   final now = DateTime.now();

  //   String formattedDate = DateFormat('dd-MM-yyyy hh:mm a').format(now);

  //   return formattedDate;
  // }

// write to Firebase
  // void addDataToFirebase(String name, List<String> description,
  //     List<int> amount, String dateTime) {
  //   final fb = FirebaseFirestore.instance;
  //   final postDateTime = getDateTime();

  //   for (int i = 0; i < _descriptionData.length; i++) {
  //     fb
  //         .collection(usersData)
  //         .doc(name)
  //         .collection(entries)
  //         .doc('${amount[i]}  --- $postDateTime')
  //         .set({
  //       'name': name,
  //       'DateTime': dateTime,
  //       'description': description[i],
  //       'amount': amount[i]
  //     });
  //   }
  // }

// Read
  // Future<List<DocumentSnapshot>> initialFetch(String name) async {
  //   final fb = FirebaseFirestore.instance;

  //   final QuerySnapshot querySnapshot =
  //       await fb.collection(usersData).doc(name).collection(entries).get();
  //   final List<DocumentSnapshot> documents = querySnapshot.docs;
  //   return documents;
  // }

  // // Read Description
  // Future<List<String>> fetchDesFromFirebase(String name) async {
  //   List<String> descriptionList = [];

  //   List<DocumentSnapshot> documents = await initialFetch(name);

  //   for (var doc in documents) {
  //     descriptionList.add(doc.get('description'));
  //   }

  //   notifyListeners();
  //   return descriptionList;
  // }

// need to update mechanism of _userName
  // void toggleUserCheck(int index) {
  //   _usersName[index]['isChecked'] = !_usersName[index]['isChecked'];

  //   notifyListeners();
  // }

  bool setAll = false;
  get getSetall => setAll;

  // updation required with new mechanism of _userName
  // void toggleAllUserCheck() {
  //   int cnt = 0;
  //   while (cnt < _usersName.length) {
  //     _usersName[cnt]['isChecked'] = !_usersName[cnt]['isChecked'];
  //     cnt++;
  //   }
  //   setAll = !setAll;
  //   notifyListeners();
  // }

  void addUser(UserProvider user) {
    _usersNameToBeAdded.add(user);
  }
}
