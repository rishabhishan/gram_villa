import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:gram_villa/models/category_model.dart';

import 'services.dart';

/// Static global state. Immutable services that do not care about build context.
class Global {

  // Data Models
  static final Map models = {
    UserModel: (data) => UserModel.fromJson(data),
    Category: (data) => Category.fromJson(data),
  };

}
