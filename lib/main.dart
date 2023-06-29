import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

String stringResponse = "";
Map mapResponse = {};
Map dataResponse = {};
List listResponse = [];

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {

   Future apicall()async{
   http.Response response;
   http.Response responseSecond;
   response = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
   if (response.statusCode == 200)
   {
      setState((){
          //stringResponse = response.body;
          mapResponse = json.decode(response.body);
          listResponse = mapResponse['data'];
      });
   }

  }
  

  @override
  void initState() {
    apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Zigy - Technical Assignment"),
      ),
      body: ListView.builder(itemBuilder: (context, index){
          return SafeArea(
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.network(listResponse[index]['avatar']),
                      ),
                      
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 50, 10, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(listResponse[index]['first_name'].toString()),
                          Text(" "),
                          Text(listResponse[index]['last_name'].toString()),
                        ],
                      ),
                      Text(listResponse[index]['email'].toString()),
                      Text(listResponse[index]['id'].toString())
                    ],
                  ),
                ),
                ],
              ),
            ),
          );
      },
      itemCount: listResponse== null? 0: listResponse.length,
      
      ));
  }
}
