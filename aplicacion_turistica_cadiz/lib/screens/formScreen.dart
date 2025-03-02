import 'package:flutter/material.dart';

// Pantalla de formulario
class ReportProblemScreen extends StatefulWidget {
  const ReportProblemScreen({Key? key}) : super(key: key);

  @override
  _formScreenState createState() => _formScreenState();
}

// Maneja la lógica del formulario, validaciones y envío de datos.
class _formScreenState extends State<ReportProblemScreen> {
  // Clave global para el formulario que permite validaciones
  final key = GlobalKey<FormState>();

  final TextEditingController controladorEmail = TextEditingController();
  final TextEditingController controladorDescripcion = TextEditingController();

  DateTime fechaSeleccionada = DateTime.now();

  bool aceptarTerminos = false;

  // Funcion para sleccionar la fecha
  Future<void> seleccionarFecha(BuildContext contexto) async {
    final DateTime? fechaElegida = await showDatePicker(
      context: contexto,
      initialDate: fechaSeleccionada,
      firstDate: DateTime(2020),      // Fecha más antigua permitida
      lastDate: DateTime.now(),       // No permite seleccionar fechas futuras
    );

    // Actualiza el estado si el usuario seleccionó una fecha nueva
    if (fechaElegida != null && fechaElegida != fechaSeleccionada) {
      setState(() {
        fechaSeleccionada = fechaElegida;
      });
    }
  }

  // Método para mostrar dialog de confirmación cuando el informe es enviado exitosamente.
  void mostrarDialogExito() {
    showDialog(
      context: context,
      builder: (BuildContext contexto) {
        return AlertDialog(
          title: const Text('Problema reportado'),
          content: const Text('Tu informe ha sido enviado correctamente. Nos pondremos en contacto contigo pronto.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(contexto).pop();
                Navigator.of(contexto).pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext contexto) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informar de un problema'),
      ),
      // El scroll es necesario para que no de problema en pantallas pequeñas
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: key,  // Necesario para validaciones
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Icono de error:
              Center(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.report_problem,
                    size: 50,
                    color: Colors.blue,
                  ),
                ),
              ),

              // Campo de Gmail
              TextFormField(
                controller: controladorEmail,
                decoration: const InputDecoration(
                  labelText: 'Gmail',
                  hintText: 'ejemplo@gmail.com',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  // Validación: campo obligatorio
                  if (valor == null || valor.isEmpty) {
                    return 'Por favor, introduce tu Gmail';
                  }
                  // Validación: debe ser una dirección de Gmail
                  if (!valor.contains('@gmail.com')) {
                    return 'Por favor, introduce una dirección de Gmail válida';
                  }
                  return null;  //Si no hay error
                },
              ),

              // Para añadir espacio vertical
              const SizedBox(height: 16),

              // Campo de fecha
              InkWell(
                onTap: () => seleccionarFecha(contexto),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Fecha del problema',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  // Muestra la fecha seleccionada en formato día/mes/año
                  child: Text(
                    '${fechaSeleccionada.day}/${fechaSeleccionada.month}/${fechaSeleccionada.year}',
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Campo de descripción
              TextFormField(
                controller: controladorDescripcion,
                decoration: const InputDecoration(
                  labelText: 'Descripción del problema',
                  hintText: 'Describe detalladamente el problema que has experimentado',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (valor) {
                  // Validación: campo obligatorio
                  if (valor == null || valor.isEmpty) {
                    return 'Por favor, describe el problema';
                  }
                  // Validación: longitud mínima
                  if (valor.length < 10) {
                    return 'La descripción debe tener al menos 10 caracteres';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Sección de términos y condiciones
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Autorizo el tratamiento de mis datos',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Sus datos serán tratados conforme a la política de privacidad',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),

                    // Switch para aceptar o rechazar
                    Switch(
                      value: aceptarTerminos,
                      onChanged: (bool valor) {
                        setState(() {
                          aceptarTerminos = valor;
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                  ],
                ),
              ),

              // Espaciador vertical
              const SizedBox(height: 24),

              ElevatedButton(
                // El botón solo está habilitado si se aceptan los términos
                onPressed: aceptarTerminos ? () {
                  if (key.currentState!.validate()) {
                    mostrarDialogExito();
                  }
                } : null, // Desactivar el botón si no se acepta
                // Estilo visual del botón
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey
                ),
                child: const Text('Enviar informe', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Liberar recursos de los controladores cuando el widget se destruye
    // Esto evita fugas de memoria
    controladorEmail.dispose();
    controladorDescripcion.dispose();
    // Llama al método dispose de la clase padre
    super.dispose();
  }
}