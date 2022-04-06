import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/repos/impl/BasicRepository.dart';

import 'TestModel.dart';
import 'mocks/service_mocks.dart';


main() {
  group("basicRepository tests", () {

    MockApiHandler mah = MockApiHandler();
    MockStorage ms = MockStorage();
    late BasicRepository<TestModel> br;

    const apiPath = "test-path/";
    const testId = 1;
    const backName = "loaded from backend";
    const localName = "loaded from local storage";

    setUp(() {
      mah.clearAnswers();
      ms.clearAnswers();

      br = BasicRepository(
          storage: ms, apiHandler: mah, apiPath: apiPath, serializer: TestModelSerializer());
    });

    test("if model is stored locally it should be loaded with 'load' method", () async {

      ms.setAnswer("findById", (args) => TestModel(id: testId, name: localName, height: 88));
      ms.setAnswer("save", (args) => null);

      mah.setAnswer("get", (args) => TestModel(id: testId, name: backName, height: 88));

      var tm = await br.load(testId);
      expect(tm == null, false,
          reason: "if result is null it was not loaded from local storage");

      expect(tm?.name, localName,
          reason: "correct TestModel was loaded");
    });

    test("model should be downloaded if not stored locally", () async {

      ms.setAnswer("findById", (args) => null);
      ms.setAnswer("save", (_) => null);

      mah.setAnswer("get", (args) => TestModel(id: testId, name: backName, height: 88));

      var tm = await br.load(testId);
      expect(tm == null, false,
          reason: "if result is null it was not downloaded from backend");

      expect(tm?.name, backName,
          reason: "correct TestModel was loaded");
    });

    test("'load' method should return null if model could not be loaded", () async {

      ms.setAnswer("findById", (args) => null);
      ms.setAnswer("save", (_) => null);

      mah.setAnswer("get", (args) => throw Error());

      var tm = await br.load(testId);

      expect(tm == null, true,
          reason: "model cannot be loaded therefore returns null");

    });

    test("model should update with 'pull' method", () async {

      TestModel localModel = TestModel(id: testId, name: localName, height: 88);
      ms.setAnswer("findById", (args) => localModel.copyWith());
      ms.setAnswer("save", (args) => localModel=args.first);

      mah.setAnswer("get", (args) => TestModel(id: testId, name: backName, height: 88));

      var tm = await br.load(testId);
      expect(tm?.name, localName,
          reason: "should first load local model");

      await br.pull(testId);

      tm = await br.load(testId);
      expect(tm?.name, backName,
          reason: "should then load remote model");
    });

    test("if model is updated listeners should be notified", () async {

      ms.setAnswer("findById", (args) => TestModel(id: testId, name: localName, height: 88));
      ms.setAnswer("save", (args) => null);

      mah.setAnswer("get", (args) => TestModel(id: testId, name: backName, height: 88));

      var s = br.stream;
      var ftm = s.first;
      bool completed =false;

      await br.pull(testId);
      await Future.any([Future.delayed(Duration(seconds: 3)), ftm.then((_)=>completed=true)]);


      expect(completed, true, reason :"listeners should be notified");
      var tm = await ftm;

      expect(tm.name, backName,
          reason: "model was updated correctly");

    });

  });


}
