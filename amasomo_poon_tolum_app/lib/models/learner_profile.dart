class LearnerProfile {
  LearnerProfile({
    this.name = 'Learner',
    this.streak = 0,
    this.xp = 0,
    this.cowries = 0,
    this.hearts = 5,
    this.goal = '',
    this.cadence = 'Steady',
    this.level = 'Beginner',
    this.placementDone = false,
    this.currentUnit = 1,
    this.currentLesson = 1,
  });

  String name;
  int streak;
  int xp;
  int cowries;
  int hearts;
  String goal;
  String cadence;
  String level;
  bool placementDone;
  int currentUnit;
  int currentLesson;
}
