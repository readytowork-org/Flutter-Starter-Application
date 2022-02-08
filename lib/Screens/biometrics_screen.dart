import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart';

class BiometricsScreen extends StatefulWidget {
  const BiometricsScreen({Key? key}) : super(key: key);

  @override
  _BiometricsScreenState createState() => _BiometricsScreenState();
}

class _BiometricsScreenState extends State<BiometricsScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  bool enableBiometricsValue = false;

  @override
  void initState() {
    super.initState();
    datafromHiveBox();
  }

  Future<void> datafromHiveBox() async {
    var box = await Hive.openBox('mainBox');
    setState(() {
      enableBiometricsValue = box.get('biometricsValue') ?? false;
    });
  }

  enableBiometrics() async {
    try {
      var box = await Hive.openBox("mainBox");
      if (!enableBiometricsValue) {
        bool authenticated = await auth.authenticate(
            localizedReason: "Please complete the Biometrics to proceed",
            useErrorDialogs: true,
            stickyAuth: true,
            biometricOnly: true);
        box.put('biometricsValue', authenticated);
        datafromHiveBox();
        setState(() {});
      } else {
        box.put('biometricsValue', false);
        datafromHiveBox();
      }
    } on PlatformException catch (e) {
      Navigator.pop(context);
      print("Error while opening fingerprint/face scanner $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Biometrics"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fingerprint,
              size: MediaQuery.of(context).size.height / 3,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
                enableBiometricsValue
                    ? "Fingerprint Authentication enabled."
                    : "Please enable fingerprint for login.",
                style: const TextStyle(fontSize: 20)),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: enableBiometrics,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      enableBiometricsValue
                          ? "Disable Fingerprint"
                          : "Enable Fingerprint",
                      style: const TextStyle(fontSize: 18)),
                )),
          ],
        ),
      ),
    );
  }
}
