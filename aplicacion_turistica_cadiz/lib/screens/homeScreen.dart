import 'package:flutter/material.dart';
import 'formScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Método para mostrar el formulario de informe de problemas
  void navegarForm(BuildContext context) {
    // Navega a la pantalla de formulario
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ReportProblemScreen())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // Expande los hijos de Stack para llenar todo el espacio disponible
        children: [
          // Imagen de fondo
          Image.asset(
            'assets/cadiz.jpg',
            fit: BoxFit.cover, // Ajusta la imagen para cubrir todo el espacio disponible sin distorsionar
          ),

          // Capa oscura para mejorar la legibilidad
          Container(
            color: Colors.black.withOpacity(0.5),
          ),

          // Contenido centrado
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Minimiza el tamaño de la columna para que solo ocupe el espacio necesario
              children: [
                const Text(
                  'CÁDIZ',
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'TOUR',
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 40),

                // Botón principal para continuar
                ElevatedButton(
                  onPressed: () {
                    // Navega a la pantalla del menú cuando se presiona el botón
                    Navigator.pushNamed(context, '/menu');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Continuar', style: TextStyle(fontSize: 18)),
                ),

                const SizedBox(height: 16),

                // Botón secundario para informar de problemas
                TextButton(
                  onPressed: () => navegarForm(context),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white.withOpacity(0.7),
                  ),
                  child: const Text('Informar de problemas', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
