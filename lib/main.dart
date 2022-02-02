import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool maleColor = false;
  bool femaleColor = true;

  void invert() {
    setState(() {
      maleColor = !maleColor;
      femaleColor = !femaleColor;
    });
  }

  void gender() {
    _message = maleColor ? _imcMale : _imcFemale;
  }

  double _peso = 0.0;
  double _altura = 0.0;
  String _imc = "";

  final _imcMale =
      'IMC ideal\n19-24\n20-25\n20-25\n21-26\n22-27\n23-38\n24-29\n25-30';

  final _imcFemale =
      'IMC ideal\n19-24\n19-24\n19-24\n20-25\n21-26\n22-27\n23-28\n25-30';

  String _message = "";

  final controladorPeso = TextEditingController();
  final controladorAltura = TextEditingController();

  void pesoFuntion() {
    _peso = double.parse(controladorPeso.text.toString());
  }

  void alturaFuntion() {
    _altura = double.parse(controladorAltura.text.toString());
  }

  void imcFuntion() {
    _imc = (_peso / (_altura * _altura)).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text('Calcular IMC'),
        actions: [
          IconButton(
            onPressed: () {
              setState(
                () {
                  controladorAltura.clear();
                  controladorPeso.clear();
                },
              );
            },
            icon: Icon(Icons.delete_forever),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(18),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Ingresa tus datos para calcular el IMC",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.female),
                    iconSize: 30,
                    color: femaleColor ? Colors.red : Colors.grey,
                    onPressed: () {
                      femaleColor ? null : invert();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.male),
                    iconSize: 30,
                    color: maleColor ? Colors.blue : Colors.grey,
                    onPressed: () {
                      maleColor ? null : invert();
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: TextField(
                cursorColor: Colors.green[700],
                controller: controladorAltura,
                keyboardType: TextInputType.number,
                obscureText: false,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.square_foot,
                    //color: altura ? Colors.green[700] : Colors.grey,
                  ),
                  enabledBorder: const OutlineInputBorder(),
                  labelText: "Ingresar altura (Metros)",
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: TextField(
                cursorColor: Colors.green[700],
                controller: controladorPeso,
                keyboardType: TextInputType.number,
                obscureText: false,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.monitor_weight_outlined,
                    //color: altura ? Colors.green[700] : Colors.grey,
                  ),
                  enabledBorder: const OutlineInputBorder(),
                  labelText: "Tu peso (Kg)",
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            TextButton(
              child: Text(
                "Calcular",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                alturaFuntion();
                pesoFuntion();
                imcFuntion();
                gender();
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (_) => AlertDialog(
                    title: Text("Tu IMC: $_imc"),
                    content: Wrap(
                      runSpacing: 18,
                      spacing: 18,
                      children: [
                        Text(maleColor
                            ? "Tabla del IMC ideal Hombres"
                            : "Tabla del IMC ideal Mujeres"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                                "Edad\n 16-17 \n 18-18 \n 19-24 \n 25-34 \n 35-44 \n 45-54 \n 55-64 \n 65-90"),
                            Text(_message),
                          ],
                        )
                      ],
                    ),
                    actions: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Aceptar",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
