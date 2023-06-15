import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pet_user_app/models/apiHelper.dart';
import 'package:pet_user_app/models/entites/address.dart';
import 'package:pet_user_app/models/entites/blogs.dart';
import 'package:pet_user_app/models/entites/cart.dart';
import 'package:pet_user_app/models/entites/event.dart';
import 'package:pet_user_app/models/entites/order.dart';

import 'package:pet_user_app/models/entites/pets.dart';
import 'package:pet_user_app/models/entites/posts.dart';
import 'package:pet_user_app/models/entites/products.dart';

import 'package:geocoding/geocoding.dart';

import 'package:pet_user_app/models/entites/worker.dart';
import 'package:pet_user_app/screens/productDetailScreen.dart';

class ApiUtils {
  static final ApiUtils _instance = ApiUtils._internal();
  APIHelper _apiHelper = APIHelper();

  factory ApiUtils() {
    return _instance;
  }

  ApiUtils._internal();

  Future<List<Products>> getAllProducts() async {
    Response response = await _apiHelper.dio.get("/shop/getAll");
    if (response.statusCode == 200) {
      return (response.data as List<dynamic>)
          .map((productJson) => Products.fromJson(productJson))
          .toList();
    }
    return null;
  }

  Future<List<Worker>> getAllWorker() async {
    Response response = await _apiHelper.dio.get("/worker/getAll");
    if (response.statusCode == 200) {
      return (response.data as List<dynamic>)
          .map((workerJson) => Worker.fromJson(workerJson))
          .toList();
    }
    return null;
  }

  Future<List<Pets>> getAllPets() async {
    Response response = await _apiHelper.dio.get("/pets/getAll");
    if (response.statusCode == 200) {
      return (response.data as List<dynamic>)
          .map((petsJson) => Pets.fromJson(petsJson))
          .toList();
    }
    return null;
  }

  Future<List<Blogs>> getAllBlogs() async {
    Response response = await _apiHelper.dio.get("/blogs/getAll");
    if (response.statusCode == 200) {
      return (response.data as List<dynamic>)
          .map((blogsJson) => Blogs.fromJson(blogsJson))
          .toList();
    }
    return null;
  }

  Future<List<Posts>> getAllPosts() async {
    Response response = await _apiHelper.dio.get("/posts/getAll");
    if (response.statusCode == 200) {
      return (response.data as List<dynamic>)
          .map((postsJson) => Posts.fromJson(postsJson))
          .toList();
    }
    return null;
  }

  Future<List<Event>> getAllEvents() async {
    Response response = await _apiHelper.dio.get("/events/getAll");
    if (response.statusCode == 200) {
      return (response.data as List<dynamic>)
          .map((eventsJson) => Event.fromJson(eventsJson))
          .toList();
    }
    return null;
  }

  Future<List<Order>> getAllOrder() async {
    Response response = await _apiHelper.dio.get("/orders/getAll");
    if (response.statusCode == 200) {
      return (response.data as List<dynamic>)
          .map((orderJson) => Order.fromJson(orderJson))
          .toList();
    }
    return null;
  }

  Future<List<Cart>> getAllCart() async {
    Response response = await _apiHelper.dio.get("/cart/getAll");
    if (response.statusCode == 200) {
      return (response.data as List<dynamic>)
          .map((cartJson) => Cart.fromJson(cartJson))
          .toList();
    }
    return null;
  }

  Future<void> deleteOrder(int orderId) async {
    try {
      Response response =
          await _apiHelper.dio.delete("/orders/deleteOrder/$orderId");
      if (response.statusCode == 200) {
        // Order deleted successfully
        print("Order with ID $orderId deleted successfully");
      } else {
        // Error deleting order
        print(
            "Error deleting order with ID $orderId. Status code: ${response.statusCode}");
      }
    } catch (e) {
      // Exception occurred
      print("Exception occurred while deleting order: $e");
    }
  }

  Future<void> deleteProdFromcart(int cartId) async {
    try {
      Response response =
          await _apiHelper.dio.delete("/cart/deleteCart/$cartId");
      if (response.statusCode == 200) {
        // Order deleted successfully
        print("cart with ID $cartId deleted successfully");
      } else {
        // Error deleting cart
        print(
            "Error deleting cart with ID $cartId. Status code: ${response.statusCode}");
      }
    } catch (e) {
      // Exception occurred
      print("Exception occurred while deleting cart: $e");
    }
  }

  Future<void> deleteAllProdFromcart(int userId) async {
    try {
      Response response =
          await _apiHelper.dio.delete("/cart/deleteAllCart/$userId");
      if (response.statusCode == 200) {
        // Order deleted successfully
        print("cart with ID $userId deleted successfully");
      } else {
        // Error deleting cart
        print(
            "Error deleting cart with ID $userId. Status code: ${response.statusCode}");
      }
    } catch (e) {
      // Exception occurred
      print("Exception occurred while deleting cart: $e");
    }
  }

  Future<void> updateOrder(Map<String, dynamic> order) async {
    try {
      Response response = await _apiHelper.dio.put(
        '/orders/updateOrder/${order["id"]}',
        data: jsonEncode(order),
        options: Options(contentType: 'application/json'),
      );

      if (response.statusCode == 200) {
        // Address added successfully
        print('Address added successfully');
      } else {
        // Handle error
        print('Failed to add address. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error
      print('Error adding address: $e');
    }
  }

  Future<void> aboutWorker(Map<String, dynamic> about) async {
    try {
      Response response = await _apiHelper.dio.put(
        '/worker/updateWorker/${about["id"]}',
        data: jsonEncode(about),
        options: Options(contentType: 'application/json'),
      );

      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');
    } catch (e) {
      print('Error updating worker: $e');
    }
  }

  Future<void> updateUser(Map<String, dynamic> user) async {
    try {
      Response response = await _apiHelper.dio.put(
        '/user/updateUser/${user["id"]}',
        data: jsonEncode(user),
        options: Options(contentType: 'application/json'),
      );
      print(jsonEncode(user));
      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');
    } catch (e) {
      print('Error updating worker: $e');
    }
  }

  Future<void> addToCart(Map<String, dynamic> cart) async {
    try {
      Response response = await _apiHelper.dio.post(
        '/cart/addToCart',
        data: jsonEncode(cart),
        options: Options(contentType: 'application/json'),
      );

      if (response.statusCode == 200) {
        print('cart added successfully');
      } else {
        print('Failed to add cart. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding cart: $e');
    }
  }

  Future<void> postOrder(Map<String, dynamic> order) async {
    try {
      Response response = await _apiHelper.dio.post(
        '/orders/addOrder',
        data: jsonEncode(order),
        options: Options(contentType: 'application/json'),
      );

      if (response.statusCode == 200) {
        print('Order added successfully');
      } else {
        print('Failed to add order. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding order: $e');
    }
  }

  Future<void> postAddress(Address address) async {
    try {
      print('Address object: $address');
      // Use geocoding to get latitude and longitude for the address
      List<Location> locations = await locationFromAddress(address.address);
      if (locations.isNotEmpty) {
        address.latitude = locations[0].latitude;
        address.longitude = locations[0].longitude;
      }
      print('Address object after geocoding: $address');
      // Post the address to the backend
      Response response = await _apiHelper.dio.post(
        '/addAddress',
        data: jsonEncode(address.toJson()),
        options: Options(contentType: 'application/json'),
      );

      if (response.statusCode == 200) {
        // Address added successfully
        print('Address added successfully');
      } else {
        // Handle error
        print('Failed to add address. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error
      print('Error adding address: $e');
    }
  }
}
