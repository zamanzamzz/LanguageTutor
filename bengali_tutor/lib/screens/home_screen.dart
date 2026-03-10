import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/content_models.dart';
import 'topic_screen.dart';
import 'roleplay_screen.dart';
import 'recorder/recorder_home_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bolun: Learn Bengali'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.mic),
            tooltip: 'Recorder Studio',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RecorderHomeScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return Center(child: Text(provider.errorMessage!));
          }

          final currentUnit = provider.nextPlayableUnit;

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildHeader(currentUnit, context)),
              // Levels Section
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final level = provider.levels[index];
                  return _buildLevelSection(context, level, provider);
                }, childCount: provider.levels.length),
              ),

              // Roleplay Section
              if (provider.allScenarios.isNotEmpty) ...[
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 24, 16, 12),
                    child: Text(
                      'Conversational Practice',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final scenario = provider.allScenarios[index];
                    return _buildScenarioCard(context, scenario, provider);
                  }, childCount: provider.allScenarios.length),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(Unit? currentUnit, BuildContext context) {
    return Container(
      color: Colors.teal,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Shagotom!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Ready to continue your journey?',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 24),
          if (currentUnit != null)
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TopicScreen(unit: currentUnit),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.orange,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'NEXT LESSON',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              currentUnit.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'All levels completed! Great job! 🎉',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLevelSection(
    BuildContext context,
    Level level,
    AppProvider provider,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                level.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                level.description,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: level.units.length,
          itemBuilder: (context, index) {
            final unit = level.units[index];
            final isCompleted = provider.isUnitCompleted(unit.id);
            final isLocked = provider.isUnitLocked(unit.id);
            final isCurrent = !isCompleted && !isLocked;

            return Card(
              elevation: isCurrent ? 4 : 1,
              margin: const EdgeInsets.only(bottom: 12),
              color: isLocked
                  ? Colors.grey[100]
                  : (isCompleted ? Colors.green[50] : Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: isCurrent
                    ? const BorderSide(color: Colors.orange, width: 2)
                    : (isCompleted
                          ? const BorderSide(color: Colors.green, width: 1)
                          : BorderSide.none),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: isLocked
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TopicScreen(unit: unit),
                          ),
                        );
                      },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // Status Icon
                      if (isLocked)
                        const Icon(Icons.lock, color: Colors.grey)
                      else if (isCompleted)
                        const Icon(Icons.check_circle, color: Colors.green)
                      else
                        const Icon(
                          Icons.play_circle_fill,
                          color: Colors.orange,
                        ),

                      const SizedBox(width: 16),

                      // Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              unit.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isLocked ? Colors.grey : Colors.black87,
                                fontSize: 16,
                              ),
                            ),
                            if (isCurrent)
                              const Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Text(
                                  'Current Lesson',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      if (!isLocked)
                        const Icon(Icons.chevron_right, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildScenarioCard(
    BuildContext context,
    Scenario scenario,
    AppProvider provider,
  ) {
    final isCompleted = provider.isScenarioCompleted(scenario.id);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: CircleAvatar(
            backgroundColor: Colors.teal[100],
            child: const Icon(Icons.chat_bubble_outline, color: Colors.teal),
          ),
          title: Text(
            scenario.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              scenario.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          trailing: isCompleted
              ? const Icon(Icons.check_circle, color: Colors.green)
              : const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RoleplayScreen(scenario: scenario),
              ),
            );
          },
        ),
      ),
    );
  }
}
