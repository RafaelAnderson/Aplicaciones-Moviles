import 'package:flutter/material.dart';

// Compra con tarjeta
// Pantalla donde muestra el total del pedido(costo) y poder ingresar los datos de la tarjeta(checkbox para elegir guardar o no la tarjeta) o elegir una tarjeta guardada

class PaymentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Compra con Tarjeta"),
      ),
      body: _myView(context),
    );
  }
}

// Reemplaza con tu codigo
Widget _myView(BuildContext context) {
  return ListView();
}