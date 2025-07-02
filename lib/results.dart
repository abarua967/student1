import 'package:flutter/material.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  final List<String> sessions = ['2020-21', '2021-22', '2022-23', '2023-24'];
  String? selectedSession;
  bool showResults = false;

  final Map<String, List<String>> dummyResults = {
    '2020-21': ['Mid Term', 'Final Exam'],
    '2021-22': ['Quarterly', 'Half Yearly', 'Final Exam'],
    '2022-23': ['Unit Test 1', 'Unit Test 2', 'Final Exam'],
    '2023-24': ['Semester 1', 'Semester 2'],
  };

  @override
  Widget build(BuildContext context) {
    final List<String> results = dummyResults[selectedSession] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Results',style: TextStyle(fontSize: 20,color: Colors.white),),
        leading: const BackButton(color: Colors.white,),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              hint: const Text("Select Session"),
              value: selectedSession,
              isExpanded: true,
              items: sessions.map((session) {
                return DropdownMenuItem(
                  value: session,
                  child: Text(session),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSession = value;
                  showResults = false;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: selectedSession == null
                  ? null
                  : () {
                setState(() {
                  showResults = true;
                });
              },
              child: const Text("Show Results"),
            ),
            const SizedBox(height: 20),
            if (showResults)
              Expanded(
                child: results.isEmpty
                    ? const Center(child: Text("No results available."))
                    : ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final result = results[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(result),
                        subtitle: Text("Session: $selectedSession"),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ResultDetailPage(
                                session: selectedSession!,
                                resultName: result,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ResultDetailPage extends StatelessWidget {
  final String session;
  final String resultName;

  const ResultDetailPage({
    super.key,
    required this.session,
    required this.resultName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$resultName - $session'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          'Details of $resultName\nfor session $session',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
//
// class ResultsPage extends StatefulWidget {
//   const ResultsPage({super.key});
//
//   @override
//   State<ResultsPage> createState() => _ResultsPageState();
// }
//
// class _ResultsPageState extends State<ResultsPage> {
//   List<String> sessions = ['2021-22', '2022-23', '2023-24'];
//   String? selectedSession;
//   bool showResults = false;
//
//   // Example dynamic result data (can be replaced with API data)
//   Map<String, List<String>> resultsBySession = {
//     '2021-22': ['Term 1', 'Term 2'],
//     '2022-23': ['Term 1', 'Term 2', 'Term 3'],
//     '2023-24': ['Term 1'],
//   };
//
//   @override
//   Widget build(BuildContext context) {
//     final results = resultsBySession[selectedSession] ?? [];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Results"),
//         centerTitle: true,
//         backgroundColor: Colors.blue,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             DropdownButton<String>(
//               hint: const Text("Select Session"),
//               value: selectedSession,
//               isExpanded: true,
//               items: sessions.map((session) {
//                 return DropdownMenuItem<String>(
//                   value: session,
//                   child: Text(session),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedSession = value;
//                   showResults = false; // reset previous results
//                 });
//               },
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: selectedSession == null
//                   ? null
//                   : () {
//                 setState(() {
//                   showResults = true;
//                 });
//               },
//               child: const Text("Show Results"),
//             ),
//             const SizedBox(height: 20),
//             if (showResults && results.isNotEmpty)
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: results.length,
//                   itemBuilder: (context, index) {
//                     final result = results[index];
//                     return Card(
//                       child: ListTile(
//                         title: Text(result),
//                         trailing: const Icon(Icons.arrow_forward),
//                         onTap: () {
//                           // Navigate to result detail page
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => ResultDetailPage(
//                                 session: selectedSession!,
//                                 resultName: result,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             if (showResults && results.isEmpty)
//               const Text("No results found for this session."),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ResultDetailPage extends StatelessWidget {
//   final String session;
//   final String resultName;
//
//   const ResultDetailPage({
//     super.key,
//     required this.session,
//     required this.resultName,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('$resultName - $session'),
//         backgroundColor: Colors.blue,
//       ),
//       body: Center(
//         child: Text("Details for $resultName of session $session"),
//       ),
//     );
//   }
// }
// 🔌 API Integration (optional)
// Later, replace the resultsBySession map with an API call after session selection:
//
// Future<void> fetchResults(String session) async {
// final response = await http.get(Uri.parse('https://your-api.com/results/$session'));
// if (response.statusCode == 200) {
// final data = json.decode(response.body);
// setState(() {
// resultList = List<String>.from(data);
// showResults = true;
// });
// }
//}