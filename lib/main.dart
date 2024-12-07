import 'package:ecologital_pvt_limited_food_ordering_app/pages/item_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecologital_pvt_limited_food_ordering_app/provider/food_data_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FoodDataProvider(),
      child: MaterialApp(
        title: 'Food Menu',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.grey[100],
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<FoodDataProvider>(context, listen: false)
          .loadFoodData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Food Menu',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Consumer<FoodDataProvider>(
        builder: (context, provider, _) {
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: provider.dataBoxList.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.only(bottom: 12.0),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ExpansionTile(
                  title: Text(
                    provider.dataBoxList[index].menuTitle,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  backgroundColor: Colors.white,
                  collapsedBackgroundColor: Colors.grey[200],
                  children: [
                    if (provider.dataBoxList[index].categoryTitle != null)
                      ListTile(
                        title: Text(
                          provider.dataBoxList[index].categoryTitle ??
                              'Category',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        onTap: () {
                          provider.getItems(
                              provider.dataBoxList[index].menuCategoryId ?? '');
                          _showItemsDialog(context);
                        },
                      ),
                  ],
                  onExpansionChanged: (bool expanded) {
                    if (expanded) {
                      provider.getCategoriesForMenu(
                          provider.dataBoxList[index].menuId, index);
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showItemsDialog(BuildContext context) {
    FoodDataProvider foodDataProvider =
        Provider.of<FoodDataProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Items',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                foodDataProvider.itemList.isNotEmpty
                    ? SizedBox(
                        height: 250.0,
                        child: ListView.separated(
                          itemCount: foodDataProvider.itemList.length,
                          separatorBuilder: (context, index) =>
                              const Divider(height: 1.0),
                          itemBuilder: (context, index) {
                            final item = foodDataProvider.itemList[index];
                            return ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.title ?? 'Item',
                                      style: const TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                  if (item.isDealProduct == true)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4.0),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: const Text(
                                        'DEAL',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ItemPage(item: item),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      )
                    : const Center(
                        child: Text(
                          'No items found.',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
