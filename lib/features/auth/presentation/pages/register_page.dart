import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../establishment/presentation/pages/establishment_home_page.dart';
import '../../../student/presentation/pages/student_home_page.dart';

// Enum: define os "tipos" de usuário possíveis no app.
// É como uma lista de opções segura — melhor que usar strings simples ("estudante", "estabelecimento").
enum UserRole { student, establishment }

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  // Variável que guarda qual perfil o usuário selecionou.
  // Começa como 'student' por padrão.
  UserRole _selectedRole = UserRole.student;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar simples com botão de voltar automático
      appBar: AppBar(
        title: const Text('Criar Conta'),
        // Garante que o botão de voltar (<) seja branco
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              Text(
                'Crie sua conta',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
              Text(
                'Preencha os dados abaixo para começar',
                style: GoogleFonts.poppins(
                  color: AppTheme.textGrey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 28),

              // --- Seletor de Perfil ---
              Text(
                'Eu sou um(a):',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 12),

              // Row com os dois cards de seleção lado a lado
              Row(
                children: [
                  // Card de Estudante
                  Expanded(
                    child: _buildRoleCard(
                      role: UserRole.student,
                      icon: Icons.school_outlined,
                      label: 'Estudante',
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Card de Estabelecimento
                  Expanded(
                    child: _buildRoleCard(
                      role: UserRole.establishment,
                      icon: Icons.storefront_outlined,
                      label: 'Estabelecimento',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Campo de Nome
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: _selectedRole == UserRole.student
                      ? 'Seu nome completo'
                      : 'Nome do estabelecimento',
                  prefixIcon: Icon(
                    _selectedRole == UserRole.student
                        ? Icons.person_outline
                        : Icons.storefront_outlined,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Campo obrigatório';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo de E-mail
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'seu@email.com',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Campo obrigatório';
                  if (!value.contains('@')) return 'Digite um e-mail válido';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo de Senha
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  hintText: 'Mínimo 6 caracteres',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Campo obrigatório';
                  if (value.length < 6) {
                    return 'A senha deve ter ao menos 6 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Botão de Criar Conta
              ElevatedButton(
                onPressed: _onRegisterPressed,
                child: const Text('Criar Conta'),
              ),
              const SizedBox(height: 16),

              // Link para voltar ao login
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Já tenho uma conta',
                    style: GoogleFonts.poppins(color: AppTheme.textGrey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget que cria os cards de seleção de perfil (Estudante/Estabelecimento)
  Widget _buildRoleCard({
    required UserRole role,
    required IconData icon,
    required String label,
  }) {
    final bool isSelected = _selectedRole == role;

    return GestureDetector(
      // GestureDetector detecta toques do usuário em qualquer widget filho
      onTap: () => setState(() => _selectedRole = role),
      child: AnimatedContainer(
        // AnimatedContainer: como um Container normal, mas anima automaticamente
        // as mudanças de propriedades (borda, cor, etc).
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryGreen.withOpacity(0.1)
              : Colors.white,
          border: Border.all(
            color: isSelected ? AppTheme.primaryGreen : const Color(0xFFDCE8DC),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 36,
              color: isSelected ? AppTheme.primaryGreen : AppTheme.textGrey,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontWeight:
                    isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? AppTheme.primaryGreen : AppTheme.textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onRegisterPressed() {
    if (_formKey.currentState!.validate()) {
      // Navega para a Home correta de acordo com o perfil selecionado.
      // Navigator.pushReplacement: substitui a tela atual (não empilha),
      // então o usuário não pode voltar para o cadastro com o botão (<).
      if (_selectedRole == UserRole.student) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const StudentHomePage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const EstablishmentHomePage(),
          ),
        );
      }
    }
  }
}
