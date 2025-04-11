class Question {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });
}

class QuizQuestions {
  static List<Question> getQuestions() {
    return [
      Question(
        question: 'Jenis memori yang bersifat volatile dan digunakan sebagai penyimpanan sementara adalah',
        options: ['A. HDD', 'B. SSD', 'C. RAM', 'D. ROM'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'Perintah dalam Python untuk menampilkan output ke layar adalah',
        options: ['A. echo', 'B. print', 'C. display', 'D. show'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'Manakah yang termasuk protokol jaringan?',
        options: ['A. TCP/IP', 'B. HTML', 'C. JSON', 'D. CSS'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'Apa kepanjangan dari HTTP dalam komunikasi jaringan?',
        options: ['A. HyperText Transfer Protocol', 'B. Hyperlink Transfer Process', 'C. HyperTerminal Transfer Protocol', 'D. High-Tech Transfer Program'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'SQL digunakan untuk mengelola...',
        options: ['A. Sistem Informasi', 'B. Jaringan Komputer', 'C. Keamanan Sistem', 'D. Basis Data'],
        correctAnswerIndex: 3,
      ),

      Question(
        question: 'Untuk membuat aplikasi web berbasis backend menggunakan Node.js, bahasa yang digunakan adalah',
        options: ['A. Java', 'B. Phyton', 'C. Javascript', 'D. Ruby'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'Perangkat lunak yang dirancang untuk merusak atau mengganggu sistem komputer disebut',
        options: ['A. Malware', 'B. Firewall', 'C. Proxy', 'D. Antivirus'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'Apa fungsi utama DNS (Domain Name System)?',
        options: ['A. Mengarahkan email', 'B. Menyimpan data', 'C. Menerjemahkan nama domain menjadi alamat IP', 'D. Melindungi dari virus'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'Alamat IP digunakan untuk',
        options: ['A. Menyimpan File', 'B. Menyediakan Layanan DNS', 'C. Menyimpan cookie browser', 'D. Mengidentifikasi perangkat dalam jaringan'],
        correctAnswerIndex: 3,
      ),
      Question(
        question: 'Protokol yang mengamankan komunikasi data melalui enkripsi adalah',
        options: ['A. HTTP', 'B. HTTPS', 'C. FTP', 'D. TCP'],
        correctAnswerIndex: 1,
      ),
    ];
  }
}
