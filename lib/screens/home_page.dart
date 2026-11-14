import 'package:desafio_imc/model/Imc.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const new({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _alturaUsuarioController = TextEditingController(text: "");
  final TextEditingController _pesoUsuarioController = TextEditingController(text: "");

  double? _pesoUsuario = 0.0;
  double? _alturaUsuario = 0.0;
  double _resultado = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculo IMC",
          style: TextStyle(
            fontSize: 26,
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Altura:",
                  style: TextStyle(
                    fontSize: 21,
                  ),
                ),
                TextField(
                  controller: _alturaUsuarioController,
                  decoration: InputDecoration(
                    hint: Text("Insira sua atura (Em metros)")
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Peso:",
                  style: TextStyle(
                    fontSize: 21,
                  ),
                ),
                TextField(
                  controller: _pesoUsuarioController,
                  decoration: InputDecoration(
                    hint: Text("Insira seu peso (Em Kg)")
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                FocusManager().primaryFocus?.unfocus();

                _alturaUsuario = double.tryParse(
                  _alturaUsuarioController.text.replaceFirst(",", ".")
                );

                _pesoUsuario = double.tryParse(
                  _pesoUsuarioController.text.replaceFirst(",", ".")
                );

                debugPrint("Altura: ${_alturaUsuario.toString()}");
                debugPrint("Peso: ${_pesoUsuario.toString()}");

                if (
                  _alturaUsuario == null || _pesoUsuario == null
                ) {
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(
                      title: Text("Dados inválidos"),
                      content: Text("A altura ou peso informado não são válidos"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          }, 
                          child: Text("Ok!")                          
                        )
                      ],                
                    );
                  },);

                  _alturaUsuario = null;
                  _pesoUsuario = null;
                  _resultado = 0.0;

                  _alturaUsuarioController.text = "";
                  _pesoUsuarioController.text = "";
                }
                else if (_alturaUsuario != null && _pesoUsuario != null) {
                  Imc imc = Imc(altura: _alturaUsuario!, peso: _pesoUsuario!);
                  setState(() {
                    _resultado = imc.calcularImc();
                  });
                }
              },
              child: Text("Calcular")
            ),
          ),

          Divider(
            thickness: 2,
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Resultado: ${_resultado.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 21,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}