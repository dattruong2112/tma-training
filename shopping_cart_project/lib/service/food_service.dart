import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shopping_cart_project/models/foods.dart';

class FoodService {
  static int success = 200;
  static int created = 201;
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
        await dio.get('http://172.16.13.249:8080/category/$category');
    return (response.data as List).map((e) => Food.fromJson(e)).toList();
  }

  Future<List<Food>> getFood() async {
    var response = await dio.get('http://172.16.13.249:8080/food/');
    return (response.data as List).map((e) => Food.fromJson(e)).toList();
  }

  Future<void> favoriteFood(Food food, bool isFavorite) async {
    try {
      var response = await dio.put(
        'http://172.16.13.249:8080/food/edit/favorite/${food.id}',
        data: {'favorite': isFavorite},
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
        'http://172.16.13.249:8080/order/create',
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
