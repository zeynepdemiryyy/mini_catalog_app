import 'package:flutter/material.dart';

import '../models/product.dart';
import '../theme/app_theme.dart';

class DiscoverScreen extends StatefulWidget {
  final List<CartItem> cart;
  final Function(Product) onAddToCart;
  final VoidCallback onOpenCart;
  final Function(Product) onSelectProduct;

  const DiscoverScreen({
    super.key,
    required this.cart,
    required this.onAddToCart,
    required this.onOpenCart,
    required this.onSelectProduct,
  });

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'All';

  // Örnek Katalog Verisi (Mock Data)
  final List<Product> _products = [
    Product(
      id: '1',
      title: 'Wireless Headphones',
      description: 'High-quality noise-canceling wireless headphones with up to 30 hours of battery life.',
      price: 199.99,
      imageUrl:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500',
      category: 'Electronics',
      rating: 4.8,
    ),
    Product(
      id: '2',
      title: 'Smart Watch',
      description: 'Track your fitness, heart rate, and notifications with this sleek smartwatch.',
      price: 149.50,
      imageUrl:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500',
      category: 'Electronics',
      rating: 4.5,
    ),
    Product(
      id: '3',
      title: 'Minimalist Backpack',
      description: 'Durable water-resistant backpack ideal for work, travel, and daily commute.',
      price: 79.00,
      imageUrl:
          'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500',
      category: 'Accessories',
      rating: 4.7,
    ),
    Product(
      id: '4',
      title: 'Running Shoes',
      description: 'Lightweight and breathable running shoes designed for ultimate comfort.',
      price: 119.99,
      imageUrl:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500',
      category: 'Footwear',
      rating: 4.9,
    ),
  ];

  List<String> get _categories {
    final categories = _products.map((p) => p.category).toSet().toList();
    return ['All', ...categories];
  }

  List<Product> get _filteredProducts {
    return _products.where((product) {
      final matchesSearch = product.title.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      final matchesCategory =
          _selectedCategory == 'All' || product.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final totalCartCount = widget.cart.fold(
      0,
      (sum, item) => sum + item.quantity,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Discover',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined),
                onPressed: widget.onOpenCart,
              ),
              if (totalCartCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 9,
                    backgroundColor: Colors.red,
                    child: Text(
                      '$totalCartCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Arama Çubuğu
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: TextField(
              onChanged: (val) => setState(() => _searchQuery = val),
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // Kategori Filtreleri
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (_) =>
                        setState(() => _selectedCategory = category),
                    selectedColor: AppColors.primary.withAlpha(50),
                    checkmarkColor: AppColors.primary,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          // Ürün Izgarası (Grid)
          Expanded(
            child: _filteredProducts.isEmpty
                ? const Center(child: Text('No products found.'))
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.72,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = _filteredProducts[index];
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () => widget.onSelectProduct(product),
                          child: Column(
                            crossAxisAlignment: CrossAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  color: Colors.grey[200],
                                  child: Image.network(
                                    product.imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        const Icon(Icons.image, size: 50),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAlignment.start,
                                  children: [
                                    Text(
                                      product.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '\$${product.price.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () =>
                                              widget.onAddToCart(product),
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: AppColors.primary,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
