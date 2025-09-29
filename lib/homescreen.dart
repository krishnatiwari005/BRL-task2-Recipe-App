import 'package:flutter/material.dart';
import 'package:recipe_app/widget/support_widget.dart';
import 'api_service.dart';
import 'meal.dart';
import 'meal_detail.dart';
import 'meals_by_category.dart';
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

      body: 
      
      SafeArea(
        
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
         child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(30),
                child: Container(height: 150, 
                  decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.orange,const Color.fromARGB(255, 205, 55, 55)])),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Looking for your\nfavourite meal🍴",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          "https://img.freepik.com/premium-photo/cute-mustache-man-cooking-vector-cartoon-illustration-culinary-fun_1240525-31624.jpg",
                          height: 90,
                          width: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

//.........................................................................................................................................................................................................................................
             //added gif
             Center(
                 child: ClipRRect(
                 borderRadius: BorderRadius.circular(100),
                 child: Image.asset("assets/gif/plating.gif",
                 height: 150,
                 width: 150,
                 fit: BoxFit.cover,
               ),
             ),
            ),
           const SizedBox(height: 20),
//..................................................................................................................................
              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 237, 194, 169),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search for the recipe....",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search_rounded),
                      onPressed: () => searchMeals(controller.text),
                    ),
                  ),
                  onSubmitted: searchMeals,
                ),
              ),

              const SizedBox(height: 20),

//...................................................................................................................................................................................................................................

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
                        child:
                        
                         Container(
                          width: 100,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 232, 205, 131),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 3,
                                  offset: Offset(5, 1)),
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
              
//....................................................................................................................................................................................................................................
              // SizedBox(
              //   height: 100,
              //   width: MediaQuery.of(context).size.width,
              //   child: Lottie.network("https://assets10.lottiefiles.com/packages/lf20_wqjdunpd.json"),
              // 


//........................................................................................................................................................................................
              // some example 
              SizedBox(
              height: 200,
               width: MediaQuery.of(context).size.width,
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                Text(
                     "Lets Try Trending Recipes.👇🏻😋👇🏻",  
                  style: TextStyle(
                     fontSize: 18,
                fontWeight: FontWeight.bold,
                ),
             ),
      SizedBox(height: 10),
      Expanded(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Container(
              margin: EdgeInsets.only(right: 20.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "https://www.bing.com/th/id/OIP.qxepEW5TM1BfaK2djD6aZQHaE8?w=273&h=211&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2",
                      height: 130,
                      width: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text("soup recipes", style: AppWidget.lightfeildtextstyle()),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "https://th.bing.com/th/id/R.29f9de0dca0b1379cef879245adb171d?rik=SqnSJbqx6Y0s3Q&riu=http%3a%2f%2fdel.h-cdn.co%2fassets%2f17%2f15%2f1492093044-loaded-veggie-chow-mein-vertical.jpg&ehk=4N%2fnIcFPO%2bxgVS8C1gQ9EStzN%2bXn5BnHDM8Q%2f1rb3yw%3d&risl=&pid=ImgRaw&r=0",
                      height: 130,
                      width: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text("chinese recipes", style: AppWidget.lightfeildtextstyle()),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "https://tse1.mm.bing.net/th/id/OIP.F0wSkwfP1ODfH1-tLW9O4gHaD-?rs=1&pid=ImgDetMain&o=7&rm=3",
                      height: 130,
                      width: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text("Indian recipes", style: AppWidget.lightfeildtextstyle()),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "https://tse4.mm.bing.net/th/id/OIP.UX4Iz1x72jW045xgBYHuBgHaHl?rs=1&pid=ImgDetMain&o=7&rm=3",
                      height: 130,
                      width: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text("dessert", style: AppWidget.lightfeildtextstyle()),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  ),
),



//..........................................................................................................................................................

              // Meals Grid
              SizedBox(
                height: 1500, 
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
          )

        ),
      ),
    );
  }
}
