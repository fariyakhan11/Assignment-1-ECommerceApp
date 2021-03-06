import 'package:flutter/material.dart';
import 'book_item_card.dart';
import 'package:book_app/main.dart';
import 'item_main.dart';
import 'book_item_card.dart';
import 'item_main.dart';

class CartPage extends StatefulWidget {
  CartPage({Key? key,
    required this.cart,
    required this.cartChanged,
  }) : super(key: key);

  final List<BookItem> cart;
  final ValueChanged<List<BookItem>> cartChanged;

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double _total = 0.0;

  @override
  void initState() {
    calculateTotal();
    super.initState();
  }

  void calculateTotal() {
    // Reset the total to zero in case we are recalculating the price
    _total = 0.0;

    for (var item in widget.cart) {
     setState(() {
        _total += item.price;
     });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
        backgroundColor: Colors.tealAccent,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cart.length,
              itemBuilder: (context, index) {
                return BookItemCard(
                  cart: widget.cart,
                  item: widget.cart[index],
                  onChanged: (bool inCart) => setState(()
                  {
                    if (inCart)
                      widget.cart.remove(widget.cart[index]);
                    else
                      widget.cart.add(widget.cart[index]);

                    widget.cartChanged(widget.cart);
                    calculateTotal();
                  }),
                );
              },
            ),
          ),
          const SizedBox(height: 50),
          Text("Total: ${_total.toString()}\$",
                style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
