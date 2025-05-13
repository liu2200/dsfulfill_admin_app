import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class CachedNetworkFontLoader {
  // 单例模式
  static final CachedNetworkFontLoader _instance =
      CachedNetworkFontLoader._internal();
  factory CachedNetworkFontLoader() => _instance;
  CachedNetworkFontLoader._internal();

  // 已加载的字体缓存
  final Map<String, String> _loadedFonts = {};

  // 正在加载中的字体请求，避免重复发起同一个字体的加载
  final Map<String, Future<String>> _loadingFonts = {};

  // 获取字体文件名
  String _getFontName(String url) {
    return url.split('/').last;
  }

  // 获取缓存路径
  Future<String> _getCachePath(String fontName) async {
    final cacheDir = await getTemporaryDirectory();
    return '${cacheDir.path}/fonts/$fontName';
  }

  // 加载远程字体
  Future<String> loadFont(String url) async {
    // 如果已经加载过这个字体，直接返回
    if (_loadedFonts.containsKey(url)) {
      return _loadedFonts[url]!;
    }

    // 如果已经有正在请求的相同字体，返回相同的Future以避免重复请求
    if (_loadingFonts.containsKey(url)) {
      return _loadingFonts[url]!;
    }

    // 创建新的加载请求并缓存
    final loadFuture = _loadFontInternal(url);
    _loadingFonts[url] = loadFuture;

    try {
      final result = await loadFuture;
      // 请求完成后从加载中队列移除
      _loadingFonts.remove(url);
      return result;
    } catch (e) {
      // 错误时也要从队列移除
      _loadingFonts.remove(url);
      rethrow;
    }
  }

  // 内部实际加载字体的方法
  Future<String> _loadFontInternal(String url) async {
    final fontName = _getFontName(url);
    final fontFamily = fontName.split('.').first;

    try {
      // 获取缓存路径
      final cachePath = await _getCachePath(fontName);
      final cacheFile = File(cachePath);

      // 检查缓存目录是否存在，不存在则创建
      final cacheDir =
          Directory('${(await getTemporaryDirectory()).path}/fonts');
      if (!await cacheDir.exists()) {
        await cacheDir.create(recursive: true);
      }

      Uint8List fontData;

      // 检查缓存中是否已有该字体
      if (await cacheFile.exists()) {
        // 从缓存加载
        fontData = await cacheFile.readAsBytes();
      } else {
        // 从网络下载
        final response = await http.get(Uri.parse(url));
        if (response.statusCode != 200) {
          throw Exception('Failed to load font: ${response.statusCode}');
        }

        // 保存到缓存
        fontData = response.bodyBytes;
        await cacheFile.writeAsBytes(fontData);
      }

      // 注册字体
      final fontLoader = FontLoader(fontFamily);
      fontLoader.addFont(Future.value(ByteData.view(fontData.buffer)));
      await fontLoader.load();

      // 缓存字体名称
      _loadedFonts[url] = fontFamily;

      return fontFamily;
    } catch (e) {
      return '';
    }
  }

  // 清除字体缓存
  Future<void> clearCache() async {
    try {
      final cacheDir =
          Directory('${(await getTemporaryDirectory()).path}/fonts');
      if (await cacheDir.exists()) {
        await cacheDir.delete(recursive: true);
      }
      _loadedFonts.clear();
    } catch (e) {
      print('Error clearing font cache: $e');
    }
  }
}
