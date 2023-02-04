
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DataEntryScreen extends StatefulWidget {
  const DataEntryScreen({Key? key}) : super(key: key);

  @override
  State<DataEntryScreen> createState() => _DataEntryScreenState();
}

class _DataEntryScreenState extends State<DataEntryScreen> {


  String? errorMessage;
  final _formKey = GlobalKey<FormState>();
  final nameController = new TextEditingController();

  final linkController = new TextEditingController();




  @override
  Widget build(BuildContext context) {
    final NameField = TextFormField(
      autofocus: false,
      controller: nameController,
      keyboardType: TextInputType.name,


      onSaved: (value) {
        nameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Name of the Scheme",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )

      ),

    );
    final linkField = TextFormField(
      autofocus: false,
      controller: linkController,
      keyboardType: TextInputType.url,

      onSaved: (value) {
        linkController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.web_rounded),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Link of the course",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )

      ),

    );
    final submitButton = Material(
      color: Colors.greenAccent,
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(

        splashColor: Colors.green,
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery
            .of(context)
            .size
            .width,

        onPressed: () {
          final name = nameController.text;
          final link = linkController.text;
          createCourse(name: name, link: link);
          setState(() {
            nameController.text = '';
            linkController.text='';
          });
        },
        child: Text(
          "Submit",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold,
          ),
        ),

      ),

    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(


        title: Text("Add data"),
        backgroundColor: Colors.greenAccent,
        elevation: 0,

      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    SizedBox(height: 45),
                    NameField,
                    SizedBox(height: 20),
                    linkField,
                    SizedBox(height: 20),
                    submitButton,
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future createCourse({required String name, required String link}) async {
    final docCourse = FirebaseFirestore.instance.collection('CommunicationSkillCourses').doc();
    final docRef = docCourse.collection('CommunicationSkillCourses').doc();
    final json ={
      'Name': name,
      'Link': link,
      'id': docRef.id,
    };
    await docCourse.set(json);
  }
}


