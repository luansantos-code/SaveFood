import 'package:flutter/material.dart';

import '../models/product_model.dart';

// Lista de dados mockados (falsos) para simular um feed real.
// Na Fase 4, esses dados virão do Firestore (banco de dados em nuvem).
// Usar 'const' aqui significa que essa lista nunca muda em tempo de execução,
// o que torna o app mais eficiente.
const List<ProductModel> mockOffers = [
  ProductModel(
    id: '1',
    name: 'Combo do Dia 🍱',
    storeName: 'Cantina Central',
    description: 'Arroz, feijão, frango grelhado e salada. Perfeito para o almoço!',
    originalPrice: 18.00,
    discountPrice: 9.00,
    quantity: 5,
    pickupTime: 'Retirar entre 13h e 14h',
    icon: Icons.lunch_dining,
    color: Color(0xFF2E7D32),
  ),
  ProductModel(
    id: '2',
    name: 'Salgados Variados (6 un.) 🥐',
    storeName: 'Lanchonete do RU',
    description: 'Mix de salgados assados do dia: coxinha, esfiha e pão de queijo.',
    originalPrice: 15.00,
    discountPrice: 8.00,
    quantity: 3,
    pickupTime: 'Retirar entre 17h e 18h30',
    icon: Icons.bakery_dining,
    color: Color(0xFFF57C00),
  ),
  ProductModel(
    id: '3',
    name: 'Marmita Vegetariana 🥗',
    storeName: 'Bio Café',
    description: 'Marmita saudável com legumes refogados, quinoa e grão-de-bico.',
    originalPrice: 22.00,
    discountPrice: 12.00,
    quantity: 2,
    pickupTime: 'Retirar entre 12h e 13h',
    icon: Icons.spa,
    color: Color(0xFF00796B),
  ),
  ProductModel(
    id: '4',
    name: 'Sanduíche Natural 🥪',
    storeName: 'Sul Temático',
    description: 'Pão integral com peito de peru, queijo, alface e tomate.',
    originalPrice: 12.00,
    discountPrice: 6.50,
    quantity: 8,
    pickupTime: 'Retirar entre 16h e 17h',
    icon: Icons.breakfast_dining,
    color: Color(0xFF1565C0),
  ),
  ProductModel(
    id: '5',
    name: 'Suco Natural 500ml 🍊',
    storeName: 'Bio Café',
    description: 'Suco de laranja espremido na hora. Sem conservantes ou açúcar.',
    originalPrice: 8.00,
    discountPrice: 4.00,
    quantity: 10,
    pickupTime: 'Retirar entre 10h e 11h',
    icon: Icons.local_drink,
    color: Color(0xFFE65100),
  ),
  ProductModel(
    id: '6',
    name: 'Kit Café da Manhã ☕',
    storeName: 'Cantina Central',
    description: 'Café com leite, pão com manteiga e uma fruta da estação.',
    originalPrice: 14.00,
    discountPrice: 7.00,
    quantity: 4,
    pickupTime: 'Retirar entre 8h e 9h',
    icon: Icons.coffee,
    color: Color(0xFF6D4C41),
  ),
];

// Ofertas do estabelecimento mockado (Cantina Central)
final List<ProductModel> mockEstablishmentOffers = mockOffers
    .where((p) => p.storeName == 'Cantina Central')
    .toList();
