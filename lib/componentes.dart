import 'package:flutter/material.dart';

class Componentes {
  criaTexto(texto, cor, tamanho) {
    return Text(
      texto,
      style: TextStyle(
        color: cor,
        fontSize: tamanho,
      ),
    );
  }

  criaIconeGrande() {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Icon(
          Icons.directions_run_rounded,
          color: Colors.amberAccent,
          size: 200,
        ),
      ),
    );
  }

  criaInput(
      textoInput, controllerInput, msgErroVazio, msgErroFormatacaoErrada) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: TextFormField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: textoInput,
          ),
          validator: (value) {
            String valorS = value.toString();
            var valor = double.tryParse(valorS);
            if (value!.isEmpty) {
              return msgErroVazio;
            } else if (valor == null) {
              return msgErroFormatacaoErrada;
            }
          },
          controller: controllerInput,
        ),
      ),
    );
  }

  criaBotao(isDarkTheme, funcao, controlador) {
    return // botao
        Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Center(
        child: SizedBox(
          width: 1000,
          height: 60,
          child: ElevatedButton(
              onPressed: () {
                if (controlador.currentState!.validate()) {}
                funcao();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Colors.amber,
                ),
              ),
              child: isDarkTheme
                  ? criaTexto("Calcular", Colors.black, 30)
                  : criaTexto("Calcular", Colors.white, 30)),
        ),
      ),
    );
  }
}
