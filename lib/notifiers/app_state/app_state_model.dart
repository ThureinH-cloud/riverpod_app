class AppStateModel {
  final bool isDark;
  AppStateModel({
    required this.isDark,
  });
  AppStateModel copyWith({
    bool? isDark,
  }) {
    return AppStateModel(
      isDark: isDark ?? this.isDark,
    );
  }
}
