import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../app/app.dart';
import '../../../domain/models/auth/list_customer_model.dart';
import '../../../domain/services/app_service.dart';
import '../../../widgets/widgets.dart';
import '../../modules.dart';

class NewPersonScreen extends StatelessWidget {
  final bool isNewPerson;
  final String url;
  final String? token;
  final List<Value>? value;
  const NewPersonScreen({
    Key? key,
    this.isNewPerson = true,
    this.url = '',
    this.token = '',
    this.value,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewPersonProvider(value: value)),
      ],
      child: _NewPersonScreen(
        isNewPerson: isNewPerson,
        url: url,
        token: token!,
      ),
    );
  }
}

class _NewPersonScreen extends StatelessWidget {
  final bool isNewPerson;
  final String url;
  final String token;
  const _NewPersonScreen({
    Key? key,
    this.isNewPerson = true,
    required this.url,
    required this.token,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final provider = Provider.of<NewPersonProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(isNewPerson ? 'Agregar nueva persona' : 'Editar persona'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppConstants.horizontalPadding,
          child: Column(
            children: [
              SizedBox(height: size.height * .06),
              GestureDetector(
                onTap: () => showModalBottomSheet(
                  useSafeArea: true,
                  elevation: 20,
                  context: context,
                  builder: (_) => _ModalBottomSheetWidget(provider),
                ),
                child: provider.photo == null
                    ? Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(
                              url == ''
                                  ? 'https://www.eleonoracardona.com/wp-content/uploads/2016/04/sin-foto.jpg'
                                  : url,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.memory(
                          provider.photo!,
                        ),
                      ),
              ),
              SizedBox(height: size.height * .06),
              CustomInputField(
                initialValue: provider.data['FirstName'],
                formProperty: 'FirstName',
                formValues: provider.data,
                hintText: 'Escribe tu nombre',
                icon: Icons.person,
                labelText: 'Nombre',
                textCapitalization: TextCapitalization.words,
              ),
              SizedBox(height: size.height * .02),
              CustomInputField(
                initialValue: provider.data['LastName'],
                formProperty: 'LastName',
                formValues: provider.data,
                hintText: 'Escribe tu primer apellido',
                icon: Icons.person,
                labelText: 'Primer apellido',
                textCapitalization: TextCapitalization.words,
              ),
              SizedBox(height: size.height * .02),
              CustomInputField(
                initialValue: provider.data['MiddleName'],
                formProperty: 'MiddleName',
                formValues: provider.data,
                hintText: 'Escribe tu segundo apellido',
                icon: Icons.person,
                labelText: 'Segundo Apellido',
                textCapitalization: TextCapitalization.words,
              ),
              SizedBox(height: size.height * .02),
              CustomInputField(
                initialValue: provider.data['Email'],
                keyboardType: TextInputType.emailAddress,
                formProperty: 'Email',
                formValues: provider.data,
                hintText: 'Escribe tu correo electronico',
                icon: Icons.email,
                labelText: 'Correo electronico',
                textCapitalization: TextCapitalization.words,
              ),
              SizedBox(height: size.height * .02),
              CustomInputField(
                initialValue: provider.data['Phone'],
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                maxLength: 10,
                formProperty: 'Phone',
                formValues: provider.data,
                hintText: 'Escribe tu número telefónico',
                icon: Icons.phone_android,
                labelText: 'Número telefónico',
                textCapitalization: TextCapitalization.words,
              ),
              SizedBox(height: size.height * .02),
              Center(
                child: ElevatedButton(
                  onPressed: !provider.isLoading
                      ? () async {
                          provider.isLoading = true;
                          if (provider.photo != null) {
                            provider.data['Photo'] = provider.photo;
                          } else {
                            provider.data['Photo'] = null;
                          }
                          if (isNewPerson) {
                            await AppService()
                                .apiPost(
                              'odata/Customer',
                              provider.data,
                              token: token,
                            )
                                .then(
                              (value) {
                                if (value.statusCode == 201) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Nuevo registro creado')),
                                  );
                                  Navigator.pop(context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(value.body)),
                                  );
                                }
                              },
                            );
                          } else {
                            await AppService()
                                .apiPut(
                              'odata/Customer',
                              provider.data,
                              token: token,
                              key: provider.key,
                            )
                                .then(
                              (value) {
                                if (value.statusCode == 204) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Registro actualizado'),
                                    ),
                                  );
                                  Navigator.pop(context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(value.body)),
                                  );
                                }
                              },
                            );
                          }
                          provider.isLoading = false;
                        }
                      : () {},
                  child: Text(
                    !provider.isLoading
                        ? '${isNewPerson ? 'Guardar registro' : 'Editar registro'} '
                        : 'Cargando...',
                    style: StylesHelpers.w500(20, AppConstants.darkColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModalBottomSheetWidget extends StatelessWidget {
  final NewPersonProvider provider;
  const _ModalBottomSheetWidget(this.provider);
  @override
  Widget build(BuildContext context) {
    return ModalBottomSheet(
      title: 'Selecciona una opción',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () async {
              await filePicker().then((XFile? pickedFile) async {
                if (pickedFile == null) return;
                await pickedFile.readAsBytes().then(
                  (Uint8List value) {
                    provider.photo = value;
                    Navigator.pop(context);
                  },
                );
              });
            },
            child: Text(
              'Tomar de cámara',
              style: StylesHelpers.w400(16),
            ),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () async {
              await filePickerGalery().then((XFile? pickedFile) async {
                if (pickedFile == null) return;
                await pickedFile.readAsBytes().then(
                  (Uint8List value) {
                    provider.photo = value;
                    Navigator.pop(context);
                  },
                );
              });
            },
            child: Text(
              'Elegir de galería',
              style: StylesHelpers.w400(16),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
