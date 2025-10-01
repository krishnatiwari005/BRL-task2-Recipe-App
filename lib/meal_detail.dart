import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'api_service.dart';

class MealDetail extends StatefulWidget {
  final String mealId;
  const MealDetail({super.key, required this.mealId});

  @override
  State<MealDetail> createState() => _MealDetailState();
}

class _MealDetailState extends State<MealDetail> {
  Map<String, dynamic>? meal;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMeal();
  }

  void fetchMeal() async {
    try {
      final data = await ApiService.getMealDetails(widget.mealId);
      setState(() {
        meal = data;
        isLoading = false;
      });
    } 
    catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: SpinKitCircle(size: 200,color: Color.fromARGB(255, 241, 204, 179))));
    }

    if (meal == null) {
      return const Scaffold(body: Center(child: Text("Meal not found")));
    }

    return Scaffold(
      appBar: AppBar(title: Text(meal!['strMeal'])),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
    
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(meal!['strMealThumb']),
            ),
            const SizedBox(height: 16),

      
            Text(
              meal!['strMeal'],
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              "${meal!['strCategory']} • ${meal!['strArea']}",
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const Divider(height: 40),


            const Text(
              "Instructions:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(meal!['strInstructions'] ?? "", style: const TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
