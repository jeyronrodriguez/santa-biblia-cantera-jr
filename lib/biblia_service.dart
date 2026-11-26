import 'screens/lectura_screen.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class BibliaVersiculo {
  final int numero;
  final String texto;

  BibliaVersiculo({
    required this.numero,
    required this.texto,
  });
}

class BibliaLibro {
  final int numero;
  final String nombre;
  final Map<int, List<BibliaVersiculo>> capitulos;

  BibliaLibro({
    required this.numero,
    required this.nombre,
    required this.capitulos,
  });
}

class BibliaService {
  static const List<String> nombresLibros = [
    'Génesis', 'Éxodo', 'Levítico', 'Números',
    'Deuteronomio', 'Josué', 'Jueces', 'Rut',
    '1 Samuel', '2 Samuel', '1 Reyes', '2 Reyes',
    '1 Crónicas', '2 Crónicas', 'Esdras', 'Nehemías',
    'Ester', 'Job', 'Salmos', 'Proverbios',
    'Eclesiastés', 'Cantares', 'Isaías', 'Jeremías',
    'Lamentaciones', 'Ezequiel', 'Daniel', 'Oseas',
    'Joel', 'Amós', 'Abdías', 'Jonás',
    'Miqueas', 'Nahúm', 'Habacuc', 'Sofonías',
    'Hageo', 'Zacarías', 'Malaquías',
    'Mateo', 'Marcos', 'Lucas', 'Juan',
    'Hechos', 'Romanos', '1 Corintios', '2 Corintios',
    'Gálatas', 'Efesios', 'Filipenses', 'Colosenses',
    '1 Tesalonicenses', '2 Tesalonicenses',
    '1 Timoteo', '2 Timoteo', 'Tito', 'Filemón',
    'Hebreos', 'Santiago', '1 Pedro', '2 Pedro',
    '1 Juan', '2 Juan', '3 Juan', 'Judas',
    'Apocalipsis'
  ];

  static String limpiarHtml(String html) {
    String texto = html;

    texto = texto.replaceFirst(
      RegExp(r'<p[^>]*>\s*<sup[^>]*>\d+</sup>\s*&nbsp;?',
          caseSensitive: false),
      '',
    );

    texto = texto.replaceAll(
      RegExp(r'<[^>]*>'),
      '',
    );

    texto = texto
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'")
        .replaceAll('&apos;', "'")
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>');

    return texto.trim();
  }

  static Future<List<BibliaLibro>> cargarBiblia() async {
    final List<BibliaLibro> libros = [];

    for (int i = 0; i < nombresLibros.length; i++) {
      final numeroArchivo = (i + 1).toString().padLeft(2, '0');

      final ruta =
          'assets/biblia/Spanish-json/$numeroArchivo.content.json';

      final contenido = await rootBundle.loadString(ruta);
      final List<dynamic> datos = jsonDecode(contenido);

      final Map<int, List<BibliaVersiculo>> capitulos = {};

      for (final item in datos) {
        final String titulo = item['title'] ?? '';

        final coincidencia = RegExp(
          r'(\d+):(\d+)$',
        ).firstMatch(titulo);

        if (coincidencia == null) continue;

        final int capitulo = int.parse(coincidencia.group(1)!);
        final int numeroVersiculo = int.parse(coincidencia.group(2)!);

        final String html = item['content'] ?? '';
        final String texto = limpiarHtml(html);

        capitulos.putIfAbsent(capitulo, () => []);

        capitulos[capitulo]!.add(
          BibliaVersiculo(
            numero: numeroVersiculo,
            texto: texto,
          ),
        );
      }

      for (final lista in capitulos.values) {
        lista.sort((a, b) => a.numero.compareTo(b.numero));
      }

      libros.add(
        BibliaLibro(
          numero: i + 1,
          nombre: nombresLibros[i],
          capitulos: capitulos,
        ),
      );
    }

    return libros;
  }
}
