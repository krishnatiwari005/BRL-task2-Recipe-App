import 'package:flutter/material.dart';
import 'api_service.dart';
import 'meal.dart';
import 'meal_detail.dart';
import 'meals_by_category.dart';
void main() { 
  runApp(const MyApp()); }
   class MyApp extends StatelessWidget {
     const MyApp({super.key});
      @override Widget build(BuildContext context) { 
        return MaterialApp( 
          debugShowCheckedModeBanner: false,
           title: 'MealDB App', 
           theme: ThemeData( primarySwatch: Colors.teal,
            scaffoldBackgroundColor: Colors.grey[100], ),
             home: const HomeScreen(), ); } }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Meal> meals = [];
  bool isLoading = false;
  TextEditingController controller = TextEditingController();

  List<dynamic> categories = [];
  bool isCategoryLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  // Fetch categories
  void fetchCategories() async {
    try {
      final data = await ApiService.getCategories();
      setState(() {
        categories = data;
        isCategoryLoading = false;
      });
    } catch (e) {
      setState(() => isCategoryLoading = false);
    }
  }

  // Search meals
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
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Looking for your\nfavourite meal",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      "https://tse1.mm.bing.net/th/id/OIP.ArI9rZ9dDCXO-VH_U87xMgAAAA?rs=1&pid=ImgDetMain&o=7&rm=3",
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 205, 205, 249),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search for the recipe",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search_rounded),
                      onPressed: () => searchMeals(controller.text),
                    ),
                  ),
                  onSubmitted: searchMeals,
                ),
              ),

              const SizedBox(height: 12),

              // Horizontal Category List
              if (isCategoryLoading)
                const SizedBox(
                  height: 80,
                  child: Center(child: CircularProgressIndicator()),
                )
              else
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MealsByCategory(
                                  categoryName: category['strCategory']),
                            ),
                          );
                        },
                        child: Container(
                          width: 100,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 3,
                                  offset: Offset(1, 1)),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  category['strCategoryThumb'],
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                category['strCategory'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

              const SizedBox(height: 12),

              if (isLoading) const LinearProgressIndicator(),

              // Meals Grid
              Expanded(
                child: meals.isEmpty
                    ? const Center(
                        child: Text(
                          "Search meals to see results",
                          style: TextStyle(
                              fontSize: 16, color: Colors.black54),
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.only(top: 8),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
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
                                  builder: (_) =>
                                      MealDetail(mealId: meal.id),
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
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(12)),
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
                                          fontSize: 14),
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
      ),
    );
  }
}
