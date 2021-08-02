import 'package:btctrackster/networking.dart';
import 'package:flutter/material.dart';
import 'package:btctrackster/coin_data.dart';

//const openUrl = 'https://apiv2.bitcoinaverage.com/indices/global/ticker/BTCAUD';

const openUrl = 'https://blockchain.info/tobtc?currency=';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selected = "AUD";
  double fetchedAll = 0.0;

  double showResult = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("here col");
    getDetails();
  }

  Future<String> _calculation = Future<String>.delayed(
    Duration(seconds: 2),
    () => 'Data Loaded',
  );

  Future getDetails() async {
//    openUrl = openUrl + "A";
//    NetworkHelper networkHelper = NetworkHelper('$openUrl' + 'BTC$selected');
    NetworkHelper networkHelper = NetworkHelper(openUrl + '$selected&value=1');

    fetchedAll = await networkHelper.getData();
    print(fetchedAll);

    setState(() {
      showResult = fetchedAll;
    });
    return CircularProgressIndicator();
  }

  List<DropdownMenuItem> getCurrencies() {
//    for (String a in currenciesList) {
//      print(a);
//    }
    List<DropdownMenuItem<String>> allItems = [];

//    for (int i = 0; i < currenciesList.length; i++) {
//      print(currenciesList[i]);
//      String menuItem = currenciesList[i];
//
//      var items = DropdownMenuItem(
//        child: Text(menuItem),
//        value: menuItem,
//      );
////
////      return allItems;
////      allItems = allItems.allItems;
//      allItems.add(items);
//    }

    for (String menuItem in currenciesList) {
      var items = DropdownMenuItem(
        child: Text(menuItem),
        value: menuItem,
      );
//
//      return allItems;
//      allItems = allItems.allItems;
      allItems.add(items);
    }
    return allItems;
//     allItems.add(items);
  }

  @override
  Widget build(BuildContext context) {
//    getCurrencies();

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $showResult $selected',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          FutureBuilder(
            future:
                getDetails(), // a previously-obtained Future<String> or null
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                children = <Widget>[
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Result: ${snapshot.data}'),
                  )
                ];
              } else if (snapshot.hasError) {
                children = <Widget>[
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  )
                ];
              } else {
                children = <Widget>[
                  SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  )
                ];
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: children,
                ),
              );
            },
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
                value: selected,
                items: getCurrencies(),
                onChanged: (value) async {
                  print(value);
//                  getCurrencies();

                  setState(() {
                    selected = value;
                  });

                  await getDetails();
                }),
          ),
        ],
      ),
    );
  }
}
