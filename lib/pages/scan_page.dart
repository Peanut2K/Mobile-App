import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String? _scanResult;

  @override
  Widget build(BuildContext context) {
    const Color darkGreen = Color(0xFF445D44);
    const Color creamColor = Color(0xFFF2D9BB);
    const Color cardBgColor = Color(0xFFFFEBCD);

    return Scaffold(
      body: Stack(
        children: [
          Container(color: darkGreen),

          Positioned(
            top: -100,
            right: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: const BoxDecoration(
                color: Colors.black45,
                shape: BoxShape.circle,
              ),
            ),
          ),

          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: const LinearGradient(
                        colors: [creamColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Stack(
                        children: [
                          QRView(key: qrKey, onQRViewCreated: _onQRViewCreated),

                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              color: Colors.black54,
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                _scanResult == null
                                    ? 'Scanning...'
                                    : 'Result: $_scanResult',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  const Text(
                    'The QR code will be automatically detected\nwhen you position it between the guide lines',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),

                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardBgColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Plastic bottle ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Icon(Icons.autorenew, color: Colors.green[700]),
                          ],
                        ),
                        const SizedBox(height: 12),

                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              InfoItem(label: 'saved Carbon', value: '6g'),
                              InfoItem(label: 'material', value: 'plastic'),
                              InfoItem(label: 'points', value: '3'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/point');
                            },
                            child: const Text('DROP OFF !'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        _scanResult = scanData.code;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class InfoItem extends StatelessWidget {
  final String label;
  final String value;
  const InfoItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
