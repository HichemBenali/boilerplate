class MainRoute {
  String name;
  String route;
  var svg;
  var icon;

  MainRoute(String name, String route, icon, [svg = ""]) {
    this.name = name;
    this.route = route;
    this.icon = icon;
    this.svg = svg;
  }
}
