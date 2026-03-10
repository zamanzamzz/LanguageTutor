import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../models/content_models.dart';
import '../providers/app_provider.dart';
import '../widgets/phrase_card.dart';

class PracticeSessionScreen extends StatefulWidget {
  final Unit unit;

  const PracticeSessionScreen({Key? key, required this.unit}) : super(key: key);

  @override
  State<PracticeSessionScreen> createState() => _PracticeSessionScreenState();
}

class _PracticeSessionScreenState extends State<PracticeSessionScreen> {
  late List<Phrase> _queue;
  late Map<String, int> _viewCounts;

  int _currentIndex = 0;
  bool _isAnswerRevealed = false;
  bool _isSessionComplete = false;
  Timer? _countdownTimer;
  int _countdownValue = 3;
  bool _isCountingDown = false;

  @override
  void initState() {
    super.initState();
    _initializeSession();
  }

  void _initializeSession() {
    final provider = Provider.of<AppProvider>(context, listen: false);
    _queue = provider.generatePracticeSession(widget.unit);
    _viewCounts = {for (var p in _queue) p.id: 0};
    _currentIndex = 0;
    _startPhraseFlow();
  }

  void _startPhraseFlow() {
    setState(() {
      _isAnswerRevealed = false;
      _countdownValue = 3;
      _isCountingDown = true;
    });

    // Play Prompt Audio
    final phrase = _queue[_currentIndex];
    Provider.of<AppProvider>(context, listen: false).playPrompt(phrase);

    // Start Timer
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdownValue > 0) {
          _countdownValue--;
        } else {
          _isCountingDown = false;
          _revealAnswer();
          timer.cancel();
        }
      });
    });
  }

  void _revealAnswer() {
    setState(() {
      _isAnswerRevealed = true;
    });
    // Play Answer Audio
    final phrase = _queue[_currentIndex];
    Provider.of<AppProvider>(context, listen: false).playPhrase(phrase);
  }

  void _nextPhrase() {
    setState(() {
      // Increment view count for current phrase
      final currentPhrase = _queue[_currentIndex];
      _viewCounts[currentPhrase.id] = (_viewCounts[currentPhrase.id] ?? 0) + 1;

      // Check if all needed reps are done
      bool allDone = _viewCounts.values.every((count) => count >= 3);
      if (allDone) {
        _isSessionComplete = true;
        return;
      }

      // Move to next
      _currentIndex = (_currentIndex + 1) % _queue.length;

      // Skip if this specific phrase is already mastered (optimization)
      // (Optional: keep showing it for spacing, but user asked for "at least 3")
      int loopSafety = 0;
      while (_viewCounts[_queue[_currentIndex].id]! >= 3 &&
          loopSafety < _queue.length) {
        _currentIndex = (_currentIndex + 1) % _queue.length;
        loopSafety++;
      }

      _startPhraseFlow();
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isSessionComplete) {
      return _buildCompletionScreen();
    }

    final phrase = _queue[_currentIndex];
    final progress = _viewCounts[phrase.id] ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Practice: ${widget.unit.title}'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          // Progress Bar
          LinearProgressIndicator(
            value:
                (_viewCounts.values.fold(0, (a, b) => a + b)) /
                (_queue.length * 3),
            backgroundColor: Colors.teal.shade100,
            color: Colors.teal,
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Prompt Section
                  Text(
                    'TRANSLATE THIS:',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    phrase.prompt?.english ??
                        "How do you say: ${phrase.english}?",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (phrase.prompt != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        phrase.prompt!.bengali,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.teal,
                        ),
                      ),
                    ),

                  const SizedBox(height: 40),

                  // Countdown or Answer
                  if (_isCountingDown)
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.orange.shade100,
                      child: Text(
                        '$_countdownValue',
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),
                    )
                  else if (_isAnswerRevealed)
                    Column(
                      children: [
                        PhraseCard(phrase: phrase),
                        const SizedBox(height: 40),
                        ElevatedButton.icon(
                          onPressed: _nextPhrase,
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text('Next'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            textStyle: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Reps: $progress / 3',
              style: TextStyle(color: Colors.grey[500]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionScreen() {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.celebration, color: Colors.white, size: 80),
              const SizedBox(height: 24),
              const Text(
                'Session Complete!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'You have practiced every phrase at least 3 times.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
              const SizedBox(height: 60),

              ElevatedButton(
                onPressed: () {
                  Provider.of<AppProvider>(
                    context,
                    listen: false,
                  ).completeUnit(widget.unit.id);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.teal,
                  padding: const EdgeInsets.all(20),
                ),
                child: const Text(
                  'I\'M COMFORTABLE - UNLOCK NEXT',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {
                  // Restart session
                  _initializeSession();
                  setState(() {
                    _isSessionComplete = false;
                  });
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                  padding: const EdgeInsets.all(20),
                ),
                child: const Text('I NEED MORE PRACTICE'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Back to Menu',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
