import 'dart:convert';
import 'package:event/page/ticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:event/page/ticket_class.dart';


class PemesananPage extends StatefulWidget {
  final String eventTitle; // Nama event
  final double ticketPrice; // Harga tiket

  const PemesananPage({
    Key? key,
    required this.eventTitle,
    required this.ticketPrice,
  }) : super(key: key);

  @override
  _PemesananPageState createState() => _PemesananPageState();
}

class _PemesananPageState extends State<PemesananPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmEmailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  bool _agreeToTerms = false;
  String? _selectedPaymentMethod;

  final NumberFormat _currencyFormat =
  NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pemesanan Tiket"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                "Event: ${widget.eventTitle}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "Harga Tiket: ${_currencyFormat.format(widget.ticketPrice)}",
                style: const TextStyle(fontSize: 16, color: Colors.orange),
              ),
              const SizedBox(height: 16),
              _buildTextField(_nameController, "Nama", "Nama wajib diisi"),
              const SizedBox(height: 16),
              _buildTextField(_emailController, "Email", "Email wajib diisi",
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 16),
              _buildTextField(
                  _confirmEmailController, "Konfirmasi Email", "Email tidak cocok",
                  validator: (value) {
                    if (value != _emailController.text) {
                      return "Email tidak cocok";
                    }
                    return null;
                  }),
              const SizedBox(height: 16),
              _buildTextField(_addressController, "Alamat", "Alamat wajib diisi",
                  maxLines: 3),
              const SizedBox(height: 16),
              _buildTextField(_phoneNumberController, "Nomor HP", "Nomor HP wajib diisi",
                  keyboardType: TextInputType.phone),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedPaymentMethod,
                items: const [
                  DropdownMenuItem(
                    value: "Bayar di Tempat",
                    child: Text("Bayar di Tempat"),
                  ),
                  DropdownMenuItem(
                    value: "Bank Transfer",
                    child: Text("Bank Transfer"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Metode Pembayaran",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Pilih metode pembayaran";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreeToTerms = value ?? false;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text("Saya setuju dengan syarat & ketentuan."),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _agreeToTerms ? () => _submitForm(context) : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Pesan Tiket"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final url = Uri.parse("https://teknologi22.xyz/project_api/api_tama/event/save_booking.php");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'name': _nameController.text,
          'email': _emailController.text,
          'phone_number': _phoneNumberController.text,
          'address': _addressController.text,
          'payment_method': _selectedPaymentMethod,
          'event_title': widget.eventTitle,
          'ticket_price': widget.ticketPrice,
        }),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['success']) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TicketPage(
                name: _nameController.text,
                email: _emailController.text,
                phoneNumber: _phoneNumberController.text,
                address: _addressController.text,
                paymentMethod: _selectedPaymentMethod!,
                eventTitle: widget.eventTitle,
                ticketPrice: widget.ticketPrice,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result['message'])),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gagal menghubungi server")),
        );
      }
    }
  }

  Widget _buildTextField(TextEditingController controller, String labelText, String errorText,
      {TextInputType? keyboardType, int maxLines = 1, String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator ??
              (value) {
            if (value == null || value.isEmpty) {
              return errorText;
            }
            return null;
          },
    );
  }
}
