import 'package:common/api/api.dart';
import 'package:jaguar_resty/jaguar_resty.dart';

final base = Route("/api");

final authApi = AuthApi(base);

final programApi = ProgramApi(base);

final channelApi = ChannelApi(base);
