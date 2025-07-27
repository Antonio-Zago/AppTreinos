import 'package:flutter/material.dart';

class TesteScrollControllerScreen extends StatefulWidget {
  const TesteScrollControllerScreen({super.key});

  @override
  State<TesteScrollControllerScreen> createState() => _TesteScrollControllerScreenState();
}

class _TesteScrollControllerScreenState extends State<TesteScrollControllerScreen> {

  final ScrollController _scrollController = ScrollController();

  List<String> _itens = [];
  int _paginaAtual = 0;
  final int _tamanhoPagina = 20;
  bool _carregando = false;
  bool _temMais = true;

  @override
  void initState() {
    super.initState();
    _carregarMaisItens();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        _carregarMaisItens();
      }
      print("-------------------------scroll");
    });
  }

  void _carregarMaisItens() async {
    if (_carregando || !_temMais) return;

    setState(() => _carregando = true);

    // Simula delay de rede
    await Future.delayed(const Duration(seconds: 1));

    // Simula dados mockados
    List<String> novosItens = List.generate(_tamanhoPagina, (index) {
      int numero = _paginaAtual * _tamanhoPagina + index + 1;
      return "Item $numero";
    });

    setState(() {
      _itens.addAll(novosItens);
      _paginaAtual++;
      _carregando = false;

      // Para de carregar após 5 páginas simuladas
      if (_paginaAtual >= 5) {
        _temMais = false;
      }
    });
  }

   @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scroll Infinito Mock")),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _itens.length + 1, // +1 para o loader no final
        itemBuilder: (context, index) {
          if (index < _itens.length) {
            return ListTile(
              title: Text(_itens[index]),
            );
          } else {
            return _temMais
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: Text("Fim da lista")),
                  );
          }
        },
      ),
    );
  }
}