import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laundry_pos_app/core/constants/app_colors.dart';
import 'package:laundry_pos_app/core/utils/currency_formatter.dart';

class SelectedServiceCard extends StatelessWidget {
  final String serviceName;
  final int servicePrice;
  final String serviceUnit;
  final int qty;
  final ValueChanged<int> onQtyChanged;
  final VoidCallback onRemove;

  const SelectedServiceCard({
    super.key,
    required this.serviceName,
    required this.servicePrice,
    required this.serviceUnit,
    required this.qty,
    required this.onQtyChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final subtotal = servicePrice * qty;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 4, color: AppColors.primary),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              serviceName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${CurrencyFormatter.format(servicePrice)} / $serviceUnit',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                CurrencyFormatter.format(subtotal),
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: onRemove,
                            icon: const Icon(
                              Icons.close_rounded,
                              size: 20,
                              color: Colors.red,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          const SizedBox(height: 12),
                          _QtyControl(qty: qty, onChanged: onQtyChanged),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QtyControl extends StatefulWidget {
  final int qty;
  final ValueChanged<int> onChanged;

  const _QtyControl({required this.qty, required this.onChanged});

  @override
  State<_QtyControl> createState() => _QtyControlState();
}

class _QtyControlState extends State<_QtyControl> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.qty.toString());
  }

  @override
  void didUpdateWidget(covariant _QtyControl oldWidget) {
    super.didUpdateWidget(oldWidget);
    final currentValue = int.tryParse(_controller.text);
    if (widget.qty != currentValue) {
      _controller.text = widget.qty.toString();
      _controller.selection = TextSelection.collapsed(
        offset: _controller.text.length,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTyped(String value) {
    final parsed = int.tryParse(value);
    if (parsed == null || parsed <= 0) {
      return;
    }
    widget.onChanged(parsed);
  }

  void _handleFocusLost(String value) {
    final parsed = int.tryParse(value);
    if (parsed == null || parsed <= 0) {
      _controller.text = widget.qty.toString();
      _controller.selection = TextSelection.collapsed(
        offset: _controller.text.length,
      );
    }
  }

  void _increment() {
    final newQty = widget.qty + 1;
    _controller.text = newQty.toString();
    widget.onChanged(newQty);
  }

  void _decrement() {
    if (widget.qty <= 1) return;
    final newQty = widget.qty - 1;
    _controller.text = newQty.toString();
    widget.onChanged(newQty);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _QtyButton(icon: Icons.remove_rounded, onTap: _decrement),
          SizedBox(
            width: 32,
            child: TextField(
              controller: _controller,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 6),
                border: InputBorder.none,
              ),
              onChanged: _handleTyped,
              onSubmitted: _handleFocusLost,
              onTapOutside: (_) => _handleFocusLost(_controller.text),
            ),
          ),
          _QtyButton(icon: Icons.add_rounded, onTap: _increment),
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 16, color: AppColors.primary),
      ),
    );
  }
}
