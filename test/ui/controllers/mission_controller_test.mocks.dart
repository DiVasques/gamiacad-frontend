// Mocks generated by Mockito 5.4.2 from annotations
// in gami_acad/test/ui/controllers/mission_controller_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:gami_acad/repository/mission_repository.dart' as _i4;
import 'package:gami_acad/repository/models/result.dart' as _i3;
import 'package:gami_acad/repository/models/user_missions_.dart' as _i2;
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

class _FakeUserMissions_0 extends _i1.SmartFake implements _i2.UserMissions {
  _FakeUserMissions_0(
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

/// A class which mocks [MissionRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMissionRepository extends _i1.Mock implements _i4.MissionRepository {
  MockMissionRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.UserMissions get userMissions => (super.noSuchMethod(
        Invocation.getter(#userMissions),
        returnValue: _FakeUserMissions_0(
          this,
          Invocation.getter(#userMissions),
        ),
      ) as _i2.UserMissions);
  @override
  set userMissions(_i2.UserMissions? _userMissions) => super.noSuchMethod(
        Invocation.setter(
          #userMissions,
          _userMissions,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i5.Future<_i3.Result> getUserMissions({required String? userId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserMissions,
          [],
          {#userId: userId},
        ),
        returnValue: _i5.Future<_i3.Result>.value(_FakeResult_1(
          this,
          Invocation.method(
            #getUserMissions,
            [],
            {#userId: userId},
          ),
        )),
      ) as _i5.Future<_i3.Result>);
}
