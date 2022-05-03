import 'package:blockchain_flutter/block_chain.dart';
import 'package:flutter/material.dart';
// import 'package:hello_world/contract_linking.dart';
import 'package:provider/provider.dart';

import 'chat/chat.dart';

class HelloUI extends StatelessWidget {

  var myId ;
  HelloUI(this.myId);
  @override
  Widget build(BuildContext context) {

    // Getting the value and object or contract_linking
    var contractLink = Provider.of<ContractLinking>(context);

    TextEditingController yourNameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Hello World !"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: contractLink.isLoading
              ? CircularProgressIndicator()
              : SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Chat(contractLink.deployedName,true),

                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 29),
                    child: TextFormField(
                      controller: yourNameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Your Name",
                          hintText: "What is your name ?",
                          icon: Icon(Icons.drive_file_rename_outline)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: ElevatedButton(
                      child: Text(
                        'Set Name',
                        style: TextStyle(fontSize: 30),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      onPressed: () {
                        contractLink.setName(yourNameController.text);
                        yourNameController.clear();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
