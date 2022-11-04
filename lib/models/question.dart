class Question{
  final String id;
  final String title;
  final Map<String, bool> options;

  Question({required this.id,required this.options,required this.title});

  // ignore: annotate_overrides
  String toString() {
    return 'Question(id: $id,title: $title, options: $options';
  }
}