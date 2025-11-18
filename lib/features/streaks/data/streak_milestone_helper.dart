import 'package:academia/database/database.dart';
import 'package:academia/features/streaks/domain/domain.dart';

extension StreakMilestoneHelper on StreakMilestoneData {
  StreakMilestone toEntity() => StreakMilestone(
    id: id,
    activityID: activityID,
    daysRequired: daysRequired,
    bonusPoints: bonusPoints,
    title: title,
    description: description,
    isActive: isActive,
    cachedAt: cachedAt,
  );
}
