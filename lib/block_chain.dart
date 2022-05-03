import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
// import 'package:hello_world/contract_linking.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/contracts.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

import 'auth/saveYourCredentials.dart';

final String _rpcUrl = "http://10.0.2.2:7545";
// final String _wsUrl = "ws://127.0.0.1:7545/";
final String _wsUrl = "ws://10.0.2.2:7545/";
final String _privateKey = "1d54c8c368d5ede0e46fa7d867147a53b78a0a35158e7f6531625fd44d0da7a9";



class ContractLinking extends ChangeNotifier {

  late Web3Client _client;
  bool isLoading = true;

  late String _abiCode;
  late EthereumAddress _contractAddress;

  late Credentials _credentials;

  late DeployedContract _contract;


  late ContractFunction _yourName;
  late ContractFunction _setName;

  late String deployedName;

  List<Message>  messages = [];
  late ContractFunction _getmessages;
  late ContractFunction _sendMessages;
  late ContractEvent messageEvent;


  ContractLinking() {
    initialSetup();
  }

  initialSetup() async {

    // establish a connection to the ethereum rpc node. The socketConnector
    // property allows more efficient event streams over websocket instead of
    // http-polls. However, the socketConnector property is experimental.
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });

    // Response res = await http.get(Uri.parse( _rpcUrl));
    // print('res.statusCode');
    // print(res.statusCode);

    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {

    // Reading the contract abi
    String abiStringFile =
    await rootBundle.loadString("assets/artifacts/HelloWorld.json");
    print("1");

    var jsonAbi = jsonDecode(abiStringFile);
    print("2");
    print(jsonAbi.toString());

    _abiCode = jsonEncode(jsonAbi["abi"]);

    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  Future<void> getCredentials() async {

    _credentials = await _client.credentialsFromPrivateKey(_privateKey);
  }

  Future<void> getDeployedContract() async {

    // Telling Web3dart where our contract is declared.
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "HelloWorld"), _contractAddress);

    // Extracting the functions, declared in contract.
    _yourName = _contract.function("yourName");
    _setName = _contract.function("setName");
    _getmessages = _contract.function("getmeeasgeList");
    _sendMessages  =_contract.function("pushTomeeasgeList");
     messageEvent = _contract.event('Message');


    getName();
  }


  checkMessages(){
  }

  getName() async {

    // Getting the current name declared in the smart contract.
    // var currentName = await _client.call(contract: _contract, function: _yourName, params: []);
    // deployedName = currentName[0];

    var messagesRespond = await _client.call(contract: _contract, function: _getmessages, params: []);
     List res = messagesRespond[0];
     res.forEach((element) {
       messages.add(Message("sender",element));
     });
     print("messages");
     print(messages);
    isLoading = false;

    notifyListeners();
    final subscription = _client
        .events(FilterOptions.events(contract: _contract, event: messageEvent))
        .take(10)
        .listen((event) {
      final decoded = messageEvent.decodeResults(event.topics, event.data);

      final from = decoded[0] as String;
      final sender = decoded[1] as String;

      messages.insert(0,Message(  sender,from));

      notifyListeners();

      // final to = decoded[1] as EthereumAddress;
      // final value = decoded[2] as BigInt;

      print('$from sent');

    });
    print('messages.length');
    print(messages.length);


    await subscription.asFuture();
    await subscription.cancel();


  }

  setName(String nameToSet) async {

    // Setting the name to nameToSet(name defined by user)
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract, function: _setName, parameters: [nameToSet]));
    // getName();
  }
  sendMessage(String nameToSet,Function callback) async {

    // Setting the name to nameToSet(name defined by user)
    //  await _client.call(contract: _contract, function: _sendMessages, params: [nameToSet,"sender","reciever"]);

    await _client.sendTransaction(

        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _sendMessages,
            parameters: [nameToSet,userID,"reciever"],

          // gasPrice: EtherAmount.inWei(BigInt.one),
          // maxGas: 100000,
          // value: EtherAmount.fromUnitAndValue(EtherUnit.ether, 5),

        ),

    );
   // getName();
  }


}

class Message {

  String name;
  String text;
  Message(this.name, this.text);
}

