import 'package:agroon/data/provider/productprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Demo extends StatefulWidget {
  const Demo({Key key}) : super(key: key);

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Provider.of<ProductProvider>(context, listen: false).getsingleProductData();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
