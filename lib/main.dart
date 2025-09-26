import 'package:flutter/material.dart';
import 'api_service.dart';
import 'meal.dart';
import 'meal_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MealDB App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Meal> meals = [];
  bool isLoading = false;
  TextEditingController controller = TextEditingController();

  void searchMeals(String query) async {
    if (query.isEmpty) return;
    setState(() => isLoading = true);
    try {
      final results = await ApiService.searchMeals(query);
      setState(() {
        meals = results;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🍽️ MealDB App"),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // 🔍 Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Search meals (e.g. Chicken, Pasta...)",
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () => searchMeals(controller.text),
                  ),
                ),
                onSubmitted: searchMeals,
              ),
            ),
            const SizedBox(height: 12),

            if (isLoading) const LinearProgressIndicator(),

            // 🍴 Meals Grid
            Expanded(
              child: meals.isEmpty
                  ? const Center(
                      child: Text(
                        "Search meals to see results",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.only(top: 8),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 items per row
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: meals.length,
                      itemBuilder: (context, index) {
                        final meal = meals[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MealDetail(mealId: meal.id),
                              ),
                            );
                          },
             child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                  child: Image.network(
                                    meal.thumbnail,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                  Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    meal.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}
