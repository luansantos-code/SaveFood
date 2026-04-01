import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/data/mock_data.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../widgets/offer_card.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  // Texto que o usuário digitou na busca
  String _searchQuery = '';

  // Usa um getter para filtrar as ofertas dinamicamente conforme a busca
  List get _filteredOffers => mockOffers.where((p) {
        final query = _searchQuery.toLowerCase();
        return p.name.toLowerCase().contains(query) ||
            p.storeName.toLowerCase().contains(query);
      }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        // CustomScrollView + Slivers permite criar efeitos de scroll mais elaborados
        slivers: [
          // SliverAppBar: AppBar que some/encolhe ao rolar a tela
          _buildSliverAppBar(context),

          // Barra de busca fixada no topo da lista
          SliverToBoxAdapter(child: _buildSearchBar()),

          // Título da seção
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ofertas de hoje',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                  ),
                  Text(
                    '${_filteredOffers.length} disponíveis',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppTheme.textGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Lista de ofertas filtradas
          _filteredOffers.isEmpty
              ? _buildEmptyState()
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    // Builder: cria cada item da lista sob demanda (mais eficiente que Column)
                    (context, index) =>
                        OfferCard(product: _filteredOffers[index]),
                    childCount: _filteredOffers.length,
                  ),
                ),

          // Espaço no fim para não ficar colado na barra de navegação
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: true,
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: AppTheme.primaryGreen,

      // Área que expande ao rolar para cima
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
          padding: const EdgeInsets.fromLTRB(16, 50, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Olá, Estudante! 👋',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Veja as ofertas de hoje e economize!',
                style: GoogleFonts.poppins(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),

      // Botão de logout no canto direito da AppBar
      actions: [
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.white),
          tooltip: 'Sair',
          onPressed: () => _confirmLogout(context),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: TextField(
        onChanged: (value) => setState(() => _searchQuery = value),
        decoration: InputDecoration(
          hintText: 'Buscar por produto ou cantina...',
          hintStyle: GoogleFonts.poppins(color: AppTheme.textGrey, fontSize: 14),
          prefixIcon: const Icon(Icons.search, color: AppTheme.textGrey),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: AppTheme.textGrey),
                  onPressed: () => setState(() => _searchQuery = ''),
                )
              : null,
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildEmptyState() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 64),
        child: Column(
          children: [
            const Icon(Icons.search_off, size: 64, color: AppTheme.textGrey),
            const SizedBox(height: 12),
            Text(
              'Nenhuma oferta encontrada',
              style: GoogleFonts.poppins(color: AppTheme.textGrey),
            ),
          ],
        ),
      ),
    );
  }

  // Diálogo de confirmação ao clicar em "Sair"
  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Sair da conta?',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Você será redirecionado para a tela de login.',
          style: GoogleFonts.poppins(color: AppTheme.textGrey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancelar',
                style: GoogleFonts.poppins(color: AppTheme.textGrey)),
          ),
          ElevatedButton(
            onPressed: () {
              // pushAndRemoveUntil: vai para o Login E remove TODAS as telas
              // anteriores da pilha de navegação. O usuário não pode apertar
              // "voltar" para chegar na home sem logar novamente.
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false, // remove todas as rotas anteriores
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
            ),
            child: Text(
              'Sair',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
