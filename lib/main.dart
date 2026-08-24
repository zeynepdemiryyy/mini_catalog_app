import 'package:flutter/material.dart';

import 'models/product.dart';
import 'constants/app_colors.dart';
import 'screens/discover_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';

void main() {
  runApp(const MiniCatalogApp());
}

class MiniCatalogApp extends StatefulWidget {
  const MiniCatalogApp({super.key});

  @override
  State<MiniCatalogApp> createState() => _MiniCatalogAppState();
}

class _MiniCatalogAppState extends State<MiniCatalogApp> {
  final List<CartItem> _cart = [];

  void _addToCart(Product product) {
    setState(() {
      final index = _cart.indexWhere((item) => item.product.id == product.id);
      if (index >= 0) {
        _cart[index].quantity++;
      } else {
        _cart.add(CartItem(product: product));
      }
    });
  }

  void _incrementQuantity(Product product) {
    _addToCart(product);
  }

  void _decrementQuantity(Product product) {
    setState(() {
      final index = _cart.indexWhere((item) => item.product.id == product.id);
      if (index >= 0) {
        if (_cart[index].quantity > 1) {
          _cart[index].quantity--;
        } else {
          _cart.removeAt(index);
        }
      }
    });
  }

  void _removeFromCart(Product product) {
    setState(() {
      _cart.removeWhere((item) => item.product.id == product.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Catalog App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: Navigator(
        pages: [
          MaterialPage(
            child: DiscoverScreen(
              cart: _cart,
              onAddToCart: _addToCart,
              onOpenCart: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CartScreen(
                      cart: _cart,
                      onIncrement: _incrementQuantity,
                      onDecrement: _decrementQuantity,
                      onRemove: _removeFromCart,
                    ),
                  ),
                );
              },
              onSelectProduct: (product) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProductDetailScreen(
                      product: product,
                      onAddToCart: _addToCart,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
        onPopPage: (route, result) => route.didPop(result),
      ),
    );
  }
}
