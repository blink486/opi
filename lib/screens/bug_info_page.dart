import 'dart:io';

// import 'package:device_info_example/api/device_info_api.dart';
// import 'package:device_info_example/api/ip_info_api.dart';
// import 'package:device_info_example/api/package_info_api.dart';
// import 'package:device_info_example/main.dart';
// import 'package:device_info_example/widget/info_widget.dart';
import 'package:flutter/material.dart';
import 'package:moodclicks/services/ip_info_api.dart';

class BugInfoPage extends StatefulWidget {
  @override
  _BugInfoPageState createState() => _BugInfoPageState();
}

class _BugInfoPageState extends State<BugInfoPage> {
  Map<String, dynamic> map = {};
  late String me2;

  @override
  void initState() {
    super.initState();
    // init().then((value) {});
    init();
  }

  Future init() async {
    final ipAddress = await IpInfoApi.getIPAddress();
    if (!mounted) return;
    setState(() => map = {
          'IP Address': ipAddress,
        });
    late String me = ipAddress.toString();
    print(me);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('HtlloeT'),
          centerTitle: true,
        ),
        body: Center(
          child: Text("me2"),
        ),
      );
}
