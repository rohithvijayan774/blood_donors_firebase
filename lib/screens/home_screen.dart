import 'package:blood_donation/screens/donor_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');

  void deleteDonor(docId) {
    donor.doc(docId).delete().then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Blood Donors List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: donor.orderBy('name').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot donorSnap = snapshot.data!.docs[index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          UserDetailsScreen(name: donorSnap['name']),
                    ));
                  },
                  leading: CircleAvatar(
                    child: Text(donorSnap['bloodGroup']),
                  ),
                  title: Text(
                    donorSnap['name'],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(donorSnap['phone'].toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/update', arguments: {
                            'name': donorSnap['name'],
                            'phone': donorSnap['phone'].toString(),
                            'bloodGroup': donorSnap['bloodGroup'],
                            'id': donorSnap.id,
                          });
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          // deleteDonor(donorSnap.id);

                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                title: const Text(
                                  'Delete Donor?',
                                  style: TextStyle(color: Colors.red),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      deleteDonor(donorSnap.id);
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  indent: 20,
                  endIndent: 20,
                  thickness: 0.5,
                );
              },
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 2,
            ));
          }
        },
      ),
    );
  }
}
