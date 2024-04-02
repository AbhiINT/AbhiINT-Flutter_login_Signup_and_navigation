import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:hello_flutter/model/todo_model.dart';

class NewsMenuController extends GetxController {
  var newsList = <TodoModel>[].obs;

  @override
  void onInit() {
    fetchNewsData();
    super.onInit();
  }

  void fetchNewsData() async {
    try {
      var response =
          await Dio().get('https://jsonplaceholder.typicode.com/todos');
      List<dynamic> data = response.data;
      newsList.value = data.map((json) => TodoModel.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching news: $e');
    }
  }
}

class NewsMenu extends StatelessWidget {
  final NewsMenuController controller = Get.put(NewsMenuController());

  NewsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News')),
      body: Center(
        child: Obx(() {
          if (controller.newsList.isEmpty) {
            return const CircularProgressIndicator();
          } else {
            return ListView.builder(
              itemCount: controller.newsList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(controller.newsList[index].id.toString()),
                  title: Text(controller.newsList[index].title.toString()),
                  subtitle:
                      Text(controller.newsList[index].completed.toString()),
                  trailing: Text(controller.newsList[index].userId.toString()),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
