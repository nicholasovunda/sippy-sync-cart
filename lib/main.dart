import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sippy_cart_sharing/common_widgets/animated_loader.dart';
import 'package:sippy_cart_sharing/feature/cart/application/cart_service.dart';
import 'package:sippy_cart_sharing/feature/cart/domain/cart.dart';
import 'package:sippy_cart_sharing/feature/product/presentation/invite_pop_up_dialog.dart';
import 'package:sippy_cart_sharing/feature/product/presentation/join_pop_up_dialog.dart';
import 'package:sippy_cart_sharing/feature/session/data/local/local_repository.dart';
import 'package:sippy_cart_sharing/feature/session/data/local/local_session_repository.dart';
import 'package:sippy_cart_sharing/feature/session/domain/session.dart';
import 'package:sippy_cart_sharing/feature/user/activer_user.dart';
import 'package:sippy_cart_sharing/routes/auto_router.dart';
import 'package:sippy_cart_sharing/routes/auto_router.gr.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ActiveUserProvider()),
        Provider<LocalSessionRepositoryImpl>(
          create: (_) => LocalSessionRepositoryImpl(),
        ),
        ChangeNotifierProxyProvider<LocalSessionRepositoryImpl, CartService>(
          create:
              (context) => CartService(
                localSessionRepository: Provider.of<LocalSessionRepositoryImpl>(
                  context,
                  listen: false,
                ),
              ),
          update:
              (context, repository, previous) =>
                  previous ?? CartService(localSessionRepository: repository),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Sippy sync cart',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: _appRouter.config(),
      ),
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

  void _showInviteModal() {
    showDialog(
      context: context,
      builder:
          (dialogContext) => Provider.value(
            value: Provider.of<LocalSessionRepositoryImpl>(
              context,
              listen: false,
            ),
            child: const InviteModal(),
          ),
    );
  }

  void _showJoinModal() {
    showDialog(
      context: context,
      builder:
          (dialogContext) => Provider.value(
            value: Provider.of<LocalSessionRepositoryImpl>(
              context,
              listen: false,
            ),
            child: const JoinModal(),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<LocalSessionRepositoryImpl>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Sippy cart sync'), elevation: 2),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Previous Sessions",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child:
                    _mockSessions.isEmpty
                        ? const Center(child: Text("No previous sessions"))
                        : ListView.builder(
                          controller: _controller,
                          itemCount: _mockSessions.length,
                          itemBuilder:
                              (_, index) =>
                                  SessionCard(session: _mockSessions[index]),
                        ),
              ),
            ],
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(child: CustomLoadingIndicator()),
            ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _isLoading ? null : _showInviteModal,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(_isLoading ? "Creating..." : "New Session"),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: _isLoading ? null : _showJoinModal,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
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
    final guests = session.guestNames.values.join(", ");

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(session.creatorId),
        subtitle: Text("Guest(s): $guests"),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Load this session and navigate to products page
          final sessionRepo = Provider.of<LocalSessionRepository>(
            context,
            listen: false,
          );

          context.router.push(const ProductRoute());
        },
      ),
    );
  }
}

// Mock data
const _mockSessions = [
  Session(
    sessionId: '1',
    creatorId: 'James',
    guestNames: {'1': "Mike"},
    cart: Cart(),
  ),
  Session(
    sessionId: '2',
    creatorId: 'James',
    guestNames: {'1': "John"},
    cart: Cart(),
  ),
  Session(
    sessionId: '3',
    creatorId: 'James',
    guestNames: {'1': "Mark"},
    cart: Cart(),
  ),
  Session(
    sessionId: '4',
    creatorId: 'James',
    guestNames: {'1': "Helen"},
    cart: Cart(),
  ),
];
