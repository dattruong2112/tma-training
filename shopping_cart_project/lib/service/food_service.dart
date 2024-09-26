import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shopping_cart_project/models/foods.dart';

const foodBaseUrl = 'http://172.16.13.249:8080/food';
const orderBaseUrl = 'http://172.16.13.249:8080/order';

int success = 200;
int created = 201;
int notFound = 404;
int unauthorized = 401;

class FoodService {
  final dio = Dio()..interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      filter: (options, args) {
        //  return !options.uri.path.contains('posts');
        return !args.isResponse || !args.hasUint8ListData;
      },
    ),
  );


  Future<List<Food>> getFoodByCategory(String category) async {
    var response =
        await dio.get('$foodBaseUrl/category/$category');
    return (response.data as List).map((e) => Food.fromJson(e)).toList();
  }

  Future<List<Food>> getFoodByFavorite() async {
    var response =
        await dio.get('$foodBaseUrl/favorite');
    return (response.data as List).map((e) => Food.fromJson(e)).toList();
  }

  Future<List<Food>> getFood() async {
    var response = await dio.get('$foodBaseUrl/');
    return (response.data as List).map((e) => Food.fromJson(e)).toList();
  }

  Future<void> favoriteFood(Food food, bool isFavorite) async {
    try {
      await dio.put(
        '$foodBaseUrl/edit/favorite/${food.id}',
        data: {'favorite': isFavorite},
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateQuantity(Food food, int quantity) async {
    try {
      await dio.put(
        '$foodBaseUrl/edit/quantity/${food.id}',
        data: {'quantity': quantity},
      );
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> addToOrder(List<Food> cartItems) async {
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    String formattedDate = dateFormat.format(now);
    try {
      var orderData = {
        'orderDateTime': formattedDate.toString(),
        'food': cartItems.map((item) => {
          'id': int.parse(item.id)
        }).toList(),
      };

      var response = await dio.post(
        '$orderBaseUrl/create',
        data: orderData,
      );
     
      if (response.statusCode == success || response.statusCode == created) {
        var responseData = response.data;
        int orderId = responseData['orderId'];
        String orderDateTime = responseData['orderDateTime'];
        return {
          'orderId': orderId,
          'orderDateTime': orderDateTime,
          'foods': cartItems,
        };
      } else {
        throw Exception('Failed to create order');
      }
    } catch (e) {
      throw Exception('Failed to create order');
    }
  }
}
