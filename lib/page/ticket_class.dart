import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class TicketPage extends StatefulWidget {
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  final String paymentMethod;
  final String eventTitle;
  final double ticketPrice;

  const TicketPage({
    Key? key,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.paymentMethod,
    required this.eventTitle,
    required this.ticketPrice,
  }) : super(key: key);

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  late String name;
  late String email;
  late String phoneNumber;
  late String address;
  late String paymentMethod;

  @override
  void initState() {
    super.initState();
    name = widget.name;
    email = widget.email;
    phoneNumber = widget.phoneNumber;
    address = widget.address;
    paymentMethod = widget.paymentMethod;
  }

  void _showEditDialog(String title, String currentValue, void Function(String) onSave) {
    final TextEditingController controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit $title'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: title,
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                onSave(controller.text);
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateDatabase(String field, String value) async {
    final url = Uri.parse('https://teknologi22.xyz/project_api/api_tama/event/update_booking.php');
    try {
      final response = await http.post(url, body: {
        'email': email,
        'field': field,
        'value': value,
      });

      print('Sent Data: email=$email, field=$field, value=$value');
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'])),
          );
        } else {
          throw Exception(data['message']);
        }
      } else {
        throw Exception('Gagal terhubung ke server');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }


  Widget _buildEditableRow(IconData icon, String title, String value, String field) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.grey),
              ),
              Text(
                value,
                style: const TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.blue),
          onPressed: () {
            _showEditDialog(title, value, (newValue) {
              setState(() {
                if (field == 'name') name = newValue;
                if (field == 'phone_number') phoneNumber = newValue;
                if (field == 'address') address = newValue;
                if (field == 'payment_method') paymentMethod = newValue;
              });
              _updateDatabase(field, newValue);
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Tiket", style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    widget.eventTitle,
                    style: const TextStyle(fontFamily: 'Poppins', fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                _buildEditableRow(Icons.person, "Nama", name, 'name'),
                const Divider(height: 20, color: Colors.grey),
                _buildEditableRow(Icons.phone, "Nomor HP", phoneNumber, 'phone_number'),
                const Divider(height: 20, color: Colors.grey),
                _buildEditableRow(Icons.home, "Alamat", address, 'address'),
                const Divider(height: 20, color: Colors.grey),
                _buildEditableRow(Icons.payment, "Metode Pembayaran", paymentMethod, 'payment_method'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
