import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Know Me',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Pretendard', // Pretendard 폰트 패밀리 적용
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const List<String> menuItems = [
    '프로필 수정',
    '비밀번호 변경',
    '소셜 연동',
    '멤버십 구독',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/logo.png', height: 28),
              const SizedBox(width: 6),
              Image.asset('assets/knowme_text.png', height: 22),
            ],
          ),
        ),
        actions: const [
          Icon(Icons.search, color: Colors.blueAccent),
          SizedBox(width: 16),
          Icon(Icons.notifications_none, color: Colors.blueAccent),
          SizedBox(width: 16),
          Icon(Icons.person_outline, color: Colors.blueAccent),
          SizedBox(width: 16),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 20),
          const Divider(thickness: 1),
          const SizedBox(height: 20),

          // 프로필 영역
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 62,
                  backgroundColor: Colors.blueAccent,
                  child: const CircleAvatar(
                    radius: 58,
                    backgroundImage: AssetImage('assets/silhouette.png'),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  '프론트엔드 개발자',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                const Text(
                  '이한양',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // 첫 번째 소개문
                const Text(
                  '끊임없이 배우고 도전하는\n프론트엔드 개발자',
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 1.5),
                ),
                const SizedBox(height: 16),

                // 수직 구분선
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 16),

                // 두 번째 소개문
                const Text(
                  '한양대학교 ERICA\nICT융합학부 재학',
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 1.5),
                ),
                const SizedBox(height: 16),

                // 수직 구분선
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 16),

                // 이메일
                const Text(
                  'adc1234@knowme.kr',
                  style: TextStyle(color: Colors.black87),
                ),
                const SizedBox(height: 16),

                // 수직 구분선
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),

          const SizedBox(height: 30),
          // 내 활동 버튼
          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 4,
                shape: const StadiumBorder(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                side: BorderSide(color: Colors.grey[300]!),
              ),
              child: const Text(
                '내 활동',
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
          ),

          const SizedBox(height: 30),
          const Divider(thickness: 1),

          // 메뉴 리스트
          ...List.generate(
            menuItems.length * 2 - 1,
            (i) => i.isEven
                ? ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      menuItems[i ~/ 2],
                      style: const TextStyle(fontSize: 16),
                    ),
                    trailing:
                        const Icon(Icons.chevron_right, color: Colors.grey),
                    onTap: () {},
                  )
                : const Divider(height: 1),
          ),

          const SizedBox(height: 30),
          const Divider(thickness: 1),

          // 푸터
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blueAccent.withOpacity(0.05),
                  Colors.blueAccent.withOpacity(0.15),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('고객지원',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                SizedBox(height: 4),
                Text('tel: 02-000-0000', style: TextStyle(fontSize: 12)),
                Text('email : help@knowme.com', style: TextStyle(fontSize: 12)),
                Text('주소', style: TextStyle(fontSize: 12)),
                SizedBox(height: 10),
                Text(
                  '이용약관   |   개인정보처리방침   |   고객센터   |   로그아웃   |   계정탈퇴',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 8),
                Text('©KnowMe. All rights reserved.',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
