// Mocks generated by Mockito 5.4.2 from annotations
// in gami_acad/test/ui/controllers/home_controller_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:gami_acad/repository/auth_repository.dart' as _i5;
import 'package:gami_acad/repository/models/result.dart' as _i3;
import 'package:gami_acad/repository/models/user.dart' as _i4;
import 'package:gami_acad/repository/models/user_access.dart' as _i2;
import 'package:gami_acad/repository/user_repository.dart' as _i7;
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

class _FakeUserAccess_0 extends _i1.SmartFake implements _i2.UserAccess {
  _FakeUserAccess_0(
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

class _FakeUser_2 extends _i1.SmartFake implements _i4.User {
  _FakeUser_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepository extends _i1.Mock implements _i5.AuthRepository {
  MockAuthRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.UserAccess get user => (super.noSuchMethod(
        Invocation.getter(#user),
        returnValue: _FakeUserAccess_0(
          this,
          Invocation.getter(#user),
        ),
      ) as _i2.UserAccess);
  @override
  set user(_i2.UserAccess? _user) => super.noSuchMethod(
        Invocation.setter(
          #user,
          _user,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i6.Future<_i3.Result> loginUser({
    required String? registration,
    required String? password,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #loginUser,
          [],
          {
            #registration: registration,
            #password: password,
          },
        ),
        returnValue: _i6.Future<_i3.Result>.value(_FakeResult_1(
          this,
          Invocation.method(
            #loginUser,
            [],
            {
              #registration: registration,
              #password: password,
            },
          ),
        )),
      ) as _i6.Future<_i3.Result>);
  @override
  _i6.Future<_i3.Result> signUpUser({
    required String? registration,
    required String? password,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #signUpUser,
          [],
          {
            #registration: registration,
            #password: password,
          },
        ),
        returnValue: _i6.Future<_i3.Result>.value(_FakeResult_1(
          this,
          Invocation.method(
            #signUpUser,
            [],
            {
              #registration: registration,
              #password: password,
            },
          ),
        )),
      ) as _i6.Future<_i3.Result>);
  @override
  _i6.Future<_i3.Result> logoutUser() => (super.noSuchMethod(
        Invocation.method(
          #logoutUser,
          [],
        ),
        returnValue: _i6.Future<_i3.Result>.value(_FakeResult_1(
          this,
          Invocation.method(
            #logoutUser,
            [],
          ),
        )),
      ) as _i6.Future<_i3.Result>);
}

/// A class which mocks [UserRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserRepository extends _i1.Mock implements _i7.UserRepository {
  MockUserRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.User get user => (super.noSuchMethod(
        Invocation.getter(#user),
        returnValue: _FakeUser_2(
          this,
          Invocation.getter(#user),
        ),
      ) as _i4.User);
  @override
  set user(_i4.User? _user) => super.noSuchMethod(
        Invocation.setter(
          #user,
          _user,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i6.Future<_i3.Result> addUser({
    required String? id,
    required String? name,
    required String? email,
    required String? registration,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addUser,
          [],
          {
            #id: id,
            #name: name,
            #email: email,
            #registration: registration,
          },
        ),
        returnValue: _i6.Future<_i3.Result>.value(_FakeResult_1(
          this,
          Invocation.method(
            #addUser,
            [],
            {
              #id: id,
              #name: name,
              #email: email,
              #registration: registration,
            },
          ),
        )),
      ) as _i6.Future<_i3.Result>);
  @override
  _i6.Future<_i3.Result> getUser({required String? id}) => (super.noSuchMethod(
        Invocation.method(
          #getUser,
          [],
          {#id: id},
        ),
        returnValue: _i6.Future<_i3.Result>.value(_FakeResult_1(
          this,
          Invocation.method(
            #getUser,
            [],
            {#id: id},
          ),
        )),
      ) as _i6.Future<_i3.Result>);
}
