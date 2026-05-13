import 'package:flutter/material.dart';

void main() {
  runApp(const MultasApp());
}

class MultasApp extends StatelessWidget {
  const MultasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Control de Multas',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const Inicio(),
    );
  }
}

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  // Controladores
  final TextEditingController nombreController =
      TextEditingController();

  final TextEditingController motivoController =
      TextEditingController();

  final TextEditingController valorController =
      TextEditingController();

  // Lista de multas
  List<Map<String, dynamic>> multas = [];

  // Registrar multa
  void agregarMulta() {

    if (nombreController.text.isEmpty ||
        motivoController.text.isEmpty ||
        valorController.text.isEmpty) {
      return;
    }

    setState(() {
      multas.add({
        "nombre": nombreController.text,
        "motivo": motivoController.text,
        "valor": int.parse(valorController.text),
      });
    });

    // Limpiar campos
    nombreController.clear();
    motivoController.clear();
    valorController.clear();
  }

  // Calcular total
  int calcularTotal() {

    int total = 0;

    for (var multa in multas) {
      total += multa["valor"] as int;
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("💰 Control de Multas"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(15),

        child: Column(
          children: [

            // Nombre
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(
                labelText: "Nombre del estudiante",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            // Motivo
            TextField(
              controller: motivoController,
              decoration: const InputDecoration(
                labelText: "Motivo de la multa",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            // Valor
            TextField(
              controller: valorController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Valor",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // Botón
            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed: agregarMulta,

                child: const Text(
                  "REGISTRAR MULTA",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Total
            Text(
              "TOTAL: \$${calcularTotal()}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Lista de multas
            Expanded(
              child: ListView.builder(

                itemCount: multas.length,

                itemBuilder: (context, index) {

                  final multa = multas[index];

                  return Card(
                    child: ListTile(

                      leading: const Icon(
                        Icons.warning,
                        color: Colors.red,
                      ),

                      title: Text(multa["nombre"]),

                      subtitle: Text(multa["motivo"]),

                      trailing: Text(
                        "\$${multa["valor"]}",
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}