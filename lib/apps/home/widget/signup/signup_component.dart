// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:angular/angular.dart';

import 'package:wclient/utils/directives/input_binder.dart';

import 'package:common/models.dart';
import 'package:common/api/api.dart';

@Component(
  selector: 'signup',
  styleUrls: const ['signup_component.css'],
  templateUrl: 'signup_component.html',
  directives: const [
    TextBinder,
    NgIf,
    NgFor,
  ],
)
class SignupComponent {
  @Output()
  Stream<Signup> get onSuccess => _onSuccess;

  final _successController = StreamController<Signup>();

  Stream<Signup> _onSuccess;

  Signup model = Signup();

  String password;

  SignupComponent() {
    _onSuccess = _successController.stream.asBroadcastStream();
  }

  Future<void> submit() async {
    if (password != model.password) {
      print("Passwords do not match!");
      // TODO show message
      return;
    }
    await authApi.signup(model);
    _successController.add(Signup.serializer.clone(model));
    reset();
  }

  void reset() {
    model.email = '';
    model.name = '';
    model.password = '';
    password = '';
  }
}
