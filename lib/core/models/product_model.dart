import 'package:flutter/material.dart';

// Modelo de dados de uma Oferta/Produto.
// Em programação orientada a objetos, criamos classes para representar
// entidades do mundo real. Cada instância dessa classe = um produto.
class ProductModel {
  final String id;
  final String name;           // Nome do produto
  final String storeName;      // Nome do estabelecimento
  final String description;
  final double originalPrice;  // Preço original
  final double discountPrice;  // Preço com desconto
  final int quantity;          // Quantidade disponível
  final String pickupTime;     // Horário de retirada
  final IconData icon;         // Ícone representativo
  final Color color;           // Cor do card

  // 'const' no construtor permite criar objetos em tempo de compilação (mais eficiente)
  const ProductModel({
    required this.id,
    required this.name,
    required this.storeName,
    required this.description,
    required this.originalPrice,
    required this.discountPrice,
    required this.quantity,
    required this.pickupTime,
    required this.icon,
    required this.color,
  });

  // Calcula a porcentagem de desconto dinamicamente
  int get discountPercent =>
      (((originalPrice - discountPrice) / originalPrice) * 100).round();
}
