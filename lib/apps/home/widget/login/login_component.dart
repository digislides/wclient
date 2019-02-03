// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';

import 'package:wclient/utils/directives/input_binder.dart';

import 'package:common/models.dart';
import 'package:common/api/api.dart';
import 'package:jaguar_resty/jaguar_resty.dart';

@Component(
  selector: 'login',
  styleUrls: const ['login_component.css'],
  templateUrl: 'login_component.html',
  directives: const [
    TextBinder,
    NgIf,
    NgFor,
  ],
)
class LoginComponent {
  Login model = Login();

  Future<void> submit() async {
    final authApi = AuthApi(Route("http://localhost:10000/api"));
    await authApi.login(model);
    // TODO handle errors
    window.location.assign("http://localhost:10000/dashboard/index.html");
  }
}
