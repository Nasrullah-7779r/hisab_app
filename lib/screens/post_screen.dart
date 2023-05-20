import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hisaap_app/components/global_methods.dart';
import 'package:hisaap_app/user_provider.dart';
import 'package:provider/provider.dart';
import '../components/text_widget.dart';
import '../services/db.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key, required this.userProvider});
  final UserProvider userProvider;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: MyTextWidget(
          text: widget.userProvider.getName,
          isTitle: true,
          color: Colors.white,
        ),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProviderVal, child) {
          return Column(
            children: [
              descriptionAmountTextFormFields(),
              Consumer<DB>(
                builder: (context, dbVal, child) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(100, 50))),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          focusNode.unfocus();

                          dbVal.addDataToUI(descriptionController.text,
                              int.parse(amountController.text));
                          descriptionController.clear();
                          amountController.clear();
                          focusNode.requestFocus();
                        }
                      },
                      child: const MyTextWidget(
                        text: 'Add',
                        isTitle: true,
                        textSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
              Expanded(
                flex: 4,
                child: Consumer<DB>(
                  builder: (context, dbVal, child) {
                    return ListView.builder(
                      itemCount:
                          dbVal.desList == null ? 0 : dbVal.desList!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.description),
                          title: dbVal.desList?[index] == null
                              ? const Text('')
                              : MyTextWidget(
                                  text: dbVal.desList![index],
                                  isTitle: true,
                                ),
                          trailing: SizedBox(
                            width: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                dbVal.amountList!.isEmpty
                                    ? const Text('')
                                    : MyTextWidget(
                                        text: '${dbVal.amountList![index]}',
                                        isTitle: true),
                                const SizedBox(
                                  width: 7,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    dbVal.removeDataAt(index);
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: Consumer<DB>(
                  builder: (context, dbVal, child) {
                    return SizedBox(
                      width: 400,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate() == false &&
                              dbVal.desList == null) {
                            GlobalMethods.errorDialog(
                                title: 'Error',
                                subtitle: 'No entry is made to be posted',
                                context: context,
                                function: () {
                                  Navigator.pop(context);
                                });
                          }
                          if (formKey.currentState!.validate() &&
                              dbVal.desList == null) {
                            focusNode.unfocus();
                            dbVal.addDataFromFieldsToFirebase(
                                widget.userProvider.getName,
                                descriptionController.text,
                                int.parse(amountController.text),
                                dbVal.getDateTime());
                            dbVal.deleteDataFromUI();

                            GlobalMethods.popUpDialog(
                                title: 'Posted',
                                subtitle:
                                    'Transaction(s) has been posted successfully.',
                                context: context,
                                haveIcon: false,
                                function: () {
                                  Navigator.pop(context);
                                  descriptionController.clear();
                                  amountController.clear();
                                  focusNode.requestFocus();
                                });

                            //    dbVal.desList = null;

                          }
                          if (dbVal.desList != null) {
                            descriptionController.text = '';
                            amountController.text = '';

                            dbVal.addDataFromDesListToFirebase(
                                widget.userProvider.getName,
                                dbVal.desList,
                                dbVal.amountList,
                                dbVal.getDateTime());
                            dbVal.deleteDataFromUI();
                            dbVal.desList = null;
                            GlobalMethods.popUpDialog(
                                title: 'Posted',
                                subtitle:
                                    'Transaction(s) has been posted successfully.',
                                context: context,
                                haveIcon: false,
                                function: () {
                                  Navigator.pop(context);
                                });
                          }
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 50),
                          ),
                        ),
                        child: const MyTextWidget(
                          text: 'Post',
                          color: Colors.white,
                          isTitle: true,
                          textSize: 20,
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Form descriptionAmountTextFormFields() {
    return Form(
      key: formKey,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextFormField(
                onEditingComplete: (() {
                  focusNode.requestFocus();
                }),
                focusNode: focusNode,
                keyboardType: TextInputType.streetAddress,
                textCapitalization: TextCapitalization.sentences,
                controller: descriptionController,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Description',
                ),
                validator: ((value) {
                  if (value == null || value.isEmpty) {
                    focusNode.requestFocus();
                    return 'Kindly enter a valid description';
                  }

                  return null;
                }),
              ),
            ),
          ),
          const SizedBox(
            width: 50,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextFormField(
                controller: amountController,
                textAlign: TextAlign.center,
                onEditingComplete: (() {
                  amountController.clear();
                }),
                decoration: const InputDecoration(
                  hintText: 'Amount',
                  // errorBorder: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+')), // accept only integers
                  LengthLimitingTextInputFormatter(
                      5), // limit the amount upto 99,000
                ],
                validator: ((value) {
                  if (value == null || value.isEmpty) {
                    return 'Invalid amount';
                  }
                  return null;
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
