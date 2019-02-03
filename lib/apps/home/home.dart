import 'package:angular/angular.dart';

import 'package:common/models.dart';
import 'package:wclient/apps/home/widget/login/login_component.dart';
import 'package:wclient/apps/home/widget/signup/signup_component.dart';

@Component(
  selector: 'home',
  styleUrls: ['home.css'],
  templateUrl: 'home.html',
  directives: [LoginComponent, SignupComponent],
)
class HomeApp {}
