import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import'package:student1/digital_locker_model.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  List<Document>? documents;
  bool isLoading = true;
  bool useMockData = true; // Change to true to force dummy data (e.g., in dev mode)

  @override
  void initState() {
    super.initState();
    fetchDocuments();
  }

  Future<void> fetchDocuments() async {
    try {
      if (useMockData) {
        // Simulated API delay + mock data
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          documents = [
            Document(
              name: "Class X Mark sheet",
              description: "Demo Education Board",
              logoUrl: null,
            ),
            Document(
              name: "Leaving Certificate",
              description: "Mock Board",
              logoUrl: null,
            ),
          ];
          isLoading = false;
        });
      } else {
        // Actual API call
        final response = await http.get(Uri.parse('https://yourapi.com/api/documents'));

        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          final List<Document> fetchedDocuments = data.map((json) => Document.fromJson(json)).toList();
          setState(() {
            documents = fetchedDocuments;
            isLoading = false;
          });
        } else {
          throw Exception('Failed to load documents');
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        documents = [
          Document(name: 'NULL', description: 'NULL', logoUrl: null),
          Document(name: 'NULL', description: 'NULL', logoUrl: null),
        ];
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error loading documents. Showing fallback data.'),
      ));
    }
  }

  Widget buildDocumentCard(Document doc) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.shade100),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: doc.logoUrl != null
                ? Image.network(
              doc.logoUrl!,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.image_not_supported),
            )
                : const Icon(Icons.school, size: 50),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doc.name ?? 'NULL',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doc.description ?? 'NULL',
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          const Icon(Icons.more_vert),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'Digital Locker',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: documents == null || documents!.isEmpty
            ? const Center(child: Text("No documents available"))
            : Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "ISSUED DOCUMENTS",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: documents!.length,
                  itemBuilder: (context, index) {
                    final doc = documents![index];
                    return buildDocumentCard(doc);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
