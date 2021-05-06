import 'package:covid_app/models/oxygen_model.dart';
import 'package:flutter/material.dart';

class OxygenProvider extends ChangeNotifier{
  OxygenModel oxygenModel = OxygenModel();

  // private variable to check if the process to update to db is complete.
  bool _isUpdatingOxygenDoc = false;

  // Getter for user profile loading variable
  bool get isUpdatingOxygenDoc => _isUpdatingOxygenDoc;


  /// Functions to get input

   


}