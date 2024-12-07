import 'package:ecologital_pvt_limited_food_ordering_app/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:ecologital_pvt_limited_food_ordering_app/provider/food_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:ecologital_pvt_limited_food_ordering_app/models/item.dart';

class ItemPage extends StatefulWidget {
  final Item item;
  const ItemPage({super.key, required this.item});
  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  late FoodDataProvider foodDataProvider;
  late int price;
  int qty = 1;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    price = widget.item.price == 0 || widget.item.price == null
        ? 500
        : widget.item.price!;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      foodDataProvider.getModifierGroups(widget.item.modifierGroupId ?? '_');
    });
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    foodDataProvider = Provider.of<FoodDataProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Image.network(
                  widget.item.imageUrl ?? '__',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Title, Price, and Rating
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    (widget.item.title ?? '__').split(' ').take(2).join(' '),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        'RS $price',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.star, color: Colors.yellow, size: 20),
                      Text(widget.item.totalReviews.toString(),
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.item.description ?? '__',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 16),

            // Tabs
            DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  const TabBar(
                    indicatorColor: Colors.green,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: 'Ingredients'),
                      Tab(text: 'Nutritional'),
                      Tab(text: 'Instructions'),
                      Tab(text: 'Allergens'),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Tab Content
                  SizedBox(
                    height: 100,
                    child: TabBarView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'This product contains ingredients that may trigger allergies...',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[600]),
                              ),
                              const SizedBox(height: 8),
                              Expanded(
                                child: Wrap(
                                  spacing: 8,
                                  children: [
                                    'Eggs',
                                    'Milk',
                                    'Mollusks',
                                    'Mustard',
                                    'Gluten'
                                  ]
                                      .map((ingredient) =>
                                          Chip(label: Text(ingredient)))
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Center(child: Text('Nutritional Info')),
                        const Center(child: Text('Instructions')),
                        const Center(child: Text('Allergens Info')),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Toppings
            if (foodDataProvider.modifierGroupList.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Toppings',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...foodDataProvider.modifierGroupList
                        .asMap()
                        .entries
                        .map((entry) {
                      final index = entry.key; // Get the index
                      final value = entry.value; // Get the value
                      return _buildToppingRow(value.title ?? '__', 0, index);
                    }),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 16),

            // Choose Size
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Choose Size',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ...foodDataProvider.sizes.asMap().entries.map((entry) {
                        final index = entry.key; // Get the index
                        final value = entry.value; // Get the value
                        return _buildSizeOption(
                            value.sizeName, value.isSelected!, index);
                      }),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Comments
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add Comments (Optional)',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      hintText: 'Write here',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Quantity and Add to Cart
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (qty > 1) {
                              qty -= 1;
                              _updatePrice();
                            }
                          });
                        },
                      ),
                      Text(qty.toString(), style: TextStyle(fontSize: 18)),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            qty += 1;
                            _updatePrice();
                          });
                        },
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      CartItem cartItem = CartItem(
                          title: widget.item.title ?? '__',
                          price: price,
                          qty: qty,
                          comment: textEditingController.text.trim());
                      foodDataProvider.addToCart(cartItem);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text('Add to Cart RS: $price',
                        style: const TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildToppingRow(String name, int quantity, int indexNumber) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Checkbox(
          value: foodDataProvider.modifierGroupList[indexNumber].isChecked,
          onChanged: (value) {
            setState(() {
              foodDataProvider.modifierGroupList[indexNumber].isChecked = value;
            });
          },
        ),
        Text(name, style: const TextStyle(fontSize: 16)),
        Row(
          children: [
            IconButton(icon: const Icon(Icons.remove), onPressed: () {}),
            Text(quantity.toString(), style: const TextStyle(fontSize: 16)),
            IconButton(icon: const Icon(Icons.add), onPressed: () {}),
          ],
        ),
      ],
    );
  }

  Widget _buildSizeOption(String size, bool selected, int index) {
    return Row(
      children: [
        Checkbox(
          value: selected,
          onChanged: (value) {
            setState(() {
              for (var size in foodDataProvider.sizes) {
                size.isSelected = false; // Uncheck all sizes
              }
              foodDataProvider.sizes[index].isSelected = value;
              _updatePrice();
            });
          },
        ),
        Text(size),
      ],
    );
  }

  void _updatePrice() {
    // Base price
    int basePrice = widget.item.price ?? 500;

    // Adjust price based on the selected size
    for (var size in foodDataProvider.sizes) {
      if (size.isSelected == true) {
        if (size.sizeName == 'Large') {
          basePrice += 500; // Add 500 for Large
        } else if (size.sizeName == 'Small') {
          basePrice -= 100; // Subtract 100 for Small
        }
      }
    }

    // Final price = base price * quantity
    price = basePrice * qty;
  }
}
