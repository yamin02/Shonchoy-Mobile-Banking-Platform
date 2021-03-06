import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shonchoy/routes.dart';
import 'package:shonchoy/scoped_model/my_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild.unfocus();
          }
        },
        child: new ScopedModel<MyModel>(
            model: new MyModel(),
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                fontFamily: 'ProductSans',
                primarySwatch: Colors.green,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              routes: routes,
            )));
  }
}
