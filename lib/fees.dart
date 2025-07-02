import 'package:flutter/material.dart';

class FeeDetailsPage extends StatefulWidget {
  const FeeDetailsPage({super.key});
  @override
  State<FeeDetailsPage> createState() => _FeeDetailsPageState();
}

class _FeeDetailsPageState extends State<FeeDetailsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<FeeData> schoolFees = [
    FeeData(
      month: "January",
      date: "06 May",
      amount: 16600,
      isPaid: true,
      details: {
        "Total Fee": 14500,
        "Extra Fee": 2000,
        "Late Charges": 600,
        "Discount [20%]": -500,
      },
    ),
    FeeData(month: "December", date: "06 May", amount: 14500, isPaid: true, details: {}),
    FeeData(month: "November", date: "06 May", amount: 16500, isPaid: true, details: {}),
  ];

  final List<FeeData> examFees = [
    FeeData(month: "Term 1", date: "02 Apr", amount: 2000, isPaid: true, details: {}),
    FeeData(month: "Term 2", date: "12 Oct", amount: 2100, isPaid: false, details: {}),
  ];

  final List<FeeData> activityFees = [
    FeeData(month: "Sports Day", date: "15 Aug", amount: 500, isPaid: true, details: {}),
    FeeData(month: "Art Fest", date: "22 Dec", amount: 800, isPaid: true, details: {}),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fees',style:TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[800],
        leading: const BackButton(color: Colors.white,),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF5F8FE),
      body: SafeArea(
        child: Column(
          children: [
            //const _Header(),
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                indicatorColor: Colors.blue,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: "School Fee"),
                  Tab(text: "Exam Fee"),
                  Tab(text: "Activity Fee"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  FeeList(items: schoolFees),
                  FeeList(items: examFees),
                  FeeList(items: activityFees),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class FeeData {
  final String month;
  final String date;
  final double amount;
  final bool isPaid;
  final Map<String, double> details;
  bool isExpanded;

  FeeData({
    required this.month,
    required this.date,
    required this.amount,
    required this.isPaid,
    required this.details,
    this.isExpanded = false,
  });
}

class FeeList extends StatefulWidget {
  final List<FeeData> items;
  const FeeList({super.key, required this.items});

  @override
  State<FeeList> createState() => _FeeListState();
}

class _FeeListState extends State<FeeList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.items[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: const Color(0xFFE5F2FF),
              child: Column(
                mainAxisSize: MainAxisSize.min, // important!
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        color: const Color(0xFFE5F2FF),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Fee for ${item.month}",
                                        style: const TextStyle(fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    Text("₹ ${item.amount.toStringAsFixed(0)}"),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: item.isPaid ? Colors.green : Colors.orange,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  item.isPaid ? "Paid" : "Unpaid",
                                  style: const TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(item.date, style: const TextStyle(fontSize: 10)),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        item.isExpanded = !item.isExpanded;
                                      });
                                    },
                                    child: Icon(
                                      item.isExpanded
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      color: Colors.blue,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  if (item.isExpanded && item.details.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                      child: Column(
                        children: [
                          for (var entry in item.details.entries)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(entry.key, style: const TextStyle(fontSize: 14)),
                                Text("₹ ${entry.value.toStringAsFixed(0)}"),
                              ],
                            ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Paid Final", style: TextStyle(fontWeight: FontWeight.bold)),
                              Text("₹ ${item.amount.toStringAsFixed(0)}", style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
