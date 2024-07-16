import 'package:ecommerce_app_api/presentation/screens/order_screen/widgets/textfield.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 249, 249),
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 90,
        backgroundColor: const Color.fromARGB(255, 221, 249, 249),
        title: const Text(
          'Shipping Information',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const TextFieldWidget(
                    label: "Address",
                    keyboardType: TextInputType.streetAddress),
                const SizedBox(
                  height: 12,
                ),
                const TextFieldWidget(
                    label: "City", keyboardType: TextInputType.streetAddress),
                const SizedBox(
                  height: 12,
                ),
                const TextFieldWidget(
                    label: "State", keyboardType: TextInputType.streetAddress),
                const SizedBox(
                  height: 12,
                ),
                const TextFieldWidget(
                    label: "Email", keyboardType: TextInputType.emailAddress),
                const SizedBox(
                  height: 12,
                ),
                const TextFieldWidget(
                    label: "Contact", keyboardType: TextInputType.phone),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  child: Container(
                    width: 300,
                    height: 75,
                    decoration: BoxDecoration(
                        // Return the appropriate color based on carted status
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(25)),
                    child: const Center(
                      child: Text(
                        "Place Order",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Submitting form')),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
