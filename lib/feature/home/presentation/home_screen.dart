import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:local_storage/core/component/snackbar/info_snackbar.dart';
import 'package:local_storage/core/component/text_field/app_text_field.dart';
import 'package:local_storage/core/local_storage/local_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final stringController = TextEditingController();
  final intController = TextEditingController();
  final boolNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    final stringSaved =
        await GetIt.I.get<LocalStorage>().getString("string_key");
    final intSaved = await GetIt.I.get<LocalStorage>().getInt("int_key");
    final boolSaved = await GetIt.I.get<LocalStorage>().getBool("bool_key");

    stringController.text = stringSaved ?? "";
    intController.text = intSaved?.toString() ?? "";
    boolNotifier.value = boolSaved;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local Storage"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              "Local Storage Demo with Shared Preference",
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            //
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 7,
                  child: AppTextField(
                    controller: stringController,
                    label: "Test String",
                  ),
                ),
                const SizedBox(width: 24),
                ElevatedButton(
                  onPressed: () async {
                    final result = await GetIt.I
                        .get<LocalStorage>()
                        .saveString("string_key", stringController.text);

                    if (!mounted) return;

                    if (result == LocalStorageResult.saved) {
                      showInfoSnackBar(context, "String Saved");
                    }
                  },
                  child: const Text("Save"),
                )
              ],
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 7,
                  child: AppTextField(
                    controller: intController,
                    label: "Test Integer",
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                ElevatedButton(
                  onPressed: () async {
                    final number = int.tryParse(intController.text);

                    if (number == null) {
                      final result = await GetIt.I
                          .get<LocalStorage>()
                          .removeData("int_key");
                      if (!mounted) return;

                      if (result == LocalStorageResult.deleted) {
                        showInfoSnackBar(context, "Int Deleted");
                      }
                      return;
                    }

                    final result = await GetIt.I
                        .get<LocalStorage>()
                        .saveInt("int_key", number);

                    if (!mounted) return;

                    if (result == LocalStorageResult.saved) {
                      showInfoSnackBar(context, "Int Saved");
                    }
                  },
                  child: const Text("Save"),
                )
              ],
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Test Boolean",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(width: 24),
                ValueListenableBuilder(
                  valueListenable: boolNotifier,
                  builder: (context, value, _) {
                    return Switch(
                      value: value,
                      onChanged: (val) async {
                        boolNotifier.value = val;
                        final result = await GetIt.I
                            .get<LocalStorage>()
                            .saveBool("bool_key", val);

                        if (!mounted) return;

                        if (result == LocalStorageResult.saved) {
                          showInfoSnackBar(context, "Bool Saved");
                        }
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                late LocalStorageResult result;

                result =
                    await GetIt.I.get<LocalStorage>().removeData("string_key");
                result =
                    await GetIt.I.get<LocalStorage>().removeData("int_key");
                result =
                    await GetIt.I.get<LocalStorage>().removeData("bool_key");

                if (!mounted) return;

                if (result == LocalStorageResult.deleted) {
                  showInfoSnackBar(context, "Data Cleared");
                }

                getData();
              },
              child: const Text("Clear Data"),
            )
          ],
        ),
      ),
    );
  }
}
