import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/models/product_model.dart';
import '../../../../core/theme/app_theme.dart';

// Widget reutilizável que representa um card de oferta no feed.
// 'StatelessWidget' porque o card não muda por conta própria —
// seus dados vêm de fora via parâmetro 'product'.
class OfferCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onReserve; // Callback: ação ao apertar "Reservar"

  const OfferCard({
    super.key,
    required this.product,
    this.onReserve,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          // Cabeçalho colorido do card
          _buildCardHeader(),
          // Corpo com informações
          _buildCardBody(context),
        ],
      ),
    );
  }

  Widget _buildCardHeader() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            product.color,
            product.color.withOpacity(0.7),
          ],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Ícone do produto
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(product.icon, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 12),

          // Nome e loja
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  overflow: TextOverflow.ellipsis, // "..." se o texto for longo
                ),
                Text(
                  product.storeName,
                  style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // Badge de desconto (ex: "-50%")
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '-${product.discountPercent}%',
              style: GoogleFonts.poppins(
                color: product.color,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Descrição do produto
          Text(
            product.description,
            style: GoogleFonts.poppins(
              color: AppTheme.textGrey,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),

          // Linha de informações: horário e quantidade
          Row(
            children: [
              const Icon(Icons.access_time, size: 14, color: AppTheme.textGrey),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  product.pickupTime,
                  style: GoogleFonts.poppins(
                    color: AppTheme.textGrey,
                    fontSize: 12,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: product.quantity <= 3
                      ? Colors.red.withOpacity(0.1)
                      : Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${product.quantity} disponíveis',
                  style: GoogleFonts.poppins(
                    color:
                        product.quantity <= 3 ? Colors.red : AppTheme.primaryGreen,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Linha de preços + botão
          Row(
            children: [
              // Preço riscado (original)
              Text(
                'R\$ ${product.originalPrice.toStringAsFixed(2)}',
                style: GoogleFonts.poppins(
                  color: AppTheme.textGrey,
                  fontSize: 13,
                  decoration: TextDecoration.lineThrough, // tachado!
                ),
              ),
              const SizedBox(width: 8),
              // Preço com desconto em destaque
              Text(
                'R\$ ${product.discountPrice.toStringAsFixed(2)}',
                style: GoogleFonts.poppins(
                  color: AppTheme.primaryGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              // Spacer empurra o botão para a direita
              const Spacer(),

              ElevatedButton(
                onPressed: onReserve ??
                    () => _showReserveDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: product.color,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Reservar',
                  style:
                      GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Diálogo de confirmação de reserva
  void _showReserveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          '✅ Confirmar Reserva',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              product.storeName,
              style: GoogleFonts.poppins(color: AppTheme.textGrey, fontSize: 13),
            ),
            const SizedBox(height: 8),
            Text(
              product.pickupTime,
              style: GoogleFonts.poppins(fontSize: 13),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total a pagar:',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'R\$ ${product.discountPrice.toStringAsFixed(2)}',
                    style: GoogleFonts.poppins(
                      color: AppTheme.primaryGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '* O pagamento é realizado na retirada.',
              style: GoogleFonts.poppins(
                color: AppTheme.textGrey,
                fontSize: 11,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancelar',
              style: GoogleFonts.poppins(color: AppTheme.textGrey),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '🎉 Reserva confirmada! Retire em: ${product.pickupTime.replaceAll("Retirar ", "")}',
                  ),
                  backgroundColor: AppTheme.primaryGreen,
                  duration: const Duration(seconds: 3),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGreen,
            ),
            child: Text(
              'Confirmar',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
