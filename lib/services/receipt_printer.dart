import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../utils/currency_util.dart';
import '../models/cart_item.dart';
import '../models/store_info.dart';

class ReceiptPrinter {
  /// Generates a thermal-style PDF receipt and opens the native print dialog.
  static Future<void> printReceipt({
    required List<CartItem> items,
    required double total,
    required String paymentMethod,
    required String dateStr,
    required StoreInfo storeInfo,
  }) async {
    final doc = pw.Document();

    // Use a monospace font that resembles a thermal printer
    final ttf = await PdfGoogleFonts.courierPrimeRegular();
    final ttfBold = await PdfGoogleFonts.courierPrimeBold();

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
              '${now.month}/${now.day}/${now.year}, ${now.hour.toString().padLeft(2, '0')}.${now.minute.toString().padLeft(2, '0')} AM';

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
              pw.SizedBox(height: 12),

              // ── Restaurant name (bold, centered) ──
              pw.Center(
                child: pw.Text(
                  storeInfo.name,
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
                  storeInfo.address,
                  style: pw.TextStyle(font: ttf, fontSize: 10),
                ),
              ),
              pw.SizedBox(height: 2),

              // ── Phone ──
              pw.Center(
                child: pw.Text(
                  storeInfo.phone,
                  style: pw.TextStyle(font: ttf, fontSize: 10),
                ),
              ),
              pw.SizedBox(height: 8),

              // ── Divider ──
              pw.Divider(thickness: 0.5, color: PdfColors.black),
              pw.SizedBox(height: 8),

              // ── Itemized list ──
              ...items.map((item) {
                final subtotal = CurrencyUtil.format(item.subtotal);
                final line =
                    '${item.product.name} x${item.quantity} = $subtotal';
                return pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 4),
                  child: pw.Text(
                    line,
                    style: pw.TextStyle(font: ttf, fontSize: 10),
                  ),
                );
              }),

              pw.SizedBox(height: 8),

              // ── Total (right-aligned, bold) ──
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(
                  'Total: ${CurrencyUtil.format(total)}',
                  style: pw.TextStyle(
                    font: ttfBold,
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),

              pw.SizedBox(height: 8),

              // ── Payment method ──
              pw.Text(
                'Metode: $paymentMethod',
                style: pw.TextStyle(font: ttf, fontSize: 10),
              ),

              pw.SizedBox(height: 4),

              // ── Cashier name ──
              pw.Text(
                'Kasir: ${storeInfo.cashierName}',
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
      name: 'Struk Pembayaran',
    );
  }
}
