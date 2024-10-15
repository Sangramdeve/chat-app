
import '../../view_imports.dart';


class PhoneNumberPicker extends StatefulWidget {
  @override
  _PhoneNumberPickerState createState() => _PhoneNumberPickerState();
}

class _PhoneNumberPickerState extends State<PhoneNumberPicker> {
  String selectedCountryCode = '+91';
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[900] // Dark theme color
        : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Handle back action
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Fill the form to become our guest',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                // Country code dropdown
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: DropdownButton<String>(
                    value: selectedCountryCode,
                    icon: const Icon(Icons.arrow_drop_down),
                    items: <String>['+1', '+7', '+44', '+91'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCountryCode = newValue!;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                // Phone number input field
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                    autofillHints: [AutofillHints.telephoneNumber],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Center(
              child:  Consumer<LoginState>(
                builder: (context, snapshot, _) {
                  return ElevatedButton(
                    onPressed: () {
                      snapshot.updatePhone(_phoneController.text);
                      SharedPrefServices.savePreference('phone', _phoneController.text );
                      snapshot.storeCred();
                      Navigator.pushReplacementNamed(context, RouteName.homeScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(), backgroundColor: Colors.black,
                      padding: const EdgeInsets.all(20), // Background color
                    ),
                    child: const Icon(Icons.arrow_forward, color: Colors.white),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}