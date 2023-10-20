// Mocks generated by Mockito 5.4.2 from annotations
// in gami_acad/test/ui/controllers/reward_controller_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:gami_acad/repository/models/result.dart' as _i3;
import 'package:gami_acad/repository/models/user_rewards.dart' as _i2;
import 'package:gami_acad/repository/reward_repository.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeUserRewards_0 extends _i1.SmartFake implements _i2.UserRewards {
  _FakeUserRewards_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResult_1 extends _i1.SmartFake implements _i3.Result {
  _FakeResult_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [RewardRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockRewardRepository extends _i1.Mock implements _i4.RewardRepository {
  MockRewardRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.UserRewards get userRewards => (super.noSuchMethod(
        Invocation.getter(#userRewards),
        returnValue: _FakeUserRewards_0(
          this,
          Invocation.getter(#userRewards),
        ),
      ) as _i2.UserRewards);
  @override
  set userRewards(_i2.UserRewards? _userRewards) => super.noSuchMethod(
        Invocation.setter(
          #userRewards,
          _userRewards,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i5.Future<_i3.Result> getUserRewards({required String? userId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserRewards,
          [],
          {#userId: userId},
        ),
        returnValue: _i5.Future<_i3.Result>.value(_FakeResult_1(
          this,
          Invocation.method(
            #getUserRewards,
            [],
            {#userId: userId},
          ),
        )),
      ) as _i5.Future<_i3.Result>);
  @override
  _i5.Future<_i3.Result> claimReward({
    required String? userId,
    required String? rewardId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #claimReward,
          [],
          {
            #userId: userId,
            #rewardId: rewardId,
          },
        ),
        returnValue: _i5.Future<_i3.Result>.value(_FakeResult_1(
          this,
          Invocation.method(
            #claimReward,
            [],
            {
              #userId: userId,
              #rewardId: rewardId,
            },
          ),
        )),
      ) as _i5.Future<_i3.Result>);
}
