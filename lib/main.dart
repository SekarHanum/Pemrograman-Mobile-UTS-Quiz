import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.montserratTextTheme().apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      home: const QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Map<String, dynamic>> questions = [
    {'question': 'Jenis memori yang bersifat volatile dan digunakan sebagai penyimpanan sementara adalah', 'options': ['A. HDD', 'B. SSD', 'C. RAM', 'D. ROM'], 'answer': 2},
    {'question': 'Perintah dalam Python untuk menampilkan output ke layar adalah', 'options': ['A. echo', 'B. print', 'C. display', 'D. show'], 'answer': 1},
    {'question': 'Manakah yang termasuk protokol jaringan?', 'options': ['A. TCP/IP', 'B. HTML', 'C. JSON', 'D. CSS'], 'answer': 0},
    {'question': 'Apa kepanjangan dari HTTP dalam komunikasi jaringan?', 'options': ['A. HyperText Transfer Protocol', 'B. Hyperlink Transfer Process', 'C. HyperTerminal Transfer Protocol', 'D. High-Tech Transfer Program'], 'answer': 0},
    {'question': 'SQL digunakan untuk mengelola...', 'options': ['A. Sistem Informasi', 'B. Jaringan Komputer', 'C. Keamanan Sistem', 'D. Basis Data'], 'answer': 3},
  ];

  int currentQuestion = 0;
  int score = 0;
  int timeLeft = 60;
  List<int?> selectedAnswers = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
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
          builder: (context) => ResultPage(score: score, questions: questions, selectedAnswers: selectedAnswers),
        ),
      );
    }
  }

  void selectAnswer(int index) {
    setState(() {
      selectedAnswers.length = currentQuestion + 1;
      selectedAnswers[currentQuestion] = index;
      if (index == questions[currentQuestion]['answer']) {
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
                  questions[currentQuestion]['question'],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              ...List.generate(questions[currentQuestion]['options'].length, (index) {
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
                        questions[currentQuestion]['options'][index],
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
  final List<Map<String, dynamic>> questions;
  final List<int?> selectedAnswers;

  const ResultPage({super.key, required this.score, required this.questions, required this.selectedAnswers});

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
              Text('Skor Akhir: ${score * 20} / ${questions.length * 20}',
                  style: GoogleFonts.montserrat(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizPage()),
                ),
                child: const Text('Coba Lagi'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
