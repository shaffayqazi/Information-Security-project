import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home_page(),
    );
  }
}

class Home_page extends StatefulWidget {
  const Home_page({Key? key}) : super(key: key);

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  String result = " ";
  TextEditingController Textcontroller = TextEditingController();
  TextEditingController Numbercontroller = TextEditingController();
  TextEditingController Outputcontroller = TextEditingController();

  String caesar(String text, int key, int encrypt) {
    String result = "";

    for (var i = 0; i < text.length; i++) {
      int ch = text.codeUnitAt(i), offset = 0, x = 0;

      if (ch >= 'a'.codeUnitAt(0) && ch <= 'z'.codeUnitAt(0))
        offset = 97;
      else if (ch >= 'A'.codeUnitAt(0) && ch <= 'Z'.codeUnitAt(0))
        offset = 65;
      else if (ch == ' '.codeUnitAt(0)) {
        result += " ";
        continue;
      }

      if (encrypt == 1) {
        x = (ch + key - offset) % 26;
      } else
        x = (ch - key - offset) % 26;

      result += String.fromCharCode(x + offset);
    }
    return result;
  }

  // void testdata()
  // {
  //   String ans= "";
  //   String plaintext = "hello world";
  //   var ch ='';
  //   int n=0;
  //   int i=0;
  //   for(i =0;i<plaintext.length;i++)
  //     {
  //       ch = plaintext[i];
  //       if(ch==" ")
  //         {
  //           ans+= " ";
  //         }
  //       else if(ch.characters== ch.characters.toUpperCase())
  //         {
  //           ans+=
  //         }
  //     }
  // }

  @override
  void initState() {
    super.initState();
    String out = caesar("Hello my name is adsd", 15, 1);
    print(out);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
                child: Text(
              "Caeser Cipher",
              style: TextStyle(color: Colors.black, fontSize: 45),
            )),
            SizedBox(
              height: 50,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black, width: 1)),
              child: TextField(
                controller: Textcontroller,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 11, top: 11, right: 15),
                    // enabledBorder: OutlineInputBorder(
                    //     borderSide: BorderSide(color: Colors.black, width: 1)),
                    hintText: "Enter the Text"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black, width: 1)),
              child: TextField(
                controller: Numbercontroller,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 11, top: 11, right: 15),
                    // enabledBorder: OutlineInputBorder(
                    //     borderSide: BorderSide(color: Colors.black, width: 1)),
                    hintText: "Enter the key value"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.stretc,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        result = caesar(Textcontroller.text,
                            int.parse(Numbercontroller.text), 1);
                      });
                    },
                    child: Container(
                      width: 120,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                          child: Text(
                        "Encrypt",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        result = caesar(Textcontroller.text,
                            int.parse(Numbercontroller.text), 0);
                      });
                    },
                    child: Container(
                      width: 120,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                          child: Text(
                        "Decrypt",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Output",
                  style: TextStyle(fontSize: 20),
                ),
                InkWell(
                  onTap: ()
                  {
                    setState(() {
                      Clipboard.setData(new ClipboardData(text: Outputcontroller.text))
                          .then((_) {

                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Copied to your clipboard !')));
                      });
                    });
                  },
                  child: Container(
                    width: 50,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black, width: 1)),
                  child: const Center(child: Text("Copy")),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black, width: 1)),
              child: TextField(
                maxLines: 8,
                controller: TextEditingController(text: result),
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "Output will be shown here",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
