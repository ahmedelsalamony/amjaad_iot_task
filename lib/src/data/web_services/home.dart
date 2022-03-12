import 'package:amjaadiot_task/src/app/end_points.dart';
import 'package:amjaadiot_task/src/data/api_base_helper.dart';
import 'package:dio/dio.dart';

class HomeWebService {
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  Future<dynamic> getCategories(String url) async {
    try {
      Response response = await Dio().get(url);
      return response.data;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> getProducts(String url) async {
    dynamic response = await ApiBaseHelper().get(url);
    return response;
  }

  Future<int> getProductsCount() async {
    dynamic response =
        await ApiBaseHelper().get('https://fakestoreapi.com/products');
    return response.length;
  }

  Future<dynamic> getProductsByCategory(String category) async {
    dynamic response =
        await ApiBaseHelper().get(EndPoints.productsByCategory + category);
    return response;
  }
}
