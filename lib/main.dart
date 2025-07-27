import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'State and Constituency Selection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SelectionPage(),
    );
  }
}
class SelectionPage extends StatefulWidget {
  const SelectionPage({super.key});

  @override
  _SelectionPageState createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  // Mock data
  final List<Map<String, dynamic>> data = [
    {
      "name": "California",
      "constituencies": [
        {"name": "District 1", "candidate": "Candidate 1A"},
        {"name": "District 2", "candidate": "Candidate 1B"}
      ]
    },
    {
      "name": "New York",
      "constituencies": [
        {"name": "District 3", "candidate": "Candidate 2A"},
        {"name": "District 4", "candidate": "Candidate 2B"}
      ]
    },
    {
      "name": "Texas",
      "constituencies": [
        {"name": "District 5", "candidate": "Candidate 3A"},
        {"name": "District 6", "candidate": "Candidate 3B"}
      ]
    }
  ];

  String? selectedState;
  String? selectedConstituency;
  String candidateName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('State and Constituency Selection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Select State',
                  border: OutlineInputBorder(),
                ),
                value: selectedState,
                items: data.map((state) {
                  return DropdownMenuItem<String>(
                    value: state['name'],
                    child: Text(state['name']),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedState = newValue;
                    selectedConstituency = null; // Reset constituency when state changes
                    candidateName = ''; // Clear candidate name
                  });
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Select Constituency',
                  border: OutlineInputBorder(),
                ),
                value: selectedConstituency,
                items: selectedState != null
                    ? data
                        .firstWhere((state) => state['name'] == selectedState)[
                            'constituencies']
                        .map<DropdownMenuItem<String>>((constituency) {
                        return DropdownMenuItem<String>(
                          value: constituency['name'],
                          child: Text(constituency['name']),
                        );
                      }).toList()
                    : [],
                onChanged: selectedState != null
                    ? (newValue) {
                        setState(() {
                          selectedConstituency = newValue;
                          // Find and display candidate name
                          final selectedConstituencyData = data
                              .firstWhere(
                                  (state) => state['name'] == selectedState)[
                                  'constituencies']
                              .firstWhere(
                                  (constituency) => constituency['name'] == selectedConstituency);
                          candidateName = selectedConstituencyData['candidate'];
                        });
                      }
                    : null,
                disabledHint: const Text('Select a state first'),
              ),
              const SizedBox(height: 20),
              Text(
                'Candidate: $candidateName',
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
