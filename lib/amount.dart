import 'package:flutter/material.dart';

class AmountPage extends StatefulWidget {
  const AmountPage({super.key});

  @override
  State<AmountPage> createState() => _AmountPageState();
}

class _AmountPageState extends State<AmountPage> {
  final TextEditingController _amountController = TextEditingController();
  String _selectedAccount = "BE U QSA-I · RM30.00";

  void _appendNumber(String number) {
    setState(() {
      _amountController.text += number;
    });
  }

  void _removeNumber() {
    if (_amountController.text.isNotEmpty) {
      setState(() {
        _amountController.text = _amountController.text.substring(
          0,
          _amountController.text.length - 1,
        );
      });
    }
  }

  void _setQuickAmount(String amount) {
    setState(() {
      _amountController.text = amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF9F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Transfer to Nest",
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),

      body: Column(
        children: [
          const SizedBox(height: 20),

          const Text(
            "Enter amount",
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 16),

          // Nest icon + name + account
          Column(
            children: const [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.pinkAccent,
                child: CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("lib/assets/images/travel.png"),
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Pangkor",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text("1234567890", style: TextStyle(color: Colors.black54)),
            ],
          ),

          const SizedBox(height: 20),

          // Amount TextField
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: TextField(
              controller: _amountController,
              readOnly: true,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                border: InputBorder.none,
                prefixText: "RM",
                prefixStyle: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Quick Amount Chips
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _quickAmountChip("20.00"),
              const SizedBox(width: 8),
              _quickAmountChip("50.00"),
              const SizedBox(width: 8),
              _quickAmountChip("100.00"),
            ],
          ),

          const Spacer(),

          // --- Pay From row + Next button ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                // Dropdown button (Pay from)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Pay from",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        value: _selectedAccount,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                          filled: true,
                          fillColor: Colors.pink,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        dropdownColor: Colors.white,
                        iconEnabledColor: Colors.white,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: "BE U QSA-I · RM30.00",
                            child: Text(
                              "BE U QSA-I · RM30.00",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: "Be U Al-Awfar · RM120.00",
                            child: Text(
                              "Be U Al-Awfar · RM120.00",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedAccount = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 16),

                // NEXT button
                SizedBox(
                  height: 56, // ✅ same height as dropdown
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.pink,
                      side: const BorderSide(color: Colors.pink, width: 1.8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50), // ✅ pill shape
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                    ),
                    icon: const Icon(Icons.arrow_forward, size: 20),
                    label: const Text(
                      "NEXT",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      debugPrint(
                        "Next pressed with account $_selectedAccount and amount RM${_amountController.text}",
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Custom Keypad
          _buildKeypad(),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _quickAmountChip(String amount) {
    return GestureDetector(
      onTap: () => _setQuickAmount(amount),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text("RM $amount", style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildKeypad() {
    final buttons = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['0', '.', '←'],
    ];

    return Column(
      children: buttons.map((row) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: row.map((text) {
              return _keyButton(text);
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  Widget _keyButton(String text) {
    return InkWell(
      onTap: () {
        if (text == '←') {
          _removeNumber();
        } else {
          _appendNumber(text);
        }
      },
      child: Container(
        width: 80,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
