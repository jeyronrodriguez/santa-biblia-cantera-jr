import 'package:flutter/material.dart';

void main() => runApp(const SantaBibliaApp());

const forest = Color(0xFF173B30);
const gold = Color(0xFFC69A43);
const parchment = Color(0xFFF7F2E7);

class SantaBibliaApp extends StatelessWidget {
  const SantaBibliaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Santa Biblia Cantera JR',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: forest),
        scaffoldBackgroundColor: parchment,
        appBarTheme: const AppBarTheme(
          backgroundColor: forest,
          foregroundColor: Colors.white,
          centerTitle: false,
        ),
      ),
      home: const HomePage(),
    );
  }
}

const oldTestament = <String>[
  'Génesis','Éxodo','Levítico','Números','Deuteronomio','Josué','Jueces','Rut',
  '1 Samuel','2 Samuel','1 Reyes','2 Reyes','1 Crónicas','2 Crónicas','Esdras',
  'Nehemías','Tobías','Judit','Ester','1 Macabeos','2 Macabeos','Job','Salmos',
  'Proverbios','Eclesiastés','Cantar de los Cantares','Sabiduría','Eclesiástico',
  'Isaías','Jeremías','Lamentaciones','Baruc','Ezequiel','Daniel','Oseas','Joel',
  'Amós','Abdías','Jonás','Miqueas','Nahúm','Habacuc','Sofonías','Ageo',
  'Zacarías','Malaquías'
];

const newTestament = <String>[
  'Mateo','Marcos','Lucas','Juan','Hechos','Romanos','1 Corintios','2 Corintios',
  'Gálatas','Efesios','Filipenses','Colosenses','1 Tesalonicenses',
  '2 Tesalonicenses','1 Timoteo','2 Timoteo','Tito','Filemón','Hebreos',
  'Santiago','1 Pedro','2 Pedro','1 Juan','2 Juan','3 Juan','Judas','Apocalipsis'
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tab = 0;
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SANTA BIBLIA', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
            Text('CANTERA JR', style: TextStyle(fontSize: 12, color: Color(0xFFE6D4A6), letterSpacing: 2)),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Buscar',
            onPressed: () => setState(() => tab = 2),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: IndexedStack(
        index: tab,
        children: [
          _home(),
          _books(),
          _search(),
          _saved(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (value) => setState(() => tab = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Inicio'),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: 'Biblia'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Buscar'),
          NavigationDestination(icon: Icon(Icons.bookmark_border), selectedIcon: Icon(Icons.bookmark), label: 'Guardados'),
        ],
      ),
    );
  }

  Widget _home() => ListView(
    padding: const EdgeInsets.all(18),
    children: [
      Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: const LinearGradient(colors: [forest, Color(0xFF315747)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.menu_book_rounded, color: Color(0xFFE6D4A6), size: 42),
            SizedBox(height: 14),
            Text('La Palabra de Dios', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text('Lee, estudia y guarda tus escrituras favoritas.', style: TextStyle(color: Colors.white70)),
            SizedBox(height: 18),
            Text('GRATUITA  •  SIN ANUNCIOS', style: TextStyle(color: Color(0xFFE6D4A6), letterSpacing: 1.1, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
      const SizedBox(height: 22),
      const Text('Continúa leyendo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: forest)),
      const SizedBox(height: 10),
      Card(
        child: ListTile(
          leading: const Icon(Icons.menu_book, color: forest),
          title: const Text('Génesis 1'),
          subtitle: const Text('Comenzar desde el principio'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _openBook(context, 'Génesis'),
        ),
      ),
      const SizedBox(height: 18),
      const Text('Explorar la Biblia', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: forest)),
      const SizedBox(height: 10),
      Row(children: [
        Expanded(child: _testamentCard('Antiguo Testamento', '${oldTestament.length} libros', () => setState(() => tab = 1))),
        const SizedBox(width: 10),
        Expanded(child: _testamentCard('Nuevo Testamento', '${newTestament.length} libros', () => setState(() => tab = 1))),
      ]),
      const SizedBox(height: 18),
      const Card(child: Padding(
        padding: EdgeInsets.all(14),
        child: Text('Aviso: esta versión inicial contiene la estructura y navegación. El texto íntegro de Cantera-Iglesias se incorporará únicamente después de obtener la licencia correspondiente.', style: TextStyle(fontSize: 13)),
      )),
    ],
  );

  Widget _testamentCard(String title, String count, VoidCallback onTap) => Card(
    color: forest,
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Icon(Icons.menu_book, color: Color(0xFFE6D4A6), size: 28),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Text(count, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ]),
      ),
    ),
  );

  Widget _books() => DefaultTabController(
    length: 2,
    child: Column(children: [
      const Material(
        color: forest,
        child: TabBar(
          labelColor: Color(0xFFE6D4A6),
          unselectedLabelColor: Colors.white70,
          indicatorColor: Color(0xFFE6D4A6),
          tabs: [Tab(text: 'Antiguo Testamento'), Tab(text: 'Nuevo Testamento')],
        ),
      ),
      Expanded(child: TabBarView(children: [
        _bookList(oldTestament),
        _bookList(newTestament),
      ])),
    ]),
  );

  Widget _bookList(List<String> books) => ListView.separated(
    padding: const EdgeInsets.all(12),
    itemCount: books.length,
    separatorBuilder: (_, __) => const Divider(height: 1),
    itemBuilder: (context, index) => ListTile(
      leading: CircleAvatar(backgroundColor: const Color(0xFFE8DFC9), foregroundColor: forest, child: Text('${index + 1}')),
      title: Text(books[index], style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _openBook(context, books[index]),
    ),
  );

  Widget _search() => Padding(
    padding: const EdgeInsets.all(18),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Buscar escrituras', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: forest)),
      const SizedBox(height: 12),
      TextField(
        onChanged: (value) => setState(() => query = value),
        decoration: const InputDecoration(
          hintText: 'Ej. Juan 3:16 o una palabra',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 12),
      Text(query.isEmpty ? 'El buscador se conectará al texto autorizado de la Biblia.' : 'La búsqueda estará disponible cuando se incorpore el texto autorizado.'),
    ]),
  );

  Widget _saved() => const Center(
    child: Padding(
      padding: EdgeInsets.all(24),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.bookmark_border, size: 54, color: gold),
        SizedBox(height: 12),
        Text('Tus favoritos y notas', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: forest)),
        SizedBox(height: 6),
        Text('Aquí podrás guardar versículos y escribir reflexiones.'),
      ]),
    ),
  );

  void _openBook(BuildContext context, String book) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => ChapterPage(book: book)));
  }
}

class ChapterPage extends StatelessWidget {
  final String book;
  const ChapterPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final count = book == 'Génesis' ? 50 : book == 'Salmos' ? 150 : book == 'Mateo' ? 28 : 40;
    return Scaffold(
      appBar: AppBar(title: Text(book)),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Selecciona un capítulo', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: forest)),
          const SizedBox(height: 18),
          Expanded(child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, crossAxisSpacing: 9, mainAxisSpacing: 9),
            itemCount: count,
            itemBuilder: (context, index) => OutlinedButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ReadingPage(book: book, chapter: index + 1))),
              child: Text('${index + 1}'),
            ),
          )),
        ]),
      ),
    );
  }
}

class ReadingPage extends StatelessWidget {
  final String book;
  final int chapter;
  const ReadingPage({super.key, required this.book, required this.chapter});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('$book $chapter')),
    body: ListView(padding: const EdgeInsets.all(22), children: [
      Text(book, textAlign: TextAlign.center, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: forest)),
      Text('Capítulo $chapter', textAlign: TextAlign.center, style: const TextStyle(fontSize: 19, color: gold)),
      const SizedBox(height: 22),
      const Card(child: Padding(
        padding: EdgeInsets.all(18),
        child: Column(children: [
          Icon(Icons.lock_outline, color: gold, size: 34),
          SizedBox(height: 10),
          Text('Texto pendiente de licencia', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(height: 8),
          Text('El texto íntegro de la edición Cantera-Iglesias aparecerá aquí cuando se obtenga la autorización de publicación.'),
        ]),
      )),
    ]),
  );
}
