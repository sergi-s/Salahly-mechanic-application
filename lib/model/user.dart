class User {
  final String imagePath;
  final String name;
  final String email;
  final String about;
  final String lastappointement;
  final String lastreview;
  final bool isDarkMode;

  const User({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.about,
    required this.lastappointement,
    required this.lastreview,
    required this.isDarkMode,
  });
}
