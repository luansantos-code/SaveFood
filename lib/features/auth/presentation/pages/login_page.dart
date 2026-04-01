import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../establishment/presentation/pages/establishment_home_page.dart';
import '../../../student/presentation/pages/student_home_page.dart';
import 'register_page.dart';

// --- Usuários Mockados para Teste ---
// Na Fase 4 isso será substituído pelo Firebase Authentication.
const _mockUsers = [
  {'email': 'estudante@teste.com', 'password': '123456', 'role': 'student'},
  {'email': 'cantina@teste.com',   'password': '123456', 'role': 'establishment'},
];

// StatefulWidget é usado aqui porque a tela tem estado mutável:
// no caso, se a senha está visível ou não (_obscurePassword).
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controladores: são o "link" entre o código e o que o usuário digita no campo.
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Variável de estado: controla se a senha aparece como "****" ou texto
  bool _obscurePassword = true;

  // Chave de formulário: usada para validar todos os campos de uma vez
  final _formKey = GlobalKey<FormState>();

  @override
  // Sempre que usarmos controllers, devemos liberá-los da memória ao sair da tela.
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SingleChildScrollView evita overflow (quando o teclado sobe e empurra o conteúdo)
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cabeçalho com gradiente verde
            _buildHeader(),

            // Formulário de Login
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Acesse sua conta',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Bem-vindo de volta!',
                      style: GoogleFonts.poppins(
                        color: AppTheme.textGrey,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Campo de E-mail
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                        hintText: 'seu@email.com',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      // validator: função que retorna uma mensagem de erro (String)
                      // ou null se estiver válido.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira seu e-mail';
                        }
                        if (!value.contains('@')) {
                          return 'Digite um e-mail válido';
                        }
                        return null; // null = sem erros
                      },
                    ),
                    const SizedBox(height: 16),

                    // Campo de Senha
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword, // mostra/oculta a senha
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        hintText: '••••••••',
                        prefixIcon: const Icon(Icons.lock_outline),
                        // Botão de olhinho para mostrar/ocultar a senha
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                          // setState() avisa o Flutter que algo mudou e ele
                          // precisa redesenhar a tela.
                          onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira sua senha';
                        }
                        if (value.length < 6) {
                          return 'A senha deve ter ao menos 6 caracteres';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),

                    // Botão de Entrar
                    ElevatedButton(
                      onPressed: _onLoginPressed,
                      child: const Text('Entrar'),
                    ),
                    const SizedBox(height: 16),

                    // Link para criar conta
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Não tem uma conta? ',
                          style: GoogleFonts.poppins(color: AppTheme.textGrey),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigator.push: navega para outra tela empilhando
                            // ela em cima da atual (você pode voltar com o botão <)
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Criar conta',
                            style: GoogleFonts.poppins(
                              color: AppTheme.primaryGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Separamos o cabeçalho em um método privado para deixar o build() mais limpo.
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      // height maior em telas maiores via MediaQuery (responsividade!)
      height: 240,
      decoration: const BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30), // espaço para a status bar do celular
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.eco_rounded, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Text(
            'Save Food',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            'Combata o desperdício alimentar',
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.white.withOpacity(0.85),
            ),
          ),
        ],
      ),
    );
  }

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      // Procura nas credenciais mockadas se existe um usuário com esses dados
      final user = _mockUsers.firstWhere(
        (u) => u['email'] == email && u['password'] == password,
        orElse: () => {}, // retorna mapa vazio se não encontrar
      );

      if (user.isEmpty) {
        // Credenciais erradas: mostra um erro
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('❌ E-mail ou senha incorretos'),
            backgroundColor: Colors.redAccent,
          ),
        );
        return;
      }

      // Navega para a Home correta conforme o tipo de usuário
      // pushReplacement: não permite voltar pro Login com o botão (<)
      if (user['role'] == 'student') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const StudentHomePage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const EstablishmentHomePage()),
        );
      }
    }
  }
}
