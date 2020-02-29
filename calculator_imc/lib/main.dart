import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: "Calculator IMC", home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weigthController = TextEditingController();
  TextEditingController heigthController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    weigthController.text = "";
    heigthController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calclute() {
    setState(() {
      double weigth = double.parse(weigthController.text);
      double heigth = double.parse(heigthController.text) / 100;

      double imc = weigth / (heigth * heigth);

      if (imc < 18.6) {
        _infoText = "Você está abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso ideal(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "obesidade grau 1(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "obesidade grau 2${imc.toStringAsPrecision(3)})";
      } else {
        _infoText = "obesidade grau 3(${imc.toStringAsPrecision(3)})";
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator IMC"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _resetFields();
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.account_circle,
                  size: 100, color: Colors.deepOrange),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso(Kg)",
                    labelStyle: TextStyle(color: Colors.deepOrange)),
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.deepOrange, fontSize: 20.0),
                controller: weigthController,
                validator: (value) {
                  if(value.isEmpty) {
                    return "Insira um valor";
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura(m)",
                    labelStyle: TextStyle(color: Colors.deepOrange)),
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.deepOrange, fontSize: 20.0),
                controller: heigthController,
                validator: (value){
                  if(value.isEmpty) {
                    return "Insira um valor";
                  }
                }
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                height: 50.0,
                child: RaisedButton(
                  onPressed: () {
                    if(_formKey.currentState.validate()) {
                      _calclute();
                    }
                  },
                  color: Colors.deepOrange,
                  padding: const EdgeInsets.all(10.0),
                  child: const Text('CALCULAR',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ),
            ),
            Text(
              _infoText,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.deepOrange, fontSize: 26.0),
            )
          ],
        ),
      )),
    );
  }
}
