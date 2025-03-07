import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class Product {
  final int id;
  final String title;
  final String price;
  final String imageUrl;

  Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.imageUrl});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toString(),
      imageUrl: (json['images'] != null && json['images'].isNotEmpty)
          ? json['images'][0]
          : 'assets/images/human.png',
    );
  }
}

class PaginationExample extends StatefulWidget {
  const PaginationExample({super.key});

  @override
  State<PaginationExample> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<PaginationExample> {
  static const _pageSize = 5;
  final PagingController<int, Product> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.escuelajs.co/api/v1/products?offset=$pageKey&limit=$_pageSize'));
      final List<dynamic> data = json.decode(response.body);
      final List<Product> products =
          data.map((json) => Product.fromJson(json)).toList();

      final isLastPage = products.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(products);
      } else {
        final nextPageKey = pageKey + _pageSize;
        _pagingController.appendPage(products, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product List')),
      body: PagedListView<int, Product>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Product>(
            itemBuilder: (context, product, index) => Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                  child: ListTile(
                    leading: Image.network(
                      product.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/human.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    title: Text(product.title,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('\$${product.price}',
                        style: const TextStyle(color: Colors.green)),
                  ),
                )),
      ),
    );
  }
}
