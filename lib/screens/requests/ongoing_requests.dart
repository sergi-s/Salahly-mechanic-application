import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salahly_mechanic/classes/provider/ongoing_requests_notifier.dart';

class OngoingScreenDummy extends ConsumerWidget {
  static final routeName = "/ongoingscreendummy";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    OngoingRequestsNotifier roro = ref.watch(ongoingRequestsProvider.notifier);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  roro.listenRequestsFromDatabase();
                },
                child: Text("Start stream")),
            Text("Number of rsa found "+ref.watch(ongoingRequestsProvider).length.toString())
          ],
        ),
      ),
    );
  }
}
