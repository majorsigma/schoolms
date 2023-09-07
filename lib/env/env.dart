// ignore_for_file: depend_on_referenced_packages

import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
    @EnviedField(varName: "GMAPS_KEY")
    static const String gmapsKey = _Env.gmapsKey;
}