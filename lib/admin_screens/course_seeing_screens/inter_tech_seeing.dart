import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gurukul_team_hacktivators/admin_screens/Course_adding_screens/adv_soft_add.dart';
import 'package:gurukul_team_hacktivators/admin_screens/Course_adding_screens/inter_tech_add.dart';

var docid ="";

class IntermediateTechSkillSeeingScreen extends StatefulWidget {
  @override
  _IntermediateTechSkillSeeingScreenState createState() => _IntermediateTechSkillSeeingScreenState();
}

class _IntermediateTechSkillSeeingScreenState extends State<IntermediateTechSkillSeeingScreen> {
  List<String> _data = [];

  @override
  void initState() {
    super.initState();
    // Reference to the Firestore database
    final firestore = FirebaseFirestore.instance;
    // Fetch a collection
    firestore.collection("intermediatetechskills").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        // Extract the data from the documents
        var data = result.data();
        // Add the data to the list
        setState(() {
          _data.add(data["Name"]);
        });
      });
    });
  }
  // function to delete a document
  void _deleteDocument(String fieldName) async {
    final firestore = FirebaseFirestore.instance;
    // Delete the document that contains the given field name
    await firestore.collection("intermediatetechskills")
        .where("Name", isEqualTo: fieldName)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        result.reference.delete();
      });
    });
    // Remove the data from the list
    setState(() {
      _data.remove(fieldName);
    });
  }


  // function to update a document
  // Function to handle updating the document


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Intermediate Tech Skill Courses'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 600,
            child: ListView.builder(
              itemCount: _data.length,
              itemBuilder: (context, index) {
                final documentReference = FirebaseFirestore.instance.collection("advancedsoftskills").doc(index.toString());
                return ListTile(
                  title: Text(_data[index]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Confirm Deletion"),
                                  content: Text("Are you sure you want to delete this document?"),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text("Delete"),
                                      onPressed: () {
                                        _deleteDocument(_data[index]);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              }
                          );
                        },
                      ),
                    ],
                  ),

                );
              },
            ),
          ),
          TextButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context){
                        return IntermediateTechSkillAddingScreen();
                      }
                  ),
                );
              },
              child: Text('Add Data')),
        ],
      ),
    );
  }
}



