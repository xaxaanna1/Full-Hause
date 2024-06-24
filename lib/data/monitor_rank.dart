import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leaderboard_api_example/data/api.dart';
import 'package:leaderboard_api_example/generated/grpc/skllzz/challenge/challenge.pb.dart';

import '../generated/grpc/skllzz/lk/challenges.pb.dart';

final monitorRankProvider = StreamProvider.autoDispose<LeaderboardRank>((ref) {
  final api = ref.watch(manageChallengesClient);

  return api.monitorRank((ChallengesScope()
    ..clubId = "tricet"
    ..itemId = "23f34712-1ed6-412e-86d2-610b62d2a14d"));
});
