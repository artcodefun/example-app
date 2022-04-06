

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/models/Category.dart';
import 'package:test_app/services/Storage.dart';
import 'package:test_app/services/impl/HiveStorage.dart';

main(){

  group("HiveStorage tests", (){
    const savePath ="test/hiveTestPath";
    late Storage hs;

    setUp(()async{
      hs = HiveStorage();
      await hs.init(savePath);
      await hs.registerType<Category, CategoryAdapter>("categories", CategoryAdapter());
    });

    test("model should be available after saved", ()async{
      const name = "testName";
      const testId =112;
      await hs.save(Category(id: testId, name: name));
      Category? res = await hs.findById(testId);

      expect(res?.name, name);

    });

  });
}