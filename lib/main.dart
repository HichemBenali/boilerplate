import 'package:crm_app/core/pool.dart';
import 'package:crm_app/routes/router.dart';
import 'package:crm_app/services/groups.dart';
import 'package:crm_app/services/client.dart';
import 'package:crm_app/services/media.dart';
import 'package:crm_app/services/visits.dart';
import 'package:flutter/material.dart';
// import 'package:crm_app/services/auth.service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Pooled Providers
    var pool = Pool();
    pool.providers = [
      GroupsService(),
      ClientService(),
      VisitsService(),
      MediaService()
    ];

    return MaterialApp(
      title: 'CRM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/",
      routes: routes,
    );
  }
}
