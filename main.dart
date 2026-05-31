import 'package:flutter/material.dart';

void main() {
  runApp(const GoldCupInvestApp());
}

class GoldCupInvestApp extends StatelessWidget {
  const GoldCupInvestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GoldCup Invest',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFD700), // Dourado Ouro
          primary: const Color(0xFFFFD700), 
          secondary: const Color(0xFF00E676), // Verde Gramado Brilhante
          background: const Color(0xFF121212), // Grafite Escuro Premium
          surface: const Color(0xFF1E1E1E),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

// ==========================================
// 1. TELA DE LOGIN COM IMAGEM DE FUNDO
// ==========================================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();

  void _realizarLogin() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1508098682722-e99c43a406b2?q=80&w=1000&auto=format&fit=crop'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                color: Colors.black.withOpacity(0.75),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: Color(0xFFFFD700), width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Icon(Icons.emoji_events, size: 70, color: Color(0xFFFFD700)),
                        const SizedBox(height: 8),
                        const Text(
                          'GOLDCUP INVEST 🏆',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                        ),
                        const Text(
                          'A Elite dos Investimentos Esportivos',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 24),
                        
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: 'Telefone',
                            prefixIcon: Icon(Icons.phone, color: Color(0xFFFFD700)),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) => value!.isEmpty ? 'Insira seu telefone' : null,
                        ),
                        const SizedBox(height: 16),
                        
                        TextFormField(
                          controller: _cpfController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'CPF',
                            prefixIcon: Icon(Icons.badge, color: Color(0xFFFFD700)),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) => value!.isEmpty ? 'Insira seu CPF' : null,
                        ),
                        const SizedBox(height: 16),
                        
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Senha',
                            prefixIcon: Icon(Icons.lock, color: Color(0xFFFFD700)),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) => value!.isEmpty ? 'Insira sua senha' : null,
                        ),
                        const SizedBox(height: 24),
                        
                        ElevatedButton(
                          onPressed: _realizarLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFD700),
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('ENTRAR NO CAMPO', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 2. PAINEL FINANCEIRO DE INVESTIMENTOS
// ==========================================
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  double _saldoDisponivel = 0.0;
  final List<Map<String, dynamic>> _investimentos = [];
  
  final TextEditingController _valorInvestimentoController = TextEditingController();
  final TextEditingController _valorFinancasController = TextEditingController();
  
  String _selecaoEscolhida = 'Brasil 🇧🇷';
  final List<String> _selecoes = ['Brasil 🇧🇷', 'França 🇫🇷', 'Argentina 🇦🇷', 'Alemanha 🇩🇪'];

  void _depositar() {
    double? valor = double.tryParse(_valorFinancasController.text);
    if (valor == null || valor <= 0) return;
    setState(() => _saldoDisponivel += valor);
    _valorFinancasController.clear();
    Navigator.pop(context);
  }

  void _sacar() {
    double? valor = double.tryParse(_valorFinancasController.text);
    if (valor == null || valor <= 0 || valor > _saldoDisponivel) return;

    double taxa = valor * 0.15;
    double valorRecebido = valor - taxa;

    setState(() => _saldoDisponivel -= valor);
    _valorFinancasController.clear();
    Navigator.pop(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Saque Processado ⚽'),
        content: Text(
          'Valor Solicitado: R\$ ${valor.toStringAsFixed(2)}\n'
          'Taxa de Arbitragem (15%): R\$ ${taxa.toStringAsFixed(2)}\n\n'
          'Líquido Enviado: R\$ ${valorRecebido.toStringAsFixed(2)}',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
        ],
      ),
    );
  }

  void _criarInvestimento() {
    final double? valor = double.tryParse(_valorInvestimentoController.text);
    if (valor == null || valor < 100 || valor > 60000 || valor > _saldoDisponivel) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Valor inválido ou saldo insuficiente (Mín: R\$100 | Máx: R\$60k)')),
      );
      return;
    }

    setState(() {
      _saldoDisponivel -= valor;
      _investimentos.add({
        'selecao': _selecaoEscolhida,
        'valor': valor,
        'status': 'Rendendo',
        'createdAt': DateTime.now(),
      });
    });
    _valorInvestimentoController.clear();
  }

  void _resgatarInvestimento(int index) {
    double valorRetorno = _investimentos[index]['valor'] * 1.30; 
    setState(() {
      _saldoDisponivel += valorRetorno;
      _investimentos[index]['status'] = 'Finalizado';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🏆 GoldCup Portfólio', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1E1E1E),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.redAccent),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage())),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1544698310-74ea9d1c8258?q=80&w=1000&auto=format&fit=crop'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: Colors.black.withOpacity(0.4),
                alignment: Alignment.center,
                child: const Text(
                  'FAÇA SEU TIME JOGAR POR VOCÊ',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 2),
                ),
              ),
            ),

            Card(
              margin: const EdgeInsets.all(16),
              color: const Color(0xFF1E1E1E),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text('BANCA ATUAL', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    Text(
                      'R\$ ${_saldoDisponivel.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF00E676)),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _abrirModalFinancas(true),
                            icon: const Icon(Icons.account_balance_wallet),
                            label: const Text('Depositar'),
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF121212)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _abrirModalFinancas(false),
                            icon: const Icon(Icons.monetization_on),
                            label: const Text('Sacar (15%)'),
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF121212)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              color: const Color(0xFF1E1E1E),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selecaoEscolhida,
                            decoration: const InputDecoration(labelText: 'Seleção'),
                            items: _selecoes.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                            onChanged: (v) => setState(() => _selecaoEscolhida = v!),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _valorInvestimentoController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Valor Aporte',
                              hintText: '100 a 60k',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _criarInvestimento,
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFD700), foregroundColor: Colors.black),
                      child: const Text('Confirmar Investimento Esportivo', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(alignment: Alignment.centerLeft, child: Text('⚽ Boletas em Maturação (15 dias):', style: TextStyle(fontWeight: FontWeight.bold))),
            ),

            _investimentos.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text('Nenhum contrato ativo no momento.', style: TextStyle(color: Colors.grey)),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _investimentos.length,
                    itemBuilder: (context, index) {
                      final inv = _investimentos[index];
                      final DateTime dataCriacao = inv['createdAt'];
                      final bool jaFinalizado = inv['status'] == 'Finalizado';

                      final int diasPassados = DateTime.now().difference(dataCriacao).inDays;
                      final int diasRestantes = 15 - diasPassados;
                      final bool liberado = diasRestantes <= 0;

                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        color: const Color(0xFF262626),
                        child: ListTile(
                          title: Text('${inv['selecao']} • R\$ ${inv['valor'].toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: jaFinalizado
                              ? const Text('Contrato Liquidado', style: TextStyle(color: Colors.grey))
                              : Text(
                                  liberado ? '✅ Rendimento Pronto!' : '🔒 Bloqueado por $diasRestantes dias',
                                  style: TextStyle(color: liberado ? const Color(0xFF00E676) : Colors.orange),
                                ),
                          trailing: jaFinalizado
                              ? const Icon(Icons.stars, color: Color(0xFFFFD700))
                              : ElevatedButton(
                                  onPressed: liberado ? () => _resgatarInvestimento(index) : null,
                                  child: const Text('Resgatar'),
                                ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  void _abrirModalFinancas(bool ehDeposito) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E1E1E),
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(ehDeposito ? 'Depositar Fundos 💳' : 'Sacar Saldo (Taxa 15%) 💸', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              controller: _valorFinancasController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Valor (R$)', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: ehDeposito ? _depositar : _sacar,
              style: ElevatedButton.styleFrom(backgroundColor: ehDeposito ? const Color(0xFF00E676) : Colors.redAccent, foregroundColor: Colors.black),
              child: const Text('Confirmar Operação', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
