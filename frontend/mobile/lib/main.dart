import 'package:flutter/material.dart';
import 'package:mobile/providers/auth_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/providers/product_provider.dart';
import 'package:mobile/screens/add_product.dart';
import 'package:mobile/screens/chat.dart';
import 'package:mobile/screens/contacts.dart';
import 'package:mobile/screens/map_page.dart';
import 'package:mobile/screens/scanresults.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile/providers/scanned_plant_provider.dart';
import 'package:mobile/screens/home.dart';
import 'package:mobile/screens/login.dart';
import 'package:mobile/screens/register.dart';
import 'package:mobile/screens/setup.dart';
import 'package:provider/provider.dart';
import 'utils/colors.dart';
import 'screens/landing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("isStarted", false);
  prefs.setString('token', '');
  bool isStarted = prefs.getBool('isStarted') ?? false;
  String token = prefs.getString('token') ?? '';
  runApp(App(isStarted: isStarted, token: token));
}

class App extends StatefulWidget {
  final bool isStarted;
  final String token;
  const App({super.key, required this.isStarted, required this.token});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ScannedPlantProvider([]),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider([]),
        ),
      ],
      child: MaterialApp(
        title: "Floravert",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: primary,
              backgroundColor: background,
            )),
        initialRoute: widget.token.isNotEmpty
            ? '/'
            : (widget.isStarted ? '/login' : '/landing'),
        routes: {
          '/': (context) => const Home(),
          '/landing': (context) => const Landing(),
          '/login': (context) => const Login(),
          '/register': (context) => const Register(),
          '/setup': (context) => const Setup(),
          '/contacts': (context) => const Contacts(),
          '/chat': (context) => const Chats(),
          '/scanned': (context) => const ScannedResult(),
          '/map': (context) => const MapPage(),
          '/add/product': (context) => const AddProductForm()
        },
      ),
    );
  }
}
