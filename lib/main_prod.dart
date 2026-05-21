import 'package:flutter/material.dart';

import 'app/flavor_config.dart';
import 'main_app.dart';

void main(){

FlavorConfig.initialize(

FlavorConfig(

flavor: Flavor.prod,

appName:
'Movie Explorer',

apiBaseUrl:
'https://www.omdbapi.com/',
),
);

runApp(
const MainApp(),
);
}