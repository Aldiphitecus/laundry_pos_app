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

  @override
  Widget build(BuildContext context) {
    final selectedCount = _selectedServices.length;

    return Scaffold(
      appBar: MainAppBar(title: 'Transaksi Baru'),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_selectedServices.isNotEmpty && selectedCount > 0)
              Text(
                '$selectedCount layanan terpilih',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            const SizedBox(height: 5),
            Expanded(
              child: _selectedServices.isEmpty
                  ? const Center(
                      child: Text(
                        'Belum ada layanan yang dipilih, silahkan pilih layanan untuk membuat transaksi.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
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
          : BottomSummaryWidgets(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showServicesModal(context),
        label: const Text(
          'Pilih Layanan',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(Icons.add, color: Colors.white),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
