import 'package:elwaqar/Customers/controller/customer_read_data_cubit/read_customer_cubit.dart';
import 'package:elwaqar/Customers/controller/customer_write_data_cubit/write_customer_cubit.dart';

import 'package:elwaqar/Expenses/Expenses_controller/Expenses_read_cubit/read_expenses_cubit.dart';
import 'package:elwaqar/Expenses/Expenses_controller/Expenses_write_cubit/write_expenses_cubit.dart';
import 'package:elwaqar/firebase_options.dart';
import 'package:elwaqar/material/material_controller/material_read_cubit/read_material_cubit.dart';
import 'package:elwaqar/material/material_controller/material_write_cubit/write_material_cubit.dart';
import 'package:elwaqar/splash_screen.dart';
import 'package:elwaqar/style/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_frame/device_frame.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
 
  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ReadCustomerCubit()..getCustomers()),
        BlocProvider(create: (context) => WriteCustomerCubit()),
        BlocProvider(create: (context) => ReadMaterialCubit()..getMaterials()),
        BlocProvider(create: (context) => WriteMaterialCubit()),
        BlocProvider(create: (context) => ReadExpensesCubit()..getExpenses()),
        BlocProvider(create: (context) => WriteExpensesCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeManager.themeData(),
        builder: (context, child) => DeviceFrame(
          device: Devices.ios.iPhone13,
          isFrameVisible: true,
          orientation: Orientation.portrait,
          screen: child!,
        ),
        home: const SplashScreens(),
      ),
    );
  }
}
