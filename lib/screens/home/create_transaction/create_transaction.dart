import 'package:flutter/material.dart';
import 'package:laundry_pos_app/core/constants/app_colors.dart';
import 'package:laundry_pos_app/core/widgets/main_app_bar.dart';
import 'package:laundry_pos_app/models/service_selected_model.dart';
import 'package:laundry_pos_app/screens/home/create_transaction/widgets/bottom_summary_widgets.dart';
import 'package:laundry_pos_app/screens/home/create_transaction/widgets/selected_service_card.dart';
import 'package:laundry_pos_app/screens/home/create_transaction/widgets/services_selection.dart';

class CreateTransaction extends StatefulWidget {
  const CreateTransaction({super.key});

  @override
  State<CreateTransaction> createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  List<ServiceSelectedModel> _selectedServices = [];
  final _customerNameController = TextEditingController();

  @override
  void dispose() {
    _customerNameController.dispose();
    super.dispose();
  }

  void _showServicesModal(BuildContext context) async {
    final result = await showModalBottomSheet<List<ServiceSelectedModel>>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) =>
          ServicesSelection(initialSelected: _selectedServices),
    );
    if (result != null) {
      setState(() {
        _selectedServices = result;
      });
    }
  }

  void _createTransaction() async {
    final customerName = _customerNameController.text.trim();
    if (customerName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama pelanggan wajib diisi.')),
      );
      return;
    }
    if (_selectedServices.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Minimal pilih 1 layanan.')));
      return;
    }
    debugPrint('Nama pelanggan: $customerName');
    debugPrint('Jumlah layanan: ${_selectedServices.length}');
  }

  @override
  Widget build(BuildContext context) {
    final selectedCount = _selectedServices.length;

    return Scaffold(
      appBar: const MainAppBar(title: 'Transaksi Baru'),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Nama Pelanggan',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _customerNameController,
                textCapitalization: TextCapitalization.words,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: 'Masukkan nama pelanggan',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontWeight: FontWeight.normal,
                  ),
                  prefixIcon: const Icon(
                    Icons.person_outline_rounded,
                    color: AppColors.primary,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_selectedServices.isNotEmpty)
              Text(
                '$selectedCount layanan terpilih',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            const SizedBox(height: 5),
            Expanded(
              child: _selectedServices.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          'Belum ada layanan yang dipilih, silahkan pilih layanan untuk membuat transaksi.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 73),
                      itemCount: _selectedServices.length,
                      itemBuilder: (context, index) {
                        final item = _selectedServices[index];
                        return SelectedServiceCard(
                          serviceName: item.name,
                          servicePrice: item.price,
                          serviceUnit: item.unit,
                          qty: item.qty,
                          onQtyChanged: (newQty) {
                            setState(() {
                              final index = _selectedServices.indexWhere(
                                (s) => s.id == item.id,
                              );
                              if (index == -1) return;
                              _selectedServices[index] =
                                  _selectedServices[index].copyWith(
                                    qty: newQty,
                                  );
                            });
                          },
                          onRemove: () {
                            setState(() {
                              _selectedServices.removeWhere(
                                (s) => s.id == item.id,
                              );
                            });
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _selectedServices.isEmpty
          ? null
          : BottomSummaryWidgets(
              services: _selectedServices,
              onCreateTransaction: _createTransaction,
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showServicesModal(context),
        label: const Text(
          'Pilih Layanan',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(Icons.add, color: Colors.white),
        backgroundColor: AppColors.tertiary,
      ),
    );
  }
}
