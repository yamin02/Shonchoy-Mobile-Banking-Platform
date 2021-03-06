import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shonchoy/controller/APIController.dart';
import 'package:shonchoy/model/transaction.dart';
import 'package:shonchoy/scoped_model/my_model.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> {
  bool isLoading = true;
  double balance = 0;
  List<Transaction> transactions = new List<Transaction>();

  @override
  void initState() {
    super.initState();
    getTransactions();
  }

  void getTransactions() async {
    setState(() {
      isLoading = true;
    });
    transactions = await APIController.getTransactions(
        ScopedModel.of<MyModel>(context).personal.authToken);
    balance = await APIController.getBalance(
        ScopedModel.of<MyModel>(context).personal.authToken);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        //bottom: false,
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Image.asset('images/hamburger.png'),
                  onPressed: () {},
                ),
                Spacer(
                  flex: 1,
                ),
                Text(
                  'Your Wallet',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                Spacer(
                  flex: 8,
                ),
                GestureDetector(
                  child: Image.asset(
                    'images/profile.png',
                    scale: 20,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
                //transitionOnUserGestures: true,
              ],
            ),
          ),
          Container(
            height: 220,
            margin: EdgeInsets.all(24),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.red, Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(15)),
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Balance',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  isLoading
                      ? Container(
                          height: 24,
                        )
                      : Text(
                          '৳' + balance.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                        ),
                  Spacer(),
                  Text(
                    'Account Holder',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  Text(
                    ScopedModel.of<MyModel>(context).personal.client.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(24, 0, 24, 20),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        IconButton(
                          onPressed: () {},
                          iconSize: 50,
                          icon: Image.asset('images/cashIn.png'),
                        ),
                        Text(
                          'Request',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/cashout');
                          },
                          iconSize: 50,
                          icon: Image.asset('images/cashOut.png'),
                        ),
                        Text(
                          'Cash Out',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/sendmoney');
                          },
                          iconSize: 50,
                          icon: Image.asset('images/sendMoney.png'),
                        ),
                        Text(
                          'Send Money',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        IconButton(
                          onPressed: () {},
                          iconSize: 50,
                          icon: Image.asset('images/payment.png'),
                        ),
                        Text(
                          'Payment',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Transactions',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                GestureDetector(
                  child: Icon(Icons.replay),
                  onTap: () async {
                    getTransactions();
                  },
                )
              ],
            ),
          ),
          isLoading
              ? Center(
                  child: CupertinoActivityIndicator(),
                )
              : Expanded(
                  child: transactions.length < 1
                      ? Padding(
                          padding: EdgeInsets.all(24),
                          child: Text('No transactions'))
                      : ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                margin: EdgeInsets.all(1),
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                child: Padding(
                                  padding: EdgeInsets.all(22),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Tab(
                                          icon: new Image.asset("images/" +
                                              transactions[index].type +
                                              ".png")),
                                      Spacer(
                                        flex: 2,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            transactions[index].sender +
                                                ' -> ' +
                                                transactions[index].receiver,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(transactions[index].type),
                                        ],
                                      ),
                                      Spacer(
                                        flex: 5,
                                      ),
                                      Text(
                                        transactions[index].pos == "sender"
                                            ? '-৳' + transactions[index].amount
                                            : '+৳' + transactions[index].amount,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: transactions[index].pos ==
                                                    "sender"
                                                ? Colors.red
                                                : Colors.green),
                                      ),
                                    ],
                                  ),
                                ),
                                color: Colors.white);
                          },
                          itemCount: transactions.length,
                        ))
        ]),
      ),
    );
  }
}
