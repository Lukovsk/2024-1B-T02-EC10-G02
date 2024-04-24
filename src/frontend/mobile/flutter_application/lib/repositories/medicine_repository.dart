import 'package:flutter_application/models/medicine_model.dart';

abstract interface class UserRepository {
  Future<MedicineModel> getMedicine(String email);

}