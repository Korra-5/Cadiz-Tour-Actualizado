import 'package:flutter/material.dart';

class menuScreen extends StatefulWidget {
  @override
  menuScreenActual createState() => menuScreenActual();
}

// Controla la bottom bar, y muestra la pantalla correspondiente
class menuScreenActual extends State<menuScreen> {
  // Inicializado a 0, es decir en esta pestaña (Donde esta la lista de monumentos)
  int pantallaActual = 0;
  int? pantallaElegida;

  // Declaramos el mapa de los diferentes items que vamos a utilizar (Monumentos)
  final List<Map<String, String>> items = [
    {
      'image': 'assets/torreTavira.jpg',
      'title': 'Torre Tavira',
      'description': 'La Torre Tavira, situada en la casa palacio de los Marqueses de Recaño, se erige como la torre más alta de Cádiz, alcanzando los 45 metros sobre el nivel del mar. Este emblemático mirador ofrece una de las experiencias más cautivadoras de la ciudad. Desde su punto de vista privilegiado, "se ve toda la ciudad", permitiendo disfrutar de unas vistas maravillosas que constituyen un atractivo irrenunciable para cualquier visitante.',
    },
    {
      'image': 'assets/monumentoConst.jpg',
      'title': 'Monumento a la Constitución de 1812',
      'description': 'El Monumento a la Constitución de 1812, conocido popularmente como "La Pepa", es un emblema de la ciudad de Cádiz y se sitúa en una hermosa plaza del casco histórico. Este monumento, diseñado por los arquitectos Modesto Gómez Otero y Aniceto Marinas, tiene una estructura en forma de hemiciclo que rinde homenaje a la proclamación de la Constitución de 1812, un acto que marcó un hito importante en la historia de España.',
    },
    {
      'image': 'assets/puertaTierra.webp',
      'title': 'Puerta de tierra',
      'description': 'La Puerta de Tierra es el emblemático acceso al casco histórico de Cádiz, un lugar que encapsula la rica historia y cultura de esta maravillosa ciudad. Según sala2500, "para entrar en el casco histórico de Cádiz hay que cruzar esta puerta, emblemática para la ciudad", lo que sugiere que su simple contemplación invita a los visitantes a descubrir un mundo de tradiciones y comercio. Esta puerta no solo es un punto de entrada, sino también un símbolo que representa la esencia de la antigua Cádiz.',
    },
    {
      'image': 'assets/arcoPopulo.jpg',
      'title': 'Arco del Pópulo',
      'description': 'El Arco del Pópulo se presenta como una de las puertas amuralladas más emblemáticas de Cádiz, un legado del pasado que sigue cautivando a quienes lo visitan. Construido en el siglo XIII, ha conservado su aspecto original, y es descrito como "uno de los rincones con mayor encanto de la población", especialmente durante festividades como el Corpus Christi, donde se instala un altar en su honor.',
    },
    {
      'image': 'assets/murallaSanCarlo.jpg',
      'title': 'Murallas de San Carlos',
      'description': 'Las Murallas de San Carlos, un emblemático baluarte situado junto a la Plaza España en el casco antiguo de Cádiz, son una joya histórica que atrae a visitantes por su belleza y significado. Construidas en 1784 por el ingeniero militar Antonio Hurtado, estas murallas albergaban 90 piezas de artillería y contaban con 55 bóvedas, algunas de las cuales se utilizaban para almacenar nieve proveniente de la sierra de Cádiz. JMMCai menciona que se puede "pasear tanto por encima de las murallas como por abajo", ofreciendo un recorrido lleno de historia y vistas impresionantes.',
    },
    {
      'image': 'assets/teatroRomano.jpg',
      'title': 'Teatro Romano',
      'description': 'El Teatro Romano de Cádiz es un impresionante vestigio de la antigüedad que maravilla a quienes lo visitan. Descubierto casi por casualidad en el año 1980, su conservación es notable, siendo uno de los más grandes teatros de la época romana. Como menciona un viajero, "es casi un milagro que en una ciudad tan pequeña como Cádiz haya sobrevivido a los sucesivos movimientos de tierra para las posteriores edificaciones". Al estar situado en una hondonada, su estructura, aunque no siempre vista en su totalidad, presenta un panorama fascinante.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      appBar: AppBar(
        // Título de la pantlla
        title: Text('Menú de Monumentos'),
      ),
      // Verifica el índice actual para decidir qué contenido mostrar
      body: pantallaActual == 0
          ? (pantallaElegida == null
      // Mostrar la cuadrícula de monumentos si no hay ningún monumento seleccionado
          ? GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Número de columnas en la cuadrícula
          crossAxisSpacing: 10.0, // Espaciado entre columnas
          mainAxisSpacing: 10.0, // Espaciado entre filas
          childAspectRatio: 0.7, // Controla que tengan el mismo tamaño los elementos (Hace una porporcion entre altura y ancho)
        ),
        padding: const EdgeInsets.all(10), //Añade un padding de 10 pixeles a todos lados
        itemCount: items.length,
        itemBuilder: (context, state) {
          final item = items[state];

          //Devuelve una carta con la informacion de los monumentos
          return Card(
            // Controla la apariencia visual y la estructura de la tarjeta
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Expanded: Permite que el widget hijo ocupe todo el espacio disponible
                Expanded(
                  child: Image.asset(
                    item['image']!,
                    fit: BoxFit.cover, // Ajusta la imagen para que cubra todo el espacio
                    height: 100,
                  ),
                ),
                Padding(
                  // Añade espacio alrededor del contenido interno de la tarjeta
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Alinea los hijos al inicio horizontalmente
                    children: [
                      Text(
                        item['title']!,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            pantallaElegida = state; // Actualizar el estado seleccionado
                          });
                        },
                        child: Text('Ver más'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      )
      // Mostrar el detalle del monumento seleccionado
          : Center(
        // Centra los widgets hijos dentro del widget Center
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Alinea los hijos en el centro verticalmente
          children: [
            Image.asset(
              items[pantallaElegida!]['image']!,
              fit: BoxFit.cover,
              height: 200, // Altura de la imagen en detalle
            ),
            Text(
              items[pantallaElegida!]['title']!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                items[pantallaElegida!]['description']!,
                textAlign: TextAlign.center, // Centra el texto dentro del widget Text
              ),
            ),
            ElevatedButton(
              // Botón elevado para volver a la lista de monumentos
              onPressed: () {
                setState(() {
                  pantallaElegida = null; // Reiniciar el índice seleccionado
                });
              },
              child: const Text('Volver'),
            ),
          ],
        ),
      ))
      // Mostrar la pantalla de resumen cuando se selecciona esa pestaña
          : const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Sobre Cádiz:',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Cádiz es una ciudad y municipio de España, capital de la provincia homónima, '
                  'en la comunidad autónoma de Andalucía. Es una ciudad con una rica historia, '
                  'conocida por sus carnavales, playas y monumentos históricos. Cádiz se destaca '
                  'por su encantador casco antiguo, con calles estrechas y plazas llenas de vida. '
                  'La ciudad también alberga el Gran Teatro Falla, uno de los principales escenarios '
                  'para el famoso Carnaval de Cádiz, que atrae a miles de visitantes cada año. Además, '
                  'la Catedral de Cádiz, con su cúpula dorada, es un punto de referencia icónico en el '
                  'horizonte de la ciudad. Con su combinación de historia, cultura y belleza costera, '
                  'Cádiz es un destino imperdible para cualquier viajero.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        //Muestra la pantalla actual
        currentIndex: pantallaActual,
        onTap: (state) {
          //Cuando tocas un icono cambias el estado de la pantalla
          setState(() {
            pantallaActual = state;
            pantallaElegida = null; // Esto se hace para reiniciar el índice seleccionado y que este no entre en bucle
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_on),
            label: 'Menú',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Resumen',
          ),
        ],
      ),
    );
  }
}
