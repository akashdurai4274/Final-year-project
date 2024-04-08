import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class Encapsulation extends StatefulWidget {
  const Encapsulation({super.key});

  @override
  State<Encapsulation> createState() => _InheritanceState();
}

class _InheritanceState extends State<Encapsulation> {
  bool isLoading = true;
  Future<void> simulateloading() async{
    await Future.delayed(Duration(seconds: 6));

    setState(() {
      isLoading=false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    simulateloading();
  }
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.disabled)
    ..loadRequest(Uri.parse('https://www.javatpoint.com/encapsulation'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90.0),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: AppBar(
                title: const Text("Encapsulation"),
                titleSpacing: 0.0,
                centerTitle: true,
                toolbarHeight: 60.0,
                toolbarOpacity: 0.8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                ),
                elevation: 1.0,
                shadowColor: Colors.grey,
                backgroundColor: Colors.white,
              ),
            ),
          ),
        ),
        body:Stack(
          children: [
            // Content of your page
            Center(
              child:
              WebViewWidget(controller: controller),
            ),
            // Circular progress indicator
            if (isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        )
    );
  }
}
