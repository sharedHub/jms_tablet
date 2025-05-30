import 'package:smb_connect/smb_connect.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

class SmbClient {
  late SmbConnect _connect;

  Future<void> connect() async {
    try {
      debugPrint("🔌 Connecting to SMB server...");
      _connect = await SmbConnect.connectAuth(
        host: "192.168.1.22",
        domain: "",
        username: "Adminis",
        password: "1234",
      );
      debugPrint("✅ Successfully connected to SMB server.");
    } catch (e) {
      debugPrint("❌ Error connecting to SMB server: $e");
      rethrow;
    }
  }

  Future<Uint8List?> fetchImage(String imageName) async {
    try {
      debugPrint("📂 Attempting to access image path: $imageName");

      final file = await _connect.file(imageName); // Must be full UNC path
      debugPrint("📄 File object created for: $imageName");

      final reader = await _connect.openRead(file);
      debugPrint("⏳ Reading image data for: $imageName");

      final bytes = <int>[];
      await for (final chunk in reader) {
        bytes.addAll(chunk);
      }

      if (bytes.isEmpty) {
        debugPrint("❌ Empty byte stream received for: $imageName");
        return null;
      }

      debugPrint("✅ Successfully fetched image: $imageName | Size: ${bytes.length} bytes");
      return Uint8List.fromList(bytes);
    } catch (e, stackTrace) {
      debugPrint("❌ ERROR fetching image: $imageName");
      debugPrint("Exception: $e");
      debugPrint("Stack Trace: $stackTrace");
      return null;
    }
  }

  Future<void> disconnect() async {
    try {
      await _connect.close();
      debugPrint("🔌 SMB connection closed.");
    } catch (e) {
      debugPrint("⚠️ Error closing SMB connection: $e");
    }
  }
}