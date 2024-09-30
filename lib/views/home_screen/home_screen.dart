import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample_april/views/login_screeen/login_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var empoyeeCollection = FirebaseFirestore.instance.collection("Employee");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                  (route) => false,
                );
              },
              icon: Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: empoyeeCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return ListTile(
                    title: Text(data['name']),
                    subtitle: Text(data['des']),
                  );
                })
                .toList()
                .cast(),
          );
        },
      ),
    );
  }

  // Bottom Sheet function
  void _showBottomSheet(BuildContext context) {
    final TextEditingController employeeNameController =
        TextEditingController();
    final TextEditingController designationController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // To make sure the keyboard doesn't hide the form
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom, // To avoid keyboard overlap
              left: 16,
              right: 16,
              top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: employeeNameController,
                decoration: InputDecoration(
                  labelText: 'Employee Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: designationController,
                decoration: InputDecoration(
                  labelText: 'Designation',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Validation logic
                  String name = employeeNameController.text.trim();
                  String designation = designationController.text.trim();

                  if (name.isEmpty || designation.isEmpty) {
                    Navigator.pop(context); // Close the bottom sheet

                    // Use the root context to show SnackBar on top of the bottom sheet
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("Both fields are required"),
                      ),
                    );
                  } else {
                    Navigator.pop(context); // Close the bottom sheet

                    await empoyeeCollection.add({
                      "name": employeeNameController.text,
                      "des": designationController.text,
                    });
                  }
                },
                child: Text("Add"),
              ),
            ],
          ),
        );
      },
    );
  }
}
