enum PaperType {
  research('Research'),
  thesis('Thesis');

  const PaperType(this.title);
  final String title;
}

typedef Paper = ({PaperType type, String id});
