/// Super simple mocking class that still works better then mockito when dealing with null-safe or generic methods lol
abstract class Mock {
  Map<String, Function> _answers = {};

  Map<String, Function> get answers => _answers;

  setAnswer<T>(String methodId, T Function(List args) answer) {
    answers[methodId] = answer;
  }

  tryAnswer(String methodId, List args) {
    if (answers[methodId] == null) {
      throw UnimplementedError();
    }

    return answers[methodId]!(args);
  }

  clearAnswers() {
    _answers = {};
  }
}
