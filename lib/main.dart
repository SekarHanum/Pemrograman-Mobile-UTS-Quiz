import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'questions.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KUIS INFORMATIKA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        fontFamily: 'Montserrat',
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KUIS INFORMATIKA'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Image.asset(
              'assets/icon/icon.png',
              height: 100,
            ),
            const SizedBox(height: 30),
            const Text(
              'Kuis Manajemen Informatika',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Kuiz ini berisikan seputar pertanyaan tentang Informatika',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const QuizPage(), // sudah cukup
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('START QUIZ'),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late List<Question> questions;
  int currentQuestion = 0;
  int score = 0;
  int timeLeft = 60;
  List<int?> selectedAnswers = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    questions = QuizQuestions.getQuestions();
    selectedAnswers = List.filled(questions.length, null);
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() => timeLeft--);
      } else {
        timer.cancel();
        nextQuestion();
      }
    });
  }

  void nextQuestion() {
    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
        timeLeft = 60;
      });
    } else {
      _timer?.cancel();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(
            score: score, 
            questionCount: questions.length,
          ),
        ),
      );
    }
  }

  void selectAnswer(int index) {
    setState(() {
      selectedAnswers[currentQuestion] = index;
      if (index == questions[currentQuestion].correctAnswerIndex) {
        score += 1;
      }
    });
    nextQuestion();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kuis Manajemen Informatika')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Pertanyaan ${currentQuestion + 1} dari ${questions.length}',
                  style: GoogleFonts.montserrat(fontSize: 18)),
              const SizedBox(height: 10),
              SizedBox(
                width: 200,
                child: LinearProgressIndicator(
                  value: (currentQuestion + 1) / questions.length,
                  backgroundColor: Colors.red[700],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
              const SizedBox(height: 10),
              Text('Sisa Waktu: $timeLeft detik',
                  style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.purple[800],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  questions[currentQuestion].question,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              ...List.generate(questions[currentQuestion].options.length, (index) {
                return GestureDetector(
                  onTap: () => selectAnswer(index),
                  child: Card(
                    color: Colors.purpleAccent[400],
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        questions[currentQuestion].options[index],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(fontSize: 18),
                      ),
                    ),
                  ),
                );
              }),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final int score;
  final int questionCount;

  const ResultPage({
    super.key, 
    required this.score, 
    required this.questionCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hasil Kuis')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Skor Akhir: ${score * 10} / ${questionCount * 10}',
                  style: GoogleFonts.montserrat(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizPage()),
                ),
                child: const Text('Coba Lagi'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text('Return to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
