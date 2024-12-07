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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      foodDataProvider.getModifierGroups(widget.item.modifierGroupId ?? '_');
    });
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
                        'RS ${widget.item.price.toString()}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.star, color: Colors.yellow, size: 20),
                      Text('5.0', style: TextStyle(fontSize: 16)),
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
                  TabBar(
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
                  Container(
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
                        Center(child: Text('Nutritional Info')),
                        Center(child: Text('Instructions')),
                        Center(child: Text('Allergens Info')),
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
                    Text(
                      'Toppings',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...foodDataProvider.modifierGroupList.map((value) {
                      return _buildToppingRow(value.title ?? '__', 0);
                    }).toList(),
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
                  Text(
                    'Choose Size',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildSizeOption('Small'),
                      _buildSizeOption('Medium', selected: true),
                      _buildSizeOption('Large'),
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
                  Text(
                    'Add Comments (Optional)',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextField(
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
                        icon: Icon(Icons.remove),
                        onPressed: () {},
                      ),
                      Text('1', style: TextStyle(fontSize: 18)),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {},
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
                    onPressed: () {},
                    child: Text('Add to Cart ₹1260',
                        style: TextStyle(fontSize: 16)),
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

  Widget _buildToppingRow(String name, int quantity) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Checkbox(
          value: false,
          onChanged: (value) {},
        ),
        Text(name, style: TextStyle(fontSize: 16)),
        Row(
          children: [
            IconButton(icon: Icon(Icons.remove), onPressed: () {}),
            Text(quantity.toString(), style: TextStyle(fontSize: 16)),
            IconButton(icon: Icon(Icons.add), onPressed: () {}),
          ],
        ),
      ],
    );
  }

  Widget _buildSizeOption(String size, {bool selected = false}) {
    return Row(
      children: [
        Checkbox(
          value: selected,
          onChanged: (value) {},
        ),
        Text(size),
      ],
    );
  }
}
