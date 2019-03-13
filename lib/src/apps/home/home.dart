import 'package:angular/angular.dart';

import 'package:common/models.dart';
import 'package:wclient/src/apps/home/widget/login/login_component.dart';
import 'package:wclient/src/apps/home/widget/signup/signup_component.dart';

@Component(
  selector: 'home',
  styleUrls: ['home.css'],
  templateUrl: 'home.html',
  directives: [
    NgIf,
    LoginComponent,
    SignupComponent,
  ],
)
class HomeApp {
  Signup signup;

  void onSignupSuccess(Signup signup) {
    this.signup = signup;
  }
}
