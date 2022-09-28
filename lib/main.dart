import 'package:desafio/componentes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(const AppImc());
}

class AppImc extends StatefulWidget {
  const AppImc({super.key});

  @override
  State<AppImc> createState() => _AppImcState();
}

class _AppImcState extends State<AppImc> {
  bool isDarkTheme = false;

  TextEditingController controllerAltura = TextEditingController();
  TextEditingController controllerPeso = TextEditingController();

  GlobalKey<FormState> controllerForm = GlobalKey<FormState>();

  String resposta = "Informe seus dados!";
  Color corResposta = Colors.amber;

  bool validaSeEhNumero(controller) {
    String medidas = controller.text;
    var medida = double.tryParse(medidas);
    print("valida se e numero ${medida}");
    if (medida == null) {
      return false;
    } else {
      return true;
    }
  }

  String calculaImc() {
    setState(
      () {
        double peso = double.parse(controllerPeso.text);
        double altura = double.parse(controllerAltura.text);
        double imc = peso / (altura * altura);
        String imcS = imc.toStringAsFixed(2);

        if (imc < 18.5) {
          resposta = "Imc de $imcS: Abaixo do peso ideal";
          corResposta = Colors.blue;
        } else if (imc > 18.5 && imc <= 25) {
          resposta = "Imc de $imcS: Peso Ideal ";
          corResposta = Colors.green;
        } else if (imc > 25 && imc <= 30) {
          resposta = "Imc de $imcS: Sobrepeso ";
          corResposta = Colors.yellow;
        } else if (imc > 30 && imc <= 35) {
          resposta = "Imc de $imcS: Obesidade Grau I ";
          corResposta = Colors.orange.shade200;
        } else if (imc > 35 && imc <= 40) {
          resposta = "Imc de $imcS: Obesidade Grau II ";
          corResposta = Colors.orange.shade800;
        } else {
          resposta = "Imc de $imcS: Obesidade mórbida";
          corResposta = Colors.red;
        }
      },
    );
    return resposta;
  }

  limparTela() {
    controllerPeso.text = "";
    controllerAltura.text = "";
    setState(() {
      resposta = "Informe seus dados!";
      controllerForm = GlobalKey<FormState>();
    });
  }

  mudaTema() {
    setState(() {
      isDarkTheme = !isDarkTheme;
    });
  }

  @override
  void dispose() {
    controllerAltura.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: Colors.amberAccent),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.amberAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.amber),
          ),
        ),
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }

  Widget HomePage() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade400,
        title: isDarkTheme
            ? Componentes().criaTexto("Calculadora de IMC", Colors.black, 30)
            : Componentes().criaTexto("Calculadora de IMC", Colors.white, 30),
        toolbarHeight: 100,
        actions: [
          IconButton(
            onPressed: limparTela,
            icon: Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: (() => {
                  mudaTema(),
                }),
            icon: isDarkTheme
                ? Icon(Icons.wb_sunny_rounded)
                : Icon(
                    Icons.bedtime,
                    color: Colors.grey.shade700,
                  ),
          ),
        ],
      ),
      body: Form(
        key: controllerForm,
        child: Column(
          children: [
            Componentes().criaIconeGrande(),
            Componentes().criaInput(
              "Altura",
              controllerAltura,
              "Informe sua altura!",
              "Altura deve utlizar apenas numeros e pontos (.) Ex: 1.81",
            ),
            Componentes().criaInput(
              "Peso",
              controllerPeso,
              "Informe seu Peso!",
              "Peso deve utilizar apenas números e pontos (.) Ex: 78.5",
            ),
            Componentes().criaBotao(isDarkTheme, calculaImc, controllerForm),
            // resultado
            Center(
              child: Componentes().criaTexto(resposta, corResposta, 30),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: GestureDetector(
                      onTap: () {
                        launchUrlString("https://github.com/Denis-Mendes");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/imgs/github.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: GestureDetector(
                      onTap: () {
                        launchUrlString(
                            "https://www.linkedin.com/in/denis-mendes-047583224/");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/imgs/linkedin.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: GestureDetector(
                      onTap: () {
                        launchUrlString("https://twitter.com/idenismendes");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/imgs/twitter.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
