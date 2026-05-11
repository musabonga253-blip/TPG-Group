/*
 * Student Numbers: 224022456, 224111760, 223089499, 223082118, 224107046, 223086046, 220025661, 224090026
 * Student Names  : Musa Bonga, Sibusiso Lukhele, Noluthando Ndebele, Nombulelo Menyuka, Siphosethu Mbasa, Luyanda P Mtungwa, Tiarina Jean Iye, Kamohelo Tlotliso Junior Phatsoane
 * Group          : GROUP_H1
 * Subject        : Technical Programming III (TPG316C)
 */
 
import 'package:flutter/material.dart';
 
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
 
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List applications = [
    {
      'student_number': '220123456',
      'module_one_name': 'TPG316C',
      'status': 'Pending',
    },
    {
      'student_number': '220123456',
      'module_one_name': 'SOD316C',
      'status': 'Approved',
    },
  ];

  bool isLoading = false;

  void navigateToApplicationForm() {
    Navigator.pushNamed(context, '/applicationForm');
  }

  void navigateToManageApplication(Map application) {
    Navigator.pushNamed(
      context,
      '/applicationDetails',
      arguments: application,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Home'),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: navigateToApplicationForm,
        child: const Icon(Icons.add),
      ),

      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : applications.isEmpty
              ? const Center(
                  child: Text(
                    'No Applications Submitted',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount: applications.length,
                  itemBuilder: (context, index) {

                    final application = applications[index];

                    return Card(
                      margin: const EdgeInsets.all(10),
                      elevation: 4,

                      child: ListTile(
                        leading: const Icon(Icons.school),

                        title: Text(
                          application['module_one_name'],
                        ),

                        subtitle: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [
                            Text(
                              'Student Number: '
                              '${application['student_number']}',
                            ),

                            Text(
                              'Status: '
                              '${application['status']}',
                            ),
                          ],
                        ),

                        trailing:
                            const Icon(Icons.arrow_forward_ios),

                        onTap: () {
                          navigateToManageApplication(
                            application,
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
 