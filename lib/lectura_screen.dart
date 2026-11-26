import 'package:flutter/material.dart';
import 'biblia_service.dart';

class LecturaScreen extends StatefulWidget {
  const LecturaScreen({super.key});

  @override
  State<LecturaScreen> createState() => _LecturaScreenState();
}

class _LecturaScreenState extends State<LecturaScreen> {
  late Future<List<BibliaLibro>> futuroBiblia;

  List<BibliaLibro> libros = [];

  BibliaLibro? libroSeleccionado;
  int? capituloSeleccionado;

  @override
  void initState() {
    super.initState();
    futuroBiblia = BibliaService.cargarBiblia();
  }

  void seleccionarLibro(BibliaLibro libro) {
    setState(() {
      libroSeleccionado = libro;
      capituloSeleccionado =
          libro.capitulos.keys.isEmpty ? null : libro.capitulos.keys.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Santa Biblia Cantera Jeyron'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<BibliaLibro>>(
        future: futuroBiblia,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'No se pudo cargar la Biblia.\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No se encontraron libros bíblicos.'),
            );
          }

          libros = snapshot.data!;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: DropdownButtonFormField<int>(
                  value: libroSeleccionado?.numero,
                  decoration: const InputDecoration(
                    labelText: 'Seleccionar libro',
                    border: OutlineInputBorder(),
                  ),
                  items: libros.map((libro) {
                    return DropdownMenuItem<int>(
                      value: libro.numero,
                      child: Text(libro.nombre),
                    );
                  }).toList(),
                  onChanged: (numero) {
                    if (numero != null) {
                      seleccionarLibro(
                        libros.firstWhere(
                          (libro) => libro.numero == numero,
                        ),
                      );
                    }
                  },
                ),
              ),

              if (libroSeleccionado != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DropdownButtonFormField<int>(
                    value: capituloSeleccionado,
                    decoration: const InputDecoration(
                      labelText: 'Seleccionar capítulo',
                      border: OutlineInputBorder(),
                    ),
                    items: libroSeleccionado!.capitulos.keys.map((capitulo) {
                      return DropdownMenuItem<int>(
                        value: capitulo,
                        child: Text('Capítulo $capitulo'),
                      );
                    }).toList(),
                    onChanged: (capitulo) {
                      setState(() {
                        capituloSeleccionado = capitulo;
                      });
                    },
                  ),
                ),

              const SizedBox(height: 12),

              Expanded(
                child: libroSeleccionado == null
                    ? const Center(
                        child: Text('Selecciona un libro para comenzar.'),
                      )
                    : _mostrarVersiculos(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _mostrarVersiculos() {
    final versiculos =
        libroSeleccionado!.capitulos[capituloSeleccionado] ?? [];

    return ListView.builder(
      padding: const EdgeInsets.all(18),
      itemCount: versiculos.length,
      itemBuilder: (context, index) {
        final versiculo = versiculos[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 18,
                height: 1.7,
              ),
              children: [
                TextSpan(
                  text: '${versiculo.numero} ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF9A762F),
                  ),
                ),
                TextSpan(text: versiculo.texto),
              ],
            ),
          ),
        );
      },
    );
  }
}
