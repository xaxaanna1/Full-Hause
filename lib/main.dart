import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leaderboard_api_example/generated/grpc/skllzz/challenge/challenge.pb.dart';
import 'package:leaderboard_api_example/generated/grpc/skllzz/common/stat.pb.dart';
import 'data/monitor_rank.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Full hause',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
            titleTextStyle: TextStyle(
              color: Color.fromRGBO(0, 0, 255, 0.576),
              fontSize: 30,
            ),
          ),
          useMaterial3: false,
        ),
        home: const MyHomePage(title: '🏃‍♀Full Hause🏃'),
      ),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final api = ref.watch(monitorRankProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
      ),
      body: api.when(
        data: (rank) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final member = rank.members[index];
              Color rankColor = Colors.blue;
              double size = 24;
              String rankIcon = '🌟';

              if (member.rank == 1) {
                rankColor = Colors.yellow;
                size = 28;
                rankIcon = '🥇';
              } else if (member.rank == 2) {
                rankColor = Colors.grey;
                size = 24;
                rankIcon = '🥈';
              } else if (member.rank == 3) {
                rankColor = Colors.orange;
                size = 20;
                rankIcon = '🥉';
              }

              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                margin: const EdgeInsets.all(10.0),
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        "${member.rank}",
                        style: TextStyle(
                          color: rankColor,
                          fontSize: size,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "${rankIcon} ${member.nickName}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size,
                            color: rankColor,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[300],
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: member.earnedValue / 100,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [Colors.green, Colors.blue],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                member.earnedValue.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: rank.members.length,
          );
        },
        error: (e, s) {
          return Text(e.toString());
        },
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}