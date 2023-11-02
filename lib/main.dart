import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_currency_rate/Model/Currency.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          //Top Header
          appBar: AppBar(
            backgroundColor: Colors.white,
            actions: [
              const SizedBox(
                width: 12,
              ),
              const Expanded(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.menu,
                        color: Colors.black,
                      ))),
              const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Currency Rate",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  )),
              Image.asset("assets/images/top_header_icon.png")
            ],
          ),

          //Body Content.
          body: Body()),
    );
  }
}

class Body extends StatefulWidget {
  Body({
    super.key,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Currency> currencylist = [];

  Future getServerDate(BuildContext context) async {
    var url =
        "https://sasansafari.com/flutter/api.php?access_key=flutter123456";
    var value = await http.get(Uri.parse(url));
    if (currencylist.isEmpty) {
      if (value.statusCode == 200) {
        _showSnakeBar(context, "Update Success!");
        List jsonList = convert.jsonDecode(value.body);
        if (jsonList.isNotEmpty) {
          for (int i = 0; i < jsonList.length; i++) {
            setState(() {
              currencylist.add(
                Currency(
                  id: jsonList[i]["id"],
                  title: jsonList[i]["title"],
                  price: jsonList[i]["price"],
                  changes: jsonList[i]["changes"],
                  status: jsonList[i]["status"],
                ),
              );
            });
          }
        }
      } else {
        _showSnakeBar(context, "Error for update!");
      }
    }
    return value;
  }

  @override
  void initState() {
    // TODO: implement initState
    getServerDate(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            //Title text
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 0, 0),
              child: Row(
                children: [
                  Image.asset("assets/images/question_icon.png"),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    "About Rate fee",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),

            // Description
            const Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                textAlign: TextAlign.justify,
              ),
            ),

            //Title
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 16, 2, 0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(1000)),
                  color: Color.fromARGB(255, 119, 119, 119),
                ),
                height: 40,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Name",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Price",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Change",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

            //List Items Container
            Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2,
                child: ItemsFutureBuilder(context)),

            //Update Button
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 8),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 226, 226, 226),
                    borderRadius: BorderRadius.circular(1000)),
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Text after btn update
                    Expanded(
                        child: SizedBox(
                      child: Center(
                          child: Text("Last Update: ${_getUpdatedTime()}")),
                    )),

                    //btn update
                    SizedBox(
                      height: double.infinity,
                      width: 180,
                      child: TextButton.icon(
                        onPressed: () {
                          currencylist.clear();
                          ItemsFutureBuilder(context);
                        },
                        icon: const Icon(
                          CupertinoIcons.refresh_bold,
                          color: Color.fromARGB(255, 77, 77, 77),
                        ),
                        label: const Text(
                          "Update",
                          style: TextStyle(
                              color: Color.fromARGB(255, 77, 77, 77),
                              fontSize: 18),
                        ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(1000))),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 93, 182, 255))),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  FutureBuilder<dynamic> ItemsFutureBuilder(BuildContext context) {
    return FutureBuilder(
      future: getServerDate(context),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: currencylist.length,
                itemBuilder: (BuildContext context, int position) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: ListItems(position, currencylist),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  if (index % 4 == 0 && index != 0)
                    return const Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: AdsItem(),
                    );
                  else
                    return const SizedBox.shrink();
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  String _getUpdatedTime() {
    DateTime now = DateTime.now();
    return DateFormat('kk:mm:ss').format(now);
  }
}

//List Items
class ListItems extends StatelessWidget {
  int position;
  List<Currency> currencylist;
  ListItems(
    this.position,
    this.currencylist, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: const <BoxShadow>[
        BoxShadow(blurRadius: 0.1, color: Color.fromARGB(255, 179, 179, 179))
      ], color: Colors.white, borderRadius: BorderRadius.circular(1000)),
      height: 50,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(currencylist[position].title!),
          Text(currencylist[position].price!),
          Text(
            currencylist[position].changes!,
            style: currencylist[position].status == "n"
                ? TextStyle(color: Colors.red)
                : TextStyle(color: Colors.green),
          ),
        ],
      ),
    );
  }
}

//Ads Items
class AdsItem extends StatelessWidget {
  const AdsItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            const BoxShadow(
                blurRadius: 0.1, color: Color.fromARGB(255, 179, 179, 179))
          ],
          color: const Color.fromARGB(255, 255, 201, 86),
          borderRadius: BorderRadius.circular(1000)),
      height: 50,
      width: double.infinity,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Your ads"),
        ],
      ),
    );
  }
}

//Snake Bar Message
void _showSnakeBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      msg,
      style: TextStyle(fontSize: 18),
    ),
    duration: Duration(milliseconds: 1000),
    backgroundColor: Colors.green,
  ));
}
