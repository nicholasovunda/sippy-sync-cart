import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sippy_cart_sharing/common_widgets/animated_loader.dart';

import 'package:sippy_cart_sharing/feature/cart/application/cart_service.dart';
import 'package:sippy_cart_sharing/feature/cart/domain/cart.dart';
import 'package:sippy_cart_sharing/feature/product/presentation/pop_up_dialog.dart';
import 'package:sippy_cart_sharing/feature/session/data/local/local_repository.dart';
import 'package:sippy_cart_sharing/feature/session/data/local/local_session_repository.dart';
import 'package:sippy_cart_sharing/feature/session/domain/session.dart';
import 'package:sippy_cart_sharing/routes/auto_router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<LocalSessionRepositoryImpl>(
          create: (_) => LocalSessionRepositoryImpl(),
        ),
        ChangeNotifierProvider<CartService>(
          create:
              (context) => CartService(
                localSessionRepository: Provider.of<LocalSessionRepository>(
                  context,
                  listen: false,
                ),
              ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Sippy sync cart',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: _appRouter.config(),
    );
  }
}

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _controller = ScrollController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sippy cart sync')),
      body: Stack(
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Previous Sessions",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: _controller,
                  itemCount: _mockSessions.length,
                  itemBuilder:
                      (_, index) => SessionCard(session: _mockSessions[index]),
                ),
              ),
            ],
          ),
          if (_isLoading)
            const Center(
              child: ColoredBox(
                color: Colors.black54,
                child: CustomLoadingIndicator(),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed:
                    _isLoading
                        ? null
                        : () {
                          showDialog(
                            context: context,
                            builder: (_) => const InviteModal(),
                          );
                        },
                child: Text(_isLoading ? "Creating..." : "New Session"),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: _isLoading ? null : () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                child: const Text("Join as Friend"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SessionCard extends StatelessWidget {
  final Session session;
  const SessionCard({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(session.creatorId),
        subtitle: Text("Guest(s): ${session.guestNames.values.join(", ")}"),
      ),
    );
  }
}

const _mockSessions = [
  Session(
    sessionId: '',
    creatorId: 'James',
    guestNames: {'1': "Mike"},
    cart: Cart(),
  ),
  Session(
    sessionId: '',
    creatorId: 'James',
    guestNames: {'1': "John"},
    cart: Cart(),
  ),
  Session(
    sessionId: '',
    creatorId: 'James',
    guestNames: {'1': "Mark"},
    cart: Cart(),
  ),
  Session(
    sessionId: '',
    creatorId: 'James',
    guestNames: {'1': "Helen"},
    cart: Cart(),
  ),
];
