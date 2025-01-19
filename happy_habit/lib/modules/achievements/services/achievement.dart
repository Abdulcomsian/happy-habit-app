import '../../../core/constants/asset_paths.dart';

class Achievement {
  final int score;
  final String svg, title;
  const Achievement({
    required this.svg,
    required this.title,
    required this.score,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      svg: json['svg'],
      title: json['title'],
      score: json['score'],
    );
  }

  static List<Achievement> achievements = [
    Achievement(svg: AchievementIcons.creator, title: 'The Creator', score: 10),
    Achievement(svg: AchievementIcons.kickstart, title: 'Kickstart', score: 9),
    Achievement(svg: AchievementIcons.musicStar, title: 'Music Star', score: 7),
    Achievement(svg: AchievementIcons.oneHourClub, title: 'One Hour Club', score: 10),
    Achievement(svg: AchievementIcons.sportsman, title: 'Sportsman', score: 5),
    Achievement(svg: AchievementIcons.creator, title: 'The Creator', score: 10),
    Achievement(svg: AchievementIcons.kickstart, title: 'Kickstart', score: 9),
    Achievement(svg: AchievementIcons.musicStar, title: 'Music Star', score: 7),
    Achievement(svg: AchievementIcons.oneHourClub, title: 'One Hour Club', score: 10),
    Achievement(svg: AchievementIcons.sportsman, title: 'Sportsman', score: 5),
  ];
}
