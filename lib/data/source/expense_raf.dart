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
    await writeFrom(lengthBuffer.buffer.asUint8List());
    //ghi data
    await writeFrom(bytes);
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
  static final ExpenseRafHelper _instance = ExpenseRafHelper._internal();
  RandomAccessFile? _raf;

  //constructor
  factory ExpenseRafHelper() => _instance;
  ExpenseRafHelper._internal();

  Future<RandomAccessFile> _getRaf() async {
    if (_raf != null) return _raf!;

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String fullPath = p.join(appDocDir.path, 'data', 'expenses.bin');

    File file = File(fullPath);
    await file.create(recursive: true);

    _raf = await file.open(mode: FileMode.append);
    return _raf!;
  }

  Future<bool> saveExpense(Expense expense) async {
    try {
      int size = 0;
      final raf = await _getRaf();
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

      await raf.flush();

      return true;
    } catch (error) {
      print('add: $error');
      return false;
    }
  }

  Future<bool> removeExpense(Expense expense) async {
    try {
      final raf = await _getRaf();
      await raf.setPosition(0);
      int lengthFile = await raf.length();

      if (lengthFile < 2) return false;

      final sizeByteDate = await raf.read(2);
      int size = ByteData.sublistView(sizeByteDate).getUint16(0);

      for (var i = 0; i < size; i++) {
        int currentPos = await raf.position();
        int isDeleted = await raf.readByte();
        String id = await raf.readUtf8();
        await raf.readUtf8();
        await raf.read(8);
        await raf.readByte();
        await raf.read(8);

        if (id == expense.id) {
          if (isDeleted != 1) return false;

          await raf.setPosition(currentPos);
          await raf.writeByte(0);
          return true;
        }
      }

      return false;
    } catch (error) {
      return false;
    }
  }

  Future<bool> updateExpense(Expense expense) async {
    try {
      final raf = await _getRaf();
      await raf.setPosition(0);
      int lengthFile = await raf.length();

      if (lengthFile < 2) return false;

      final sizeByteDate = await raf.read(2);
      int size = ByteData.sublistView(sizeByteDate).getUint16(0);

      for (var i = 0; i < size; i++) {
        int isDeleted = await raf.readByte();
        String id = await raf.readUtf8();

        int currentPos = await raf.position();

        await raf.readUtf8();
        await raf.read(8);
        await raf.readByte();
        await raf.read(8);

        if (id == expense.id) {
          if (isDeleted != 1) return false;

          await raf.setPosition(currentPos);
          await raf.writeUtf8(expense.title);

          final amountByteData = ByteData(8)..setFloat64(0, expense.amount);
          await raf.writeFrom(amountByteData.buffer.asUint8List());

          await raf.writeByte(expense.category.index);

          final dateByteData = ByteData(8)
            ..setInt64(0, expense.date.millisecondsSinceEpoch);
          await raf.writeFrom(dateByteData.buffer.asUint8List());

          await raf.flush();
          return true;
        }
      }

      return false;
    } catch (error) {
      print('update: $error');
      return false;
    }
  }

  Future<List<Expense>> getExpenses() async {
    final List<Expense> results = [];

    try {
      final raf = await _getRaf();
      await raf.setPosition(0);
      int lengthFile = await raf.length();

      if (lengthFile < 2) return results;

      final byteDataSize = await raf.read(2);
      int size = ByteData.sublistView(byteDataSize).getUint16(0);

      for (var i = 0; i < size; i++) {
        int isDeleted = await raf.readByte();

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

        if (isDeleted != 1) continue;

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
      print('get: $error');
      return results;
    }
  }

  Future<void> close() async {
    if (_raf != null) {
      await _raf!.close();
      _raf = null;
    }
  }
}
