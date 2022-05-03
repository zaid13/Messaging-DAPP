import 'dart:convert';
import 'dart:io';

import 'package:blockchain_flutter/auth/signUp.dart';
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
import 'dart:math'; //used for the random number generator

final String _rpcUrl = "http://10.0.2.2:7545";
// final String _wsUrl = "ws://127.0.0.1:7545/";
final String _wsUrl = "ws://10.0.2.2:7545/";
final String _privateKey = "81503c71d89add43f585173a7db3ea553e8aa512a782b4aa53a36e401ade4e70";



class RegisterContractLinking extends ChangeNotifier {

  late Web3Client _client;
  bool isLoading = true;

  late String _abiCode;
  late EthereumAddress _contractAddress;

  late Credentials _credentials;

  late DeployedContract _contract;


  late ContractFunction register;
  late ContractFunction _setName;

  late String deployedName;

  List  messages = [];
  List  users = [];

  late ContractFunction _getmessages;
  late ContractFunction _getusers;
  late ContractFunction _sendMessages;
  late ContractEvent messageEvent;


  RegisterContractLinking() {
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
    register = _contract.function("register");
     // messageEvent = _contract.event('Message');
    _getusers = _contract.function("getUserList");



    // getName();
  }


  checkMessages(){
  }
  getUsers() async {

    // Getting the current name declared in the smart contract.
    var Resusers = await _client.call(contract: _contract, function: _getusers, params: []);
    List lst  = Resusers[0];
    print(Resusers[0]);
    print("element");
    lst.forEach((element) {
      print('element');
      print(element);
      users.add(lst);
    });


    notifyListeners();


  }

  getName() async {

    // Getting the current name declared in the smart contract.
    var currentName = await _client.call(contract: _contract, function: register, params: []);
    deployedName = currentName[0];

    var messagesRespond = await _client.call(contract: _contract, function: _getmessages, params: []);
     messages = messagesRespond[0];
    isLoading = false;

    notifyListeners();
    final subscription = _client
        .events(FilterOptions.events(contract: _contract, event: messageEvent))
        .take(10)
        .listen((event) {
      final decoded = messageEvent.decodeResults(event.topics, event.data);

      final from = decoded[0] as String;
      messages.insert(0, from);
      notifyListeners();

      // final to = decoded[1] as EthereumAddress;
      // final value = decoded[2] as BigInt;

      print('$from sent');
    });
    print('messages.length');
    print(messages.length);

    messages = messagesRespond[0];
    isLoading = false;
    await subscription.asFuture();
    await subscription.cancel();


  }

  registerNewUser(String name,) async {


    isLoading = true;
    notifyListeners();
    Map newCredentials = await getNewAddressworkign();
    EthereumAddress address = newCredentials['address'];
    String  key  = newCredentials['key'];



    var messagesRespond =    await _client.call(
        contract: _contract,
        function:register,
        params: [address,name,key]);
    if(messagesRespond[0]){
      print("success");
    }else{
      print("error");

    }
    isLoading = false;

    return {"key":key,"address":address};

    // getName();
  }


  sendMessage(String nameToSet,Function callback) async {

    // Setting the name to nameToSet(name defined by user)

    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract, function: _sendMessages, parameters: [nameToSet]));
    // getName();
  }


}


getNewAddress() async {

  var key = new Random.secure().toString();
  Credentials fromHex = EthPrivateKey.fromHex(key);
  // Credentials fromHex = EthPrivateKey.fromHex("0x5aaeb6053f3e94c9b9a09f33669435e7ef1beaed");
  // var key = new Random.secure();

  EthereumAddress address =await fromHex.extractAddress();

  print(address.toString());
  print(key);

  return {"key":key,"address":address};

}

List addressList = ["0x3ed8B3A79dF21E510e1beF074310e9f6C3310b83",
                    "0x8df6d3053d16c85eF37eebefA357a763395af1E6"];

List keyList = ["0x3ed8B3A79dF21E510e1beF074310e9f6C3310b83",
  "0x8df6d3053d16c85eF37eebefA357a763395af1E6"];



Future<Map> getNewAddressworkign() async {

  var key = NAME=="zaid"?keyList[0]:keyList[1];
  Credentials fromHex = EthPrivateKey.fromHex( NAME=="zaid"?addressList[0]:addressList[1]);
  // Credentials fromHex = EthPrivateKey.fromHex("0x5aaeb6053f3e94c9b9a09f33669435e7ef1beaed");
  // var key = new Random.secure();

  EthereumAddress address =await fromHex.extractAddress();

  print(address.toString());
  print(key);

  return {"key":key,"address":address.toString()};

}