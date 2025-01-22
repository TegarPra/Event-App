import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'ticket_class.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  late Stream<List<Map<String, dynamic>>> bookingsStream;
  final Map<String, bool> selectedTickets = {};

  // Fungsi untuk mendapatkan stream data dari server
  Stream<List<Map<String, dynamic>>> fetchBookingsStream() async* {
    while (true) {
      final response = await http.get(Uri.parse('https://teknologi22.xyz/project_api/api_tama/event/fetch_booking.php'));
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        yield data.map((item) => item as Map<String, dynamic>).toList();
      } else {
        yield [];
      }
      await Future.delayed(const Duration(seconds: 5)); // Interval polling (5 detik)
    }
  }

  @override
  void initState() {
    super.initState();
    bookingsStream = fetchBookingsStream();
  }

  // Fungsi untuk menghapus tiket yang dipilih
  Future<void> deleteSelectedTickets() async {
    final selectedEmails = selectedTickets.keys
        .where((key) => selectedTickets[key] == true) // Filter selected tickets
        .toList();

    // If no tickets are selected, return early
    if (selectedEmails.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No tickets selected for deletion')),
      );
      return;
    }

    // Initialize a variable to keep track of success/failure
    bool isSuccess = true;

    for (String email in selectedEmails) {
      // Make the POST request to delete the booking by email
      final response = await http.post(
        Uri.parse('https://teknologi22.xyz/project_api/api_tama/event/delete_booking.php'),
        body: {'email': email}, // Sending email as the body parameter
      );

      // If the response status is not 200, mark as failure and show a message
      if (response.statusCode != 200) {
        isSuccess = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete ticket for email: $email')),
        );
      }
    }

    // Provide feedback to the user about the operation status
    if (isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selected tickets successfully deleted')),
      );
    }

    // Clear the selected tickets after the operation
    setState(() {
      selectedTickets.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket'),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: bookingsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No bookings found",
                style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
              ),
            );
          }

          final bookings = snapshot.data!;
          return Stack(
            children: [
              ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  final booking = bookings[index];
                  final email = booking['email'];

                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: Checkbox(
                        value: selectedTickets[email] ?? false,
                        onChanged: (value) {
                          setState(() {
                            selectedTickets[email] = value ?? false;
                          });
                        },
                      ),
                      title: Text(
                        booking['event_title'],
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nama: ${booking['name']}",
                              style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
                            ),
                            Text(
                              "Email: $email",
                              style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
                            ),
                            Text(
                              "Harga Tiket: Rp ${booking['ticket_price']}",
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward, color: Colors.blue.shade700),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TicketPage(
                              name: booking['name'],
                              email: email,
                              phoneNumber: booking['phone_number'],
                              address: booking['address'],
                              paymentMethod: booking['payment_method'],
                              eventTitle: booking['event_title'],
                              ticketPrice: double.tryParse(booking['ticket_price'].toString()) ?? 0.0,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: FloatingActionButton(
                  onPressed: selectedTickets.values.contains(true)
                      ? deleteSelectedTickets
                      : null,
                  backgroundColor: selectedTickets.values.contains(true) ? Colors.red : Colors.grey,
                  child: const Icon(Icons.delete, color: Colors.white),
                  tooltip: 'Hapus Tiket yang Dipilih',
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
