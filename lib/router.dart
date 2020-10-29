import 'package:crm_app/core/storage.dart';
import 'package:crm_app/routes/route.dart';
import 'package:crm_app/services/auth.dart';
import 'package:crm_app/views/media/files.dart';
import 'package:crm_app/views/media/images.dart';
// import 'package:crm_app/views/media/player.dart';
import 'package:crm_app/views/media/video.dart';
import 'package:crm_app/views/splashscreen.dart';
import 'package:crm_app/views/visits/add.dart';
import 'package:crm_app/views/visits/edit.dart';
import 'package:flutter/material.dart';
import 'package:crm_app/views/clients/add.dart';
import 'package:crm_app/views/clients/edit.dart';
import 'package:crm_app/views/network/add.dart';
import 'package:crm_app/views/network/edit.dart';
import 'package:crm_app/views/calendar/index.dart';
import 'package:crm_app/views/clients/index.dart';
import 'package:crm_app/views/home.dart';
import 'package:crm_app/views/intro.dart';
import 'package:crm_app/views/login.dart';
import 'package:crm_app/views/media/index.dart';
import 'package:crm_app/views/network/index.dart';
import 'package:crm_app/views/notification.dart';
import 'package:crm_app/views/search.dart';
import 'package:crm_app/views/settings.dart';
import 'package:crm_app/views/visits/index.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

var homeRoutes = {
  "network": MainRoute(
      "Mon réseau", "/network", Icons.people, FontAwesomeIcons.networkWired),
  "clients": MainRoute("Fiches Clients", "/clients", Icons.account_circle,
      FontAwesomeIcons.users),
  "visits": MainRoute(
      "Visites", "/visits", Icons.star, FontAwesomeIcons.calendarCheck),
  "calendar": MainRoute("Calendrier", "/calendar", Icons.calendar_today,
      FontAwesomeIcons.calendarAlt),
  "media":
      MainRoute("Média", "/media", Icons.image, FontAwesomeIcons.photoVideo),
  "settings": MainRoute(
      "Parametres", "/settings", Icons.settings, FontAwesomeIcons.cogs),
};

_load() async {
  return {
    "first": await StorageDriver().read("first"),
    "auth": await AuthService().isAuthenticated()
  };
}

Widget _build(BuildContext context, AsyncSnapshot snapshot) {
  if (snapshot.connectionState == ConnectionState.done) {
    if (snapshot.data["first"] != "true") {
      StorageDriver().write("first", "true");
      return IntroPage();
    } else if (snapshot.data["auth"]) {
      return HomePage();
    } else {
      return LoginPage();
    }
  } else if (snapshot.connectionState == ConnectionState.waiting) {
    return SplashScreen();
  }

  return Scaffold(
    body: Text("Error"),
  );
}

var routes = {
  "/": (context) => FutureBuilder(
        future: _load(),
        builder: _build,
      ),
  "/network": (context) => NetworkPage(),
  "/network/add": (context) => AddNetworkPage(),
  "/network/edit": (context) => EditNetworkPage(),
  "/clients": (context) => ClientsPage(),
  "/clients/add": (context) => AddClientPage(),
  "/clients/edit": (context) => EditClientPage(),
  "/visits": (context) => VisitsPage(),
  "/visits/add": (context) => AddVisitsPage(),
  "/visits/edit": (context) => EditVisitsPage(),
  "/calendar": (context) => CalendarPage(),
  "/media": (context) => MediaPage(),
  "/media/images": (context) => ImagesPage(),
  "/media/videos": (context) => VideosPage(),
  "/media/files": (context) => FilesPage(),
  "/settings": (context) => SettingsPage(),
  "/notifications": (context) => NotificationPage(),
  "/intro": (context) => IntroPage(),
  "/search": (context) => SearchPage()
};
