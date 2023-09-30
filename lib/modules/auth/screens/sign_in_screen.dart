import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/app.dart';
import '../../../domain/services/app_service.dart';
import '../../../widgets/widgets.dart';
import '../../modules.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignInProvider()),
      ],
      child: const _SignInScreen(),
    );
  }
}

class _SignInScreen extends StatelessWidget {
  const _SignInScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final provider = Provider.of<SignInProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de clientes'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppConstants.horizontalPadding,
          child: Column(
            children: [
              SizedBox(height: size.height * .06),
              Container(
                decoration: BoxDecoration(
                  color: AppConstants.darkColor,
                  borderRadius: BorderRadius.circular(
                    AppConstants.borderRadius,
                  ),
                ),
                child: Image.asset(ImageConstant.yusoLogo, scale: 4),
              ),
              SizedBox(height: size.height * .05),
              CustomInputField(
                formProperty: 'userName',
                formValues: provider.data,
                hintText: 'Escribe tu nombre de usuario',
                icon: Icons.person,
                labelText: 'Usuario',
                textCapitalization: TextCapitalization.words,
              ),
              SizedBox(height: size.height * .02),
              CustomInputField(
                formProperty: 'password',
                formValues: provider.data,
                hintText: 'Escribe tu contraseña',
                icon: Icons.password,
                keyboardType: TextInputType.visiblePassword,
                labelText: 'Contraseña',
                obscureText: provider.hiddenPassword,
                suffixIcon: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () => provider.showPassword(),
                  icon: provider.hiddenPassword
                      ? const Icon(
                          Icons.visibility_off_outlined,
                        )
                      : const Icon(
                          Icons.remove_red_eye_outlined,
                        ),
                ),
              ),
              SizedBox(height: size.height * .02),
              ElevatedButton(
                onPressed: !provider.isLoading
                    ? () async {
                        provider.isLoading = true;
                        await AppService()
                            .apiPost(
                          'Authentication/Authenticate',
                          provider.data,
                          token: '',
                        )
                            .then(
                          (value) {
                            if (value.statusCode == 200) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Bienvenido')),
                              );
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => HomeScreen(
                                    token: value.body.replaceAll('"', ''),
                                  ),
                                ),
                                (route) => false,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(value.body)),
                              );
                            }
                          },
                        );
                        provider.isLoading = false;
                      }
                    : () {},
                child: Text(
                  !provider.isLoading ? 'Iniciar sesion' : 'Cargando...',
                  style: StylesHelpers.w500(20, AppConstants.darkColor),
                ),
              ),
              SizedBox(height: size.height * .06),
            ],
          ),
        ),
      ),
    );
  }
}
