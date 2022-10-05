import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/utils/app_strings.dart';
import 'package:google_signin/utils/colors.dart';
import 'package:google_signin/widget/welcome_Screen.dart';
import 'package:google_signin/screens/google_login.dart';
import 'package:google_signin/services/firebase_services.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CollectionReference _tasklist = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection("Tasks");

  final TextEditingController _descController = TextEditingController();
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _dateInput = TextEditingController();

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        backgroundColor: AppColors.cardDark,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(ctx).viewInsets.top + 10,
                left: 30,
                right: 30,
                bottom: MediaQuery.of(ctx).viewInsets.bottom),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 50),
                      Row(
                        children: const [
                          Icon(
                            Icons.arrow_back,
                            color: Colors.blue,
                            size: 30,
                          ),
                          SizedBox(width: 80),
                          Text(
                            TextConstants.adding,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(width: 80),
                          Icon(
                            Icons.menu,
                            color: Colors.blue,
                            size: 30,
                          )
                        ],
                      ),
                      const SizedBox(height: 80),
                      Container(
                        child: CircleAvatar(
                          backgroundColor: const Color.fromRGBO(70, 83, 158, 1),
                          radius: 40,
                          child: Image.asset(
                            'assets/images/icon2.png',
                            fit: BoxFit.cover,
                            height: 40,
                          ),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: _taskController,
                        decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.textFaded)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.textFaded)),
                            labelText: TextConstants.addtask,
                            hintText: TextConstants.addtask,
                            hintStyle: TextStyle(color: Colors.white),
                            labelStyle: TextStyle(color: AppColors.textFaded)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: _descController,
                    decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.textFaded)),
                        labelText: TextConstants.desc,
                        hintText: TextConstants.desc,
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: AppColors.textFaded)),
                  ),
                  const SizedBox(height: 50),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: _dateInput,
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.textFaded)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.textFaded)),
                      labelText: TextConstants.datepic,
                      hintText: TextConstants.datepic,
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: AppColors.textFaded),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2100));

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('dd-MMM-yyyy').format(pickedDate);
                        _dateInput.text = formattedDate;
                      } else {}
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 1,
                      child: ElevatedButton(
                        child: const Text('ADD YOUR THING'),
                        onPressed: () async {
                          final String task = _taskController.text;
                          final String desc = _descController.text;
                          final String datepick = _dateInput.text;

                          {
                            await _tasklist.add({
                              "task": task,
                              "desc": desc,
                              "datepick": datepick,
                            });

                            _taskController.text = '';
                            _descController.text = '';
                            _dateInput.text = '';
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 180)
                ],
              ),
            ),
          );
        });
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _taskController.text = documentSnapshot['task'];
      _descController.text = documentSnapshot['desc'];
      _dateInput.text = documentSnapshot['datepick'];
    }

    await showModalBottomSheet(
        backgroundColor: AppColors.cardDark,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(ctx).viewInsets.top,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 80),
                      Container(
                          child: CircleAvatar(
                            backgroundColor: AppColors.cardDark,
                            radius: 40,
                            child: Image.asset(
                              'assets/images/icon2.png',
                              fit: BoxFit.cover,
                              height: 40,
                            ),
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.textLight,
                              width: 1.0,
                            ),
                          )),
                      const SizedBox(height: 50),
                      const Text(
                        "EDIT TASK",
                        style: TextStyle(color: AppColors.textLight),
                      ),
                      const SizedBox(height: 50),
                      TextField(
                        style: const TextStyle(color: AppColors.textLight),
                        controller: _taskController,
                        decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.textFaded)),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.textFaded,
                              ),
                            ),
                            labelText: TextConstants.edittask,
                            hintText: TextConstants.edittask,
                            hintStyle: TextStyle(color: AppColors.textLight),
                            labelStyle: TextStyle(color: AppColors.textLight)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  TextField(
                    style: const TextStyle(color: AppColors.textLight),
                    controller: _descController,
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.textFaded)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        labelText: TextConstants.desc,
                        hintText: TextConstants.desc,
                        hintStyle: TextStyle(color: AppColors.textLight),
                        labelStyle: TextStyle(color: AppColors.textLight)),
                  ),
                  const SizedBox(height: 50),
                  TextField(
                    style: const TextStyle(color: AppColors.textLight),
                    controller: _dateInput,
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.textFaded)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.textFaded)),
                      labelText: TextConstants.datepic,
                      hintText: TextConstants.datepic,
                      hintStyle: TextStyle(color: AppColors.textLight),
                      labelStyle: TextStyle(color: AppColors.textLight),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2100));

                      if (pickedDate != null) {
                        print(pickedDate);
                        String formattedDate =
                            DateFormat('dd-MMM-yyyy').format(pickedDate);
                        print(formattedDate);
                        _dateInput.text = formattedDate;
                      } else {}
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 1,
                      child: ElevatedButton(
                        child: Text(TextConstants.edit),
                        onPressed: () async {
                          final String task = _taskController.text;
                          final String desc = _descController.text;
                          final String datepick = _dateInput.text;
                          {
                            await _tasklist
                              ..doc(documentSnapshot!.id).update({
                                "task": task,
                                "desc": desc,
                                "datepick": datepick
                              });
                            _taskController.text = '';
                            _descController.text = '';
                            _dateInput.text = '';

                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 180)
                ],
              ),
            ),
          );
        });
  }

  Future<void> _delete(String productId) async {
    await _tasklist.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        drawer: const Drawer(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseServices().googleSignOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GoogleLoginScreen()));
                },
                icon: const Icon(Icons.logout)),
          ],
        ),
        body: Column(
          children: [
            Welcome(),
            Flexible(
              fit: FlexFit.loose,
              child: StreamBuilder(
                stream: _tasklist.snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return ListView.builder(
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                        return Card(
                          margin: const EdgeInsets.all(15),
                          shadowColor: Colors.black,
                          child: Container(
                            color: Colors.white,
                            height: 100,
                            child: ListTile(
                              title: Text(documentSnapshot['task']),
                              subtitle: Text(documentSnapshot['desc']),
                              trailing: SizedBox(
                                width: 170,
                                child: Row(
                                  children: [
                                    Text(documentSnapshot['datepick']
                                        .toString()),
                                    IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () =>
                                            _update(documentSnapshot)),
                                    IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () =>
                                            _delete(documentSnapshot.id)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            Container(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const SizedBox(
                      height: 20,
                      child: Text(
                        "COMPLETED",
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Center(
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(100)),
                        child: const Center(
                          child: Text(
                            "0",
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _create(),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat);
  }
}
