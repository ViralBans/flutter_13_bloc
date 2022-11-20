import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';

import '../../business/bloc.dart';
import '../../data/services.dart';

class BlocScreen extends StatefulWidget {
  const BlocScreen({Key? key}) : super(key: key);

  @override
  State<BlocScreen> createState() => _TestState();
}

class _TestState extends State<BlocScreen> {
  SimpleBloc bloc = SimpleBloc();

  @override
  void initState() {
    super.initState();
    bloc.countAction.add(null);
    bloc.listAction.add(null);
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('BloC'),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: GetIt.I.get<DataNetwork>().getFruitList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      StreamBuilder2(
                          streams:
                              StreamTuple2(bloc.countState, bloc.listState),
                          builder: (context, snapshots) {
                            return Container(
                              width: double.infinity,
                              color: snapshots.snapshot1.data == 0
                                  ? Colors.red
                                  : Colors.green,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 5.0, bottom: 5.0),
                                child: snapshots.snapshot1.data == 0
                                    ? const Text(
                                        'В корзине пусто',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        'В корзине - ${snapshots.snapshot1.data} продуктов ${snapshots.snapshot2.data.toString()}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                              ),
                            );
                          }),
                      StreamBuilder(
                        stream: bloc.elementState,
                        builder: (context, snapshot3) {
                          return Expanded(
                            child: ListView(
                              children: GetIt.I.get<DataNetwork>().fl.map(
                                    (element) {
                                  return Card(
                                    child: ListTile(
                                      title: Text(element.name),
                                      subtitle: Text('Цена: ${element.cost} руб.'),
                                      trailing: isSelected
                                          ? TextButton(
                                        onPressed: () {
                                          bloc.elementAction
                                              .add(element.name);
                                          bloc.countAction.add(null);
                                          bloc.listAction.add(null);
                                          isSelected = false;
                                        },
                                        child: const Text(
                                          'Удалить',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      )
                                          : TextButton(
                                        onPressed: () {
                                          bloc.elementAction
                                              .add(element.name);
                                          bloc.countAction.add(null);
                                          bloc.listAction.add(null);
                                          isSelected = true;
                                        },
                                        child: const Text(
                                          'Добавить',
                                          style:
                                          TextStyle(color: Colors.green),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          );
            }
                      ),
                    ],
                  ),
                );
              default:
                return const Center(child: Text('Нет данных с сервера!'));
            }
          },
        ),
      ),
    );
  }
}
