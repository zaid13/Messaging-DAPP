

import 'package:blockchain_flutter/auth/auth_block_chain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../chat_screen.dart';

class AllChat extends StatefulWidget {
  const AllChat({Key? key}) : super(key: key);

  @override
  _AllChatState createState() => _AllChatState();
}

class _AllChatState extends State<AllChat> {

  List usersList = [];
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: Container(
        child: FutureBuilder<Map>(
          future: getNewAddressworkign(),
          builder: (context, snapshot) {
            if(snapshot.data==null)
            return Text("Loading");
            var mp   = snapshot.data;
            if(mp!=null) {
            usersList = [
              {"key":mp['key'] ,"address":mp['address']}
            ];}

            return ListView.builder(
              itemCount: usersList.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(
                          builder: (context)=> ChatScreen()
                      ));


                    },
                    child: ConversationList(usersList[index]['key'],usersList[index]['address']));
              },
            );
          }
        ),
      ),

    );
  }
}


class ConversationList extends StatelessWidget {
  String name;
  String Address;
   ConversationList(this.name,this.Address) ;

  @override
  Widget build(BuildContext context) {
    return Container(
     child:Column(
        children: [
          Text(name),
          Text(Address),

        ],
      )
    );
  }
}
