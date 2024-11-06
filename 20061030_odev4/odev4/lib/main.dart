import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductPage(),
    );
  }
}

class Product {
  final String name;
  final double price;

  Product({
    required this.name,
    required this.price,
  });
}

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // Ürün verisi
  final List<Product> products = [
    Product(name: 'Product 1', price: 30.0),
    Product(name: 'Product 2', price: 50.0),
    Product(name: 'Product 3', price: 80.0),
    Product(name: 'Product 4', price: 100.0),
    Product(name: 'Product 5', price: 120.0),
  ];

  int? selectedIndex; // Seçili ürünü tutan index, hem horizontal hem de grid view için geçerli

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product List")),
      body: Column(
        children: [
          // Horizontal ListView sadece ürün adı, burada vurgulama yapılacak
          Container(
            height: 100.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;  // Yalnızca horizontal list için vurgulama
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: selectedIndex == index ? const Color.fromARGB(255, 161, 168, 250) : Colors.white,
                      border: Border.all(
                        color: selectedIndex == index ? const Color.fromARGB(255, 33, 100, 243) : Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(products[index].name),
                    ),
                  ),
                );
              },
            ),
          ),

          // GridView, ürün adı ve fiyatı gösterilecek ancak tıklama engellenecek
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Buradaki onTap boş bırakılacak, GridView öğeleri tıklanabilir olmayacak
                  },
                  child: GridTile(
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: selectedIndex == index ? const Color.fromARGB(255, 238, 144, 144) : Colors.white, // Vurgulama burada yapılacak
                        border: Border.all(
                           color: selectedIndex == index ? const Color.fromARGB(255, 243, 33, 33) : Colors.transparent,
                        width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(products[index].name),
                          Text("₺${products[index].price}"),
                        ],
                      ),
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
