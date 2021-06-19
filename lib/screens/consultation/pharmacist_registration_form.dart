import 'package:covid_app/constants/app_constants.dart';
import 'package:covid_app/constants/image_constants.dart';
import 'package:covid_app/providers/pharmacy_provider.dart';
import 'package:covid_app/widgets/bottom_button.dart';
import 'package:covid_app/widgets/multi_select_dialog.dart';
import 'package:covid_app/widgets/text_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PharmacistRegistrationScreen extends StatefulWidget {
  @override
  _PharmacistRegistrationScreenState createState() =>
      _PharmacistRegistrationScreenState();
}

class _PharmacistRegistrationScreenState
    extends State<PharmacistRegistrationScreen> {
  // loading state variable
  bool _isLoading = false;

  // Text editing controllers
  TextEditingController _stateController = new TextEditingController();
  TextEditingController _cityController = new TextEditingController();
  TextEditingController _deliveryController = new TextEditingController();
  TextEditingController _operatingHoursController = new TextEditingController();  


  @override
  Widget build(BuildContext context) {
    // pharmacy provider
    final PharmacyProvider pharmacyProvider =  Provider.of<PharmacyProvider>(context);
    // Set text for controllers
    _stateController.text = pharmacyProvider.pharmacyModel.state;
    _cityController.text = pharmacyProvider.pharmacyModel.city;
    _operatingHoursController.text = pharmacyProvider.pharmacyModel.operatingHours;

   if(pharmacyProvider.pharmacyModel.isHomeDeliveryAvailable == true){
     _deliveryController.text = "Yes";
   } 
   else if(pharmacyProvider.pharmacyModel.isHomeDeliveryAvailable == false){
     _deliveryController.text = "No";
   }


    return WillPopScope(
      onWillPop: () {
        pharmacyProvider.resetProvider();
        Navigator.pop(context);
        return null;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Pharmacist / Chemist"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 48),
                    child: Image.asset(
                      ImageConstants.consulting,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32.0, 32, 32, 13),
                  child: TextBox(
                    hintText: "Name",
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.name,
                    onChanged: (value) => pharmacyProvider.updateName(value),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 11,
                    horizontal: 32,
                  ),
                  child: TextBox(
                    hintText: "State",
                    readOnly: true,
                    controller: _stateController,
                    onTap: () => _showSelectStateDialog(context),
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 11,
                    horizontal: 32,
                  ),
                  child: TextBox(
                    hintText: "City",
                    readOnly: true,
                    controller: _cityController,
                    onTap: () => pharmacyProvider.pharmacyModel.state == null
                        ? null
                        : _showSelectCityDialog(context),
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 11,
                    horizontal: 32,
                  ),
                  child: TextBox(
                    hintText: "Pin Code",
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    onChanged: (value) =>
                        pharmacyProvider.updatePinCode(value),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 11,
                    horizontal: 32,
                  ),
                  child: TextBox(
                    hintText: "Phone Number",
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) =>
                        pharmacyProvider.updatePhoneNumber(value),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 11,
                    horizontal: 32,
                  ),
                  child: TextBox(
                    hintText: "Home Delivery",
                    keyboardType: TextInputType.name,
                    controller: _deliveryController,
                    readOnly: true,
                    onTap: () => _showHomeDeliveryDialog(context),
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 11,
                    horizontal: 32,
                  ),
                  child: TextBox(
                    hintText: "Operating Hours",
                    readOnly: true,
                    controller: _operatingHoursController,
                    onTap: () => _showOperatingHoursDialog(context),
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16, horizontal: 32.0),
                  child: BottomButton(
                    loadingState: _isLoading,
                    disabledState: false,
                    child: Text("Continue"),
                    onPressed: () =>
                        _onSubmitDetails(pharmacyProvider, context),
                  ),
                ),
                SizedBox(height: 32)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showHomeDeliveryDialog(BuildContext context) {
      final PharmacyProvider pharmacyProvider =
        Provider.of<PharmacyProvider>(context, listen: false);
    return showDialog(
      context: context,
      builder: (context) => MultiSelectDialog(
        title: "Is Home Delivery available?",
        children: AppConstants.HOME_DELIVERY
            .map(
              (e) => MultiSelectDialogItem(
                text: e,
                onPressed: () {
                  pharmacyProvider.updateIsHomeDeliveryAvailable(e);
                  Navigator.pop(context);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  Future<void> _showSelectStateDialog(BuildContext context) {
    final PharmacyProvider pharmacyProvider =
        Provider.of<PharmacyProvider>(context, listen: false);
    return showDialog(
      context: context,
      builder: (context) => MultiSelectDialog(
        title: "Select your state name",
        children: AppConstants.STATES_CITIES_MAP.keys
            .toList()
            .map(
              (e) => MultiSelectDialogItem(
                text: e,
                onPressed: () {
                  pharmacyProvider.updateStateName(e);
                  Navigator.pop(context);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  Future<void> _showOperatingHoursDialog(BuildContext context) {
        final PharmacyProvider pharmacyProvider =
        Provider.of<PharmacyProvider>(context, listen: false);
    return showDialog(
      context: context,
      builder: (context) => MultiSelectDialog(
        title: "Free or Paid",
        children: AppConstants.OPERATING_HOURS
            .map(
              (e) => MultiSelectDialogItem(
                text: e,
                onPressed: () {
                  pharmacyProvider.updateOperatingHours(e);
                  Navigator.pop(context);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  Future<void> _showSelectCityDialog(BuildContext context) {
    final PharmacyProvider pharmacyProvider =
        Provider.of<PharmacyProvider>(context, listen: false);
    return showDialog(
      context: context,
      builder: (context) => MultiSelectDialog(
        title: "Select your city name",
        children: AppConstants
            .STATES_CITIES_MAP[pharmacyProvider.pharmacyModel.state]
            .map(
              (e) => MultiSelectDialogItem(
                text: e,
                onPressed: () {
                  pharmacyProvider.updateCityName(e);
                  Navigator.pop(context);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  
  Future<void> _onSubmitDetails( PharmacyProvider pharmacyProvider, BuildContext context) async {
    if (!pharmacyProvider.validateForm()) {
      setState(() {
        _isLoading = false;
      });
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter all the details.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
    setState(() {
      _isLoading = true;
    });

    await pharmacyProvider.updatePharmacyInfo();
       setState(() {
      _isLoading = false;
    });
    pharmacyProvider.resetProvider();
    Navigator.pushNamedAndRemoveUntil(
        context, '/confirmation_screen', (route) => false);
  }
}
