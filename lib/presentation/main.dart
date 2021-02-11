/*
 * Copyright (c) 2020 tokku5552
 *
 * This software is released under the MIT License.
 * https://opensource.org/licenses/mit-license.php
 *
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_sample_flutter/domain/storage_repository.dart';
import 'package:todo_app_sample_flutter/infrastructure/storage_repository_impl.dart';
import 'package:todo_app_sample_flutter/presentation/todo_list/todo_list_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<StorageRepository>(
          create: (_) => StorageRepositoryImpl(),
        )
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoAppSampleFlutter',
      home: TodoListPage(),
    );
  }
}
