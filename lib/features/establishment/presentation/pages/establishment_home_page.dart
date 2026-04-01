import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/data/mock_data.dart';
import '../../../../core/models/product_model.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/pages/login_page.dart';

class EstablishmentHomePage extends StatefulWidget {
  const EstablishmentHomePage({super.key});

  @override
  State<EstablishmentHomePage> createState() => _EstablishmentHomePageState();
}

class _EstablishmentHomePageState extends State<EstablishmentHomePage> {
  // Lista mutável de ofertas do estabelecimento (começa com os dados mockados)
  // 'List.from' cria uma cópia da lista, sem modificar a original
  final List<ProductModel> _myOffers = List.from(mockEstablishmentOffers);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),

          // Painel de resumo (total de ofertas e disponíveis)
          SliverToBoxAdapter(child: _buildSummaryPanel()),

          // Título da lista
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Text(
                'Minhas Ofertas Publicadas',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
            ),
          ),

          // Lista de ofertas do estabelecimento
          _myOffers.isEmpty
              ? _buildEmptyState()
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                        _buildMyOfferCard(_myOffers[index], index),
                    childCount: _myOffers.length,
                  ),
                ),

          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),

      // Botão flutuante para adicionar nova oferta
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddOfferDialog(context),
        backgroundColor: AppTheme.accentOrange,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'Nova Oferta',
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: true,
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: AppTheme.accentOrange,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFE65100), Color(0xFFFF8F00)],
            ),
          ),
          padding: const EdgeInsets.fromLTRB(16, 50, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Cantina Central 🏪',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Gerencie suas ofertas do dia',
                style: GoogleFonts.poppins(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.white),
          tooltip: 'Sair',
          onPressed: () => _confirmLogout(context),
        ),
      ],
    );
  }

  Widget _buildSummaryPanel() {
    final totalQuantity = _myOffers.fold<int>(0, (sum, p) => sum + p.quantity);
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildSummaryItem(
            icon: Icons.list_alt,
            label: 'Ofertas Ativas',
            value: '${_myOffers.length}',
            color: AppTheme.accentOrange,
          ),
          Container(
            height: 40,
            width: 1,
            color: const Color(0xFFEEEEEE),
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),
          _buildSummaryItem(
            icon: Icons.inventory_2_outlined,
            label: 'Itens Disponíveis',
            value: '$totalQuantity',
            color: AppTheme.primaryGreen,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: AppTheme.textGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Card de oferta do estabelecimento (com opção de deletar)
  Widget _buildMyOfferCard(ProductModel product, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: product.color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(product.icon, color: product.color),
        ),
        title: Text(
          product.name,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, fontSize: 14),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'R\$ ${product.discountPrice.toStringAsFixed(2)} · ${product.quantity} disponíveis',
                style: GoogleFonts.poppins(
                    color: AppTheme.primaryGreen,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                product.pickupTime,
                style: GoogleFonts.poppins(
                    color: AppTheme.textGrey, fontSize: 11),
              ),
            ],
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          tooltip: 'Remover oferta',
          onPressed: () {
            setState(() => _myOffers.removeAt(index));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Oferta "${product.name}" removida.'),
                backgroundColor: Colors.redAccent,
              ),
            );
          },
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
            const Icon(Icons.storefront_outlined,
                size: 64, color: AppTheme.textGrey),
            const SizedBox(height: 12),
            Text(
              'Nenhuma oferta publicada',
              style: GoogleFonts.poppins(color: AppTheme.textGrey),
            ),
            const SizedBox(height: 4),
            Text(
              'Toque em "Nova Oferta" para começar!',
              style: GoogleFonts.poppins(
                  color: AppTheme.textGrey, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  // Dialog simples de Nova Oferta (mockado: só adiciona uma oferta fixa)
  void _showAddOfferDialog(BuildContext context) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          '📢 Nova Oferta',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nome do produto',
                prefixIcon: Icon(Icons.fastfood_outlined),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Preço com desconto (R\$)',
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancelar',
                style: GoogleFonts.poppins(color: AppTheme.textGrey)),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                final newProduct = ProductModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: nameController.text,
                  storeName: 'Cantina Central',
                  description: 'Produto publicado hoje.',
                  originalPrice:
                      double.tryParse(priceController.text) ?? 10.0,
                  discountPrice:
                      (double.tryParse(priceController.text) ?? 10.0) * 0.6,
                  quantity: 5,
                  pickupTime: 'Retirar entre 17h e 18h',
                  icon: Icons.fastfood,
                  color: AppTheme.accentOrange,
                );
                setState(() => _myOffers.add(newProduct));
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('✅ Oferta publicada com sucesso!'),
                    backgroundColor: AppTheme.primaryGreen,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentOrange),
            child: Text(
              'Publicar',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: Text(
              'Sair',
              style:
                  GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
