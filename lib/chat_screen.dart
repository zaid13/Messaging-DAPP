import 'package:blockchain_flutter/block_chain.dart';
import 'package:flutter/material.dart';
// import 'package:hello_world/contract_linking.dart';
import 'package:provider/provider.dart';

import 'auth/saveYourCredentials.dart';
import 'chat/chat.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // Getting the value and object or contract_linking
    var contractLink = Provider.of<ContractLinking>(context);

    TextEditingController yourNameController = TextEditingController();
    var lstCtrol  = ScrollController();

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

                      Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width-70,
                        child: ListView.builder(
                          controller: lstCtrol,
                            reverse:true,
                          itemCount:  contractLink.messages.length,
                            itemBuilder: (ctx, index){
                            return Chat( contractLink.messages[index].text,userID==contractLink.messages[index].name);

                              return Text(
                            contractLink.messages[index].text,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 52,
                                color: Colors.tealAccent),
                          );
                        }

                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 29),
                    child: TextFormField(
                      controller: yourNameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Message",
                          hintText: "Enter Message",
                          icon: Icon(Icons.drive_file_rename_outline)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: ElevatedButton(
                      child: Text(
                        'Send',
                        style: TextStyle(fontSize: 30),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      onPressed: () {
                        contractLink.sendMessage(yourNameController.text,(){

                        });
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
