import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/app.dart';
import '../../../domain/services/app_service.dart';
import '../../../widgets/widgets.dart';
import '../../modules.dart';

class HomeScreen extends StatelessWidget {
  final String token;
  const HomeScreen({Key? key, this.token = ''}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeProvider(token: token),
        ),
      ],
      child: const _HomeScreen(),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes registrados'),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: provider.listCustomerModel?.value?.length ?? 0,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (_, int i) {
          var value2 = provider.listCustomerModel?.value?[i];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => NewPersonScreen(
                  isNewPerson: false,
                  url: value2.photo ?? '',
                  token: provider.apiToken,
                  value: provider.listCustomerModel?.value ?? [],
                ),
              ),
            ).then((value) => provider.getInfo(provider.apiToken)),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: GestureDetector(
                      onTap: value2!.photo == '' || value2.photo == null
                          ? () {}
                          : () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => _ViewImage(
                                    tag: i,
                                    url: value2.photo!,
                                    userName: value2.fullName ?? '',
                                  ),
                                ),
                              ),
                      child: Hero(
                        tag: i,
                        child: UserImage(
                          value2.photo ?? '',
                        ),
                      ),
                    ),
                    title: Text(value2.fullName ?? ''),
                    subtitle: Text(value2.email ?? ''),
                    trailing: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: const Icon(
                        Icons.delete,
                        color: AppConstants.redColor,
                      ),
                      onPressed: () => showCupertinoDialog(
                        context: context,
                        builder: (_) {
                          return CupertinoAlertDialog(
                            title: Text(
                              '¿Estás seguro de eliminar a ${value2.fullName}?',
                            ),
                            actions: [
                              CupertinoDialogAction(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'Cancelar',
                                  style: StylesHelpers.w400(
                                    16,
                                    AppConstants.redColor,
                                  ),
                                ),
                              ),
                              CupertinoDialogAction(
                                onPressed: () async {
                                  await AppService()
                                      .apiDelete(
                                    'odata/Customer',
                                    token: provider.apiToken,
                                    key: value2.oid,
                                  )
                                      .then(
                                    (value) {
                                      if (value.statusCode == 200) {
                                        provider.getInfo(provider.apiToken);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text('Registro borrado'),
                                          ),
                                        );
                                        Navigator.pop(context);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(content: Text(value.body)),
                                        );
                                      }
                                    },
                                  );
                                },
                                child: Text(
                                  'Eliminar',
                                  style: StylesHelpers.w400(16),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text.rich(
                      TextSpan(
                        text: 'Número telefónico: ',
                        style: StylesHelpers.w600(
                          14,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: value2.phone ?? '',
                            style: StylesHelpers.w400(
                              14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: CircleAvatar(
        backgroundColor: AppConstants.yellowColor,
        radius: 30,
        child: IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NewPersonScreen(
                isNewPerson: true,
                token: provider.apiToken,
                value: [],
              ),
            ),
          ).then((value) => provider.getInfo(provider.apiToken)),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class _ViewImage extends StatelessWidget {
  final int tag;
  final String url;
  final String userName;
  const _ViewImage({
    Key? key,
    required this.tag,
    required this.url,
    this.userName = '',
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
      ),
      body: Hero(
        tag: tag,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(url),
            ),
          ),
        ),
      ),
    );
  }
}
