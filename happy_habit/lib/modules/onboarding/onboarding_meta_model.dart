class OnboardingMeta {
  final String title, image, description;

  const OnboardingMeta({
    required this.title,
    required this.image,
    required this.description,
  });

  static List<OnboardingMeta> data = [
    OnboardingMeta(
      title: 'Welcome to Happy Habit!',
      image: 'assets/backgrounds/onboarding-0.webp',
      description:
          'Build productive habits, stay motivated, and level up your life with a fun, gamified experience.',
    ),
    OnboardingMeta(
      title: 'Track Your Progress',
      image: 'assets/backgrounds/onboarding-1.webp',
      description:
          'Stay on top of your habits with our Focus Timer and detailed productivity stats.',
    ),
  ];
}
