import 'dart:async';
import 'dart:convert';
import 'package:dsfulfill_cient_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmsCodeButton extends StatefulWidget {
  final String? account;
  final String smsType;
  final String type;
  final Function()? onSuccess;
  final Future<bool> Function(String) verifyWithServer;

  const SmsCodeButton({
    super.key,
    this.account,
    this.smsType = 'phone',
    this.type = 'text',
    this.onSuccess,
    required this.verifyWithServer,
  });

  @override
  _SmsCodeButtonState createState() => _SmsCodeButtonState();
}

class _SmsCodeButtonState extends State<SmsCodeButton> {
  late WebViewController _webViewController;
  int _countdown = 0;
  Timer? _timer;
  bool _isLoading = false;
  String? _deviceId;
  final Uuid _uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    _initDeviceInfo();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _initWebViewController();
    });
  }

  Future<void> _initDeviceInfo() async {
    try {
      final deviceInfo = await DeviceInfoPlugin().deviceInfo;
      final platform = Theme.of(context).platform;

      setState(() {
        _deviceId = switch (platform) {
          TargetPlatform.android =>
            (deviceInfo as AndroidDeviceInfo).fingerprint,
          TargetPlatform.iOS =>
            (deviceInfo as IosDeviceInfo).identifierForVendor,
          _ => _uuid.v4(),
        };
      });
    } catch (e) {
      setState(() => _deviceId = _uuid.v4());
    }
  }

  Future<String> _loadHtmlFromAssets() async {
    try {
      return await rootBundle.loadString('assets/html/captcha.html');
    } catch (e) {
      print('加载验证码HTML失败: $e');
      return '';
    }
  }

  void _initWebViewController() async {
    final htmlContent = await _loadHtmlFromAssets();

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..addJavaScriptChannel(
        'CaptchaSuccess',
        onMessageReceived: _handleSuccess,
      )
      ..addJavaScriptChannel(
        'CaptchaError',
        onMessageReceived: _handleError,
      )
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          _webViewController.runJavaScript('''
            document.body.style.backgroundColor = 'transparent';
            document.documentElement.style.backgroundColor = 'transparent';
            if (window.AndroidBridge) {
              AndroidBridge.enableMixedContentMode(true);
            }
          ''');
        },
        onPageFinished: (url) async {
          // 检查 initCaptcha 函数是否已经定义
          await _webViewController
              .runJavaScriptReturningResult('typeof initCaptcha')
              .then((result) {
            if (result == 'function') {
              // 函数已加载，执行初始化
              _webViewController.runJavaScript('initCaptcha()');
            }
          }).catchError((e) {
            print('检查 initCaptcha 函数时出错: $e');
          });
        },
        onWebResourceError: (error) {
          _handleError(JavaScriptMessage(message: error.description));
        },
      ))
      ..loadRequest(Uri.dataFromString(
        htmlContent,
        mimeType: 'text/html',
        encoding: utf8,
      ));
  }

  void _safeSetState(VoidCallback callback) {
    if (mounted) setState(callback);
  }

  Future<void> _handleVerification(Map<String, dynamic> data) async {
    if (!mounted) return;

    _safeSetState(() => _isLoading = true);
    try {
      final securityToken = _generateSecurityToken();
      final success = await widget.verifyWithServer(jsonEncode({
        'sessionId': data['sessionId'],
        'sig': data['param'],
        'token': securityToken,
        'clientTime': DateTime.now().toIso8601String(),
        'deviceId': _deviceId
      }));

      if (success) {
        widget.onSuccess?.call();
        _startCountdown();
      }
    } catch (e) {
      print('验证错误: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('验证失败: $e')),
        );
      }
    } finally {
      _safeSetState(() => _isLoading = false);
    }
  }

  void _startCountdown() {
    _safeSetState(() => _countdown = 60);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        _safeSetState(() => _countdown--);
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _showCaptchaDialog() async {
    if (_countdown > 0 || widget.account == null) return;

    _webViewController.reload(); // 重新加载WebView确保验证码正确初始化

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // 计算合适的宽高
            final screenWidth = MediaQuery.of(context).size.width;
            final width = screenWidth * 0.9; // 屏幕宽度的85%
            final height = width * 1.5; // 保持合适的宽高比

            return Container(
              width: width,
              height: height,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '安全验证',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '请完成下方安全验证',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: WebViewWidget(controller: _webViewController),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String _generateSecurityToken() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final hash = md5
        .convert(utf8.encode('${_uuid.v4()}|$timestamp|$_deviceId'))
        .toString();
    return '$timestamp:$hash';
  }

  void _handleSuccess(JavaScriptMessage message) async {
    try {
      final data = jsonDecode(message.message) as Map<String, dynamic>;
      if (data['captchaVerifyParam'] != null) {
        bool success = false;
        var params = {
          'captchaVerifyParam': data['captchaVerifyParam'],
          widget.smsType: widget.account!,
          'type': widget.type,
        };
        if (widget.smsType == 'phone') {
          await UserService.getSendSmsCode(params, (msg) {
            success = true;
            _startCountdown();
            Navigator.of(context).pop(); // 关闭验证码对话框
          }, (error) {
            success = false;
          });
        } else {
          await UserService.getSendEmailCode(params, (msg) {
            success = true;
            _startCountdown();
            Navigator.of(context).pop(); // 关闭验证码对话框
          }, (error) {
            success = false;
          });
        }
        // 执行回调，通知验证码结果
        if (data['resolveCallback'] != null) {
          await _webViewController
              .runJavaScript('(${data['resolveCallback']})(${success})');
        }
      }
    } catch (e) {
      // 重新加载验证码以重置状态
      _webViewController.reload();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('验证码处理失败: $e')),
      );
    }
  }

  void _handleError(JavaScriptMessage message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('验证失败: ${message.message}')),
      );
    }
  }

  @override
  void dispose() {
    _webViewController.clearCache();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 验证 account 是否为空
    final isAccountEmpty = widget.account == null || widget.account!.isEmpty;
    final isDisabled = _countdown > 0 || isAccountEmpty;
    return SizedBox(
      height: 48.h,
      width: 130.w,
      child: ElevatedButton(
        onPressed: isDisabled ? null : _showCaptchaDialog,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppStyles.primary,
          disabledBackgroundColor: AppStyles.primary.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: _isLoading
            ? SizedBox(
                width: 16.w,
                height: 16.h,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                _countdown > 0 ? '${_countdown}s' : '获取验证码'.tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
      ),
    );
  }
}
