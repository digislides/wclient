// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'package:wclient/utils/directives/input_binder.dart';

import 'package:common/models.dart';
import 'package:common/api/api.dart';
import 'package:jaguar_resty/jaguar_resty.dart';

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
  Signup model = Signup();

  String password;

  Future<void> submit() async {
    if(password != model.password) {
      print("Passwords do not match!");
      // TODO show message
      return;
    }
    final authApi = AuthApi(Route("http://localhost:10000/api"));
    await authApi.signup(model);
  }
}
