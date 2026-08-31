import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laundry_pos_app/core/constants/app_colors.dart';
import 'package:laundry_pos_app/core/utils/currency_formatter.dart';
import 'package:laundry_pos_app/core/utils/qty_formatter.dart';

class SelectedServiceCard extends StatelessWidget {
  final String serviceName;
  final int servicePrice;
  final String serviceUnit;
  final double qty;
  final ValueChanged<double> onQtyChanged;
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
    final subtotal = (servicePrice * qty).round();

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
                          _QtyControl(
                            qty: qty,
                            unit: serviceUnit,
                            onChanged: onQtyChanged,
                          ),
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
  final double qty;
  final String unit;
  final ValueChanged<double> onChanged;

  const _QtyControl({
    required this.qty,
    required this.unit,
    required this.onChanged,
  });

  @override
  State<_QtyControl> createState() => _QtyControlState();
}

class _QtyControlState extends State<_QtyControl> {
  late final TextEditingController _controller;

  bool get _isDecimalUnit => widget.unit.toLowerCase() == 'kg';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _formatQty(widget.qty));
  }

  @override
  void didUpdateWidget(covariant _QtyControl oldWidget) {
    super.didUpdateWidget(oldWidget);
    final currentValue = double.tryParse(_controller.text);
    if (widget.qty != currentValue) {
      _controller.text = _formatQty(widget.qty);
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

  String _formatQty(double value) => QtyFormatter.format(value, widget.unit);

  void _handleTyped(String value) {
    final parsed = double.tryParse(value);
    if (parsed == null || parsed <= 0) {
      return;
    }
    widget.onChanged(parsed);
  }

  void _handleFocusLost(String value) {
    final parsed = double.tryParse(value);
    if (parsed == null || parsed <= 0) {
      _controller.text = _formatQty(widget.qty);
    } else {
      _controller.text = _formatQty(parsed);
    }
    _controller.selection = TextSelection.collapsed(
      offset: _controller.text.length,
    );
  }

  void _increment() {
    final step = _isDecimalUnit ? 0.5 : 1.0;
    final newQty = widget.qty + step;
    _controller.text = _formatQty(newQty);
    widget.onChanged(newQty);
  }

  void _decrement() {
    final step = _isDecimalUnit ? 0.5 : 1.0;
    if (widget.qty <= step) return; // minimal qty tidak turun ke 0 lewat tombol
    final newQty = widget.qty - step;
    _controller.text = _formatQty(newQty);
    widget.onChanged(newQty);
  }

  @override
  Widget build(BuildContext context) {
    final inputFormatters = _isDecimalUnit
        ? [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}'))]
        : [FilteringTextInputFormatter.digitsOnly];

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
            width: _isDecimalUnit ? 52 : 32,
            child: TextField(
              controller: _controller,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.numberWithOptions(
                decimal: _isDecimalUnit,
              ),
              inputFormatters: inputFormatters,
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
