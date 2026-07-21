import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:second_app/model/expense.dart';

final expenseRafhelper = ExpenseRafHelper();

extension Utf8RandomAccessFile on RandomAccessFile {
  Future<void> writeUtf8(String txt) async {
    List<int> bytes = utf8.encode(txt);
    if (bytes.length > 65535) {
      throw FormatException(
        "Chuỗi quá dài, writeUTF chỉ hỗ trợ tối đa 65535 bytes!",
      );
    }

    final lengthBuffer = ByteData(2)..setUint16(0, bytes.length);
    //ghi length
    writeFrom(lengthBuffer.buffer.asUint8List());
    //ghi data
    writeFrom(bytes);
  }

  Future<String> readUtf8() async {
    Uint8List lengthBytes = await read(2);

    if (lengthBytes.length < 2) {
      throw FileSystemException("Không thể đọc đủ 2 bytes độ dài!");
    }

    int length = ByteData.sublistView(lengthBytes).getUint16(0);
    Uint8List bytesText = await read(length);

    String txt = utf8.decode(bytesText);

    return txt;
  }
}

class ExpenseRafHelper {
  late RandomAccessFile raf;

  ExpenseRafHelper() {
    createRaf();
  }

  Future<void> createRaf() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String fullPath = p.join(appDocDir.path, 'data', 'expenses.bin');

    File file = File(fullPath);
    file.create(recursive: true);

    RandomAccessFile raf = await file.open(mode: FileMode.write);

    this.raf = raf;
  }

  Future<bool> saveExpense(Expense expense) async {
    try {
      int size = 0;
      await raf.setPosition(0);
      int lengthFile = await raf.length();

      if (lengthFile < 2) {
        final init = ByteData(2)..setUint16(0, 0);
        await raf.writeFrom(init.buffer.asUint8List());
        lengthFile = 2;
      } else {
        Uint8List size8List = await raf.read(2);
        size = ByteData.sublistView(size8List).getUint16(0);
      }

      await raf.setPosition(lengthFile);

      await expense.saveExpense(raf);

      size++;
      await raf.setPosition(0);

      final resizeByteData = ByteData(2)..setUint16(0, size);
      await raf.writeFrom(resizeByteData.buffer.asUint8List());

      return true;
    } catch (error) {
      return false;
    }
  }

  Future<List<Expense>> getExpenses() async {
    final List<Expense> results = [];

    try {
      await raf.setPosition(0);
      int lengthFile = await raf.length();

      if (lengthFile < 2) return results;

      final byteDataSize = await raf.read(2);
      int size = ByteData.sublistView(byteDataSize).getUint16(0);

      for (var i = 0; i < size; i++) {
        String id = await raf.readUtf8();
        String title = await raf.readUtf8();

        final byteAmount = await raf.read(8);
        double amount = ByteData.sublistView(byteAmount).getFloat64(0);

        final index = await raf.readByte();
        Category category = Category.values[index];

        final byteDate = await raf.read(8);
        DateTime date = DateTime.fromMillisecondsSinceEpoch(
          ByteData.sublistView(byteDate).getInt64(0),
        );

        results.add(
          Expense.withId(
            id: id,
            title: title,
            amount: amount,
            date: date,
            category: category,
          ),
        );
      }

      return results;
    } catch (error) {
      return results;
    }
  }
}
