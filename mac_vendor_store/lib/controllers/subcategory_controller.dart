import 'dart:convert';
import 'package:mac_vendor_store/global_variables.dart';
import 'package:mac_vendor_store/models/sucategory.dart';

import 'package:http/http.dart' as http;

class SubcategoryController {
  Future<List<Subcategory>> getSubcategoriesByCategoryName(String categoryName) async {
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/api/category/$categoryName/subcategories"),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        if (data.isNotEmpty) { // Sửa logic kiểm tra dữ liệu
          return data.map((subcategory) => Subcategory.fromJson(subcategory)).toList();
        } else {
          print('Subcategories not found for category: $categoryName'); // Sửa thông báo lỗi
          return [];
        }
      } else if (response.statusCode == 404) {
        print('Category: $categoryName not found or has no subcategories.');
        return [];
      } else {
        print('Failed to fetch subcategories. Status code: ${response.statusCode}');
        print('Response body: ${response.body}'); // In nội dung phản hồi để gỡ lỗi
        return [];
      }
    } catch (e) {
      print('Error fetching subcategories: $e');
      return [];
    }
  }
}