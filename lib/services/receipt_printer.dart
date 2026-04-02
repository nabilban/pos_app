import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../utils/currency_util.dart';
import '../data/models/cart_item.dart';
import '../data/models/auth_response.dart';
import '../data/models/sale.dart';

class ReceiptPrinter {
  /// Generates a thermal-style PDF receipt and opens the native print dialog.
  static Future<void> printReceipt({
    required List<CartItem> items,
    required double total,
    required double subtotal,
    required double discount,
    required String paymentMethod,
    required String buyerName,
    required String dateStr,
    required User user,
    String? invoiceNumber,
  }) async {
    final doc = pw.Document();

    // Use a monospace font that resembles a thermal printer
    final ttf = await PdfGoogleFonts.courierPrimeRegular();
    final ttfBold = await PdfGoogleFonts.courierPrimeBold();

    final outletName = user.outlet?.name ?? 'FIESTO POS';
    final outletAddress = user.outlet?.address ?? '';
    final outletPhone = user.outlet?.phone ?? '';

    // Thermal receipt width is typically 58mm or 80mm.
    // We use A4 with narrow content to preview, then actual printers
    // handle paper size. Layout matches screenshot exactly.
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context ctx) {
          final now = DateTime.now();
          final headerDate =
              '${now.month}/${now.day}/${now.year}, ${now.hour.toString().padLeft(2, '0')}.${now.minute.toString().padLeft(2, '0')}';

          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // ── Top meta row: date left, title right ──
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    headerDate,
                    style: pw.TextStyle(font: ttf, fontSize: 8),
                  ),
                  pw.Text(
                    'Struk Pembayaran',
                    style: pw.TextStyle(font: ttf, fontSize: 8),
                  ),
                ],
              ),
              if (invoiceNumber != null)
                pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 2),
                  child: pw.Text(
                    'ID: $invoiceNumber',
                    style: pw.TextStyle(font: ttfBold, fontSize: 9),
                  ),
                ),
              pw.SizedBox(height: 12),

              // ── Restaurant name (bold, centered) ──
              pw.Center(
                child: pw.Text(
                  outletName,
                  style: pw.TextStyle(
                    font: ttfBold,
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 4),

              // ── Address ──
              pw.Center(
                child: pw.Text(
                  outletAddress,
                  style: pw.TextStyle(font: ttf, fontSize: 10),
                ),
              ),
              pw.SizedBox(height: 2),

              // ── Phone ──
              pw.Center(
                child: pw.Text(
                  outletPhone,
                  style: pw.TextStyle(font: ttf, fontSize: 10),
                ),
              ),
              pw.SizedBox(height: 8),

              // ── Divider ──
              pw.Divider(thickness: 0.5, color: PdfColors.black),
              pw.SizedBox(height: 8),

              // ── Itemized list ──
              ...items.map((item) {
                final subtotalItem = CurrencyUtil.format(item.subtotal);
                final unitPrice = CurrencyUtil.format(item.subtotal / item.quantity);
                
                return pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 6),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Expanded(
                            child: pw.Text(
                              item.product.name,
                              style: pw.TextStyle(font: ttfBold, fontSize: 10),
                            ),
                          ),
                          pw.Text(
                            subtotalItem,
                            style: pw.TextStyle(font: ttfBold, fontSize: 10),
                          ),
                        ],
                      ),
                      if (item.selectedOptions.isNotEmpty)
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(left: 4),
                          child: pw.Text(
                            '(${item.selectedOptions.map((o) => o.name).join(', ')})',
                            style: pw.TextStyle(font: ttf, fontSize: 8),
                          ),
                        ),
                      pw.Text(
                        '${item.quantity} x $unitPrice',
                        style: pw.TextStyle(font: ttf, fontSize: 9),
                      ),
                    ],
                  ),
                );
              }),

              pw.SizedBox(height: 8),

              // ── Totals (right-aligned, bold) ──
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    if (discount > 0) ...[
                      pw.Text(
                        'Subtotal: ${CurrencyUtil.format(subtotal)}',
                        style: pw.TextStyle(font: ttf, fontSize: 10),
                      ),
                      pw.Text(
                        'Diskon: -${CurrencyUtil.format(discount)}',
                        style: pw.TextStyle(font: ttf, fontSize: 10),
                      ),
                    ],
                    pw.Text(
                      'Total: ${CurrencyUtil.format(total)}',
                      style: pw.TextStyle(
                        font: ttfBold,
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              pw.SizedBox(height: 8),

              // ── Payment method ──
              pw.Text(
                'Metode: $paymentMethod',
                style: pw.TextStyle(font: ttf, fontSize: 10),
              ),
              pw.Text(
                'Pembeli: $buyerName',
                style: pw.TextStyle(font: ttf, fontSize: 10),
              ),

              pw.SizedBox(height: 4),

              // ── Cashier name ──
              pw.Text(
                'Kasir: ${user.name}',
                style: pw.TextStyle(font: ttf, fontSize: 10),
              ),

              pw.SizedBox(height: 12),

              // ── Footer ──
              pw.Center(
                child: pw.Text(
                  'Terima kasih telah berbelanja!',
                  style: pw.TextStyle(font: ttf, fontSize: 10),
                ),
              ),
              pw.SizedBox(height: 2),
              pw.Center(
                child: pw.Text(
                  dateStr,
                  style: pw.TextStyle(font: ttf, fontSize: 9),
                ),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (_) async => doc.save(),
      name: 'Struk ${invoiceNumber ?? "Pembayaran"}',
    );
  }

  /// Prints a receipt from a Sale record (History)
  static Future<void> printSale({
    required Sale sale,
    required User user,
  }) async {
    final doc = pw.Document();
    final ttf = await PdfGoogleFonts.courierPrimeRegular();
    final ttfBold = await PdfGoogleFonts.courierPrimeBold();

    final outletName = user.outlet?.name ?? 'FIESTO POS';
    final outletAddress = user.outlet?.address ?? '';
    final outletPhone = user.outlet?.phone ?? '';

    final created = DateTime.tryParse(sale.createdAt) ?? DateTime.now();
    final dateStr =
        '${created.day.toString().padLeft(2, '0')}/${created.month.toString().padLeft(2, '0')}/${created.year}  ${created.hour.toString().padLeft(2, '0')}:${created.minute.toString().padLeft(2, '0')}';

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context ctx) {
          final now = DateTime.now();
          final headerDate =
              '${now.month}/${now.day}/${now.year}, ${now.hour.toString().padLeft(2, '0')}.${now.minute.toString().padLeft(2, '0')}';

          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(headerDate, style: pw.TextStyle(font: ttf, fontSize: 8)),
                  pw.Text('Struk Pembayaran (Salinan)',
                      style: pw.TextStyle(font: ttf, fontSize: 8)),
                ],
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 2),
                child: pw.Text(
                  'ID: ${sale.invoiceNumber}',
                  style: pw.TextStyle(font: ttfBold, fontSize: 9),
                ),
              ),
              pw.SizedBox(height: 12),
              pw.Center(
                  child: pw.Text(outletName,
                      style: pw.TextStyle(font: ttfBold, fontSize: 16))),
              pw.SizedBox(height: 4),
              pw.Center(
                  child: pw.Text(outletAddress,
                      style: pw.TextStyle(font: ttf, fontSize: 10))),
              pw.SizedBox(height: 2),
              pw.Center(
                  child: pw.Text(outletPhone,
                      style: pw.TextStyle(font: ttf, fontSize: 10))),
              pw.SizedBox(height: 8),
              pw.Divider(thickness: 0.5, color: PdfColors.black),
              pw.SizedBox(height: 8),

              // Itemized list
              ...sale.items.map((item) {
                final subtotalItem = CurrencyUtil.format(item.subtotal);
                final unitPrice =
                    CurrencyUtil.format(item.subtotal / item.quantity);
                final productName = item.product?.name ?? 'Produk';
                final variantNames = item.variants
                    .where((v) => v.variantOption != null)
                    .map((v) => v.variantOption!.name)
                    .join(', ');

                return pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 6),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Expanded(
                            child: pw.Text(
                              productName,
                              style: pw.TextStyle(font: ttfBold, fontSize: 10),
                            ),
                          ),
                          pw.Text(subtotalItem,
                              style: pw.TextStyle(font: ttfBold, fontSize: 10)),
                        ],
                      ),
                      if (variantNames.isNotEmpty)
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(left: 4),
                          child: pw.Text('($variantNames)',
                              style: pw.TextStyle(font: ttf, fontSize: 8)),
                        ),
                      pw.Text(
                        '${item.quantity} x $unitPrice',
                        style: pw.TextStyle(font: ttf, fontSize: 9),
                      ),
                    ],
                  ),
                );
              }),

              pw.SizedBox(height: 8),
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    if (sale.discountTotal > 0) ...[
                      pw.Text('Subtotal: ${CurrencyUtil.format(sale.subtotal)}',
                          style: pw.TextStyle(font: ttf, fontSize: 10)),
                      pw.Text(
                          'Diskon: -${CurrencyUtil.format(sale.discountTotal)}',
                          style: pw.TextStyle(font: ttf, fontSize: 10)),
                    ],
                    pw.Text('Total: ${CurrencyUtil.format(sale.grandTotal)}',
                        style: pw.TextStyle(font: ttfBold, fontSize: 11)),
                  ],
                ),
              ),

              pw.SizedBox(height: 8),
              pw.Text('Metode: ${sale.paymentMethod?.name ?? "-"}',
                  style: pw.TextStyle(font: ttf, fontSize: 10)),
              pw.Text('Pembeli: ${sale.customerName.isEmpty ? "-" : sale.customerName}',
                  style: pw.TextStyle(font: ttf, fontSize: 10)),
              pw.SizedBox(height: 4),
              pw.Text('Kasir: ${sale.user?.name ?? user.name}',
                  style: pw.TextStyle(font: ttf, fontSize: 10)),
              pw.SizedBox(height: 12),
              pw.Center(
                  child: pw.Text('Terima kasih telah berbelanja!',
                      style: pw.TextStyle(font: ttf, fontSize: 10))),
              pw.SizedBox(height: 2),
              pw.Center(
                  child: pw.Text(dateStr,
                      style: pw.TextStyle(font: ttf, fontSize: 9))),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (_) async => doc.save(),
      name: 'Struk ${sale.invoiceNumber}',
    );
  }
}
