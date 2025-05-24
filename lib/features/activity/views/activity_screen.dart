import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

void main() => runApp(const KnowMeApp());

/*───────────────────────────────────────────────────────────────*
 |                         APP WIDE THEME                       |
 *───────────────────────────────────────────────────────────────*/
const primaryBlue = Color(0xFF0066FF);
const gray50 = Color(0xFFF8FAFC);
const gray100 = Color(0xFFF1F5F9);
const gray200 = Color(0xFFE2E8F0);
const gray400 = Color(0xFF94A3B8);
const gray500 = Color(0xFF64748B);
const gray700 = Color(0xFF334155);

class KnowMeApp extends StatelessWidget {
  const KnowMeApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Know Me',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: gray50,
        colorScheme:
            ColorScheme.fromSeed(seedColor: primaryBlue, primary: primaryBlue),
        textTheme: GoogleFonts.notoSansKrTextTheme()
            .apply(bodyColor: gray700, displayColor: gray700),
        chipTheme: ChipThemeData(
          labelStyle: GoogleFonts.notoSansKr(fontSize: 13, color: gray500),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          iconTheme: IconThemeData(color: gray500),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

/*───────────────────────────────────────────────────────────────*
 |                      COMMON APP BAR WIDGET                   |
 *───────────────────────────────────────────────────────────────*/
PreferredSizeWidget buildMainAppBar() => AppBar(
      titleSpacing: 16,
      leading: const SizedBox(), // 좌측 여백
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/logo.png', height: 24),
          const SizedBox(width: 6),
          Image.asset('assets/knowme_text.png', height: 22),
        ],
      ),
      actions: const [
        Icon(Icons.search),
        SizedBox(width: 12),
        Icon(Icons.notifications_none),
        SizedBox(width: 12),
        Icon(Icons.person_outline),
        SizedBox(width: 8),
      ],
    );

/*───────────────────────────────────────────────────────────────*
 |                           HOME PAGE                          |
 *───────────────────────────────────────────────────────────────*/
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedTag;
  int _navIndex = 1;

  static const filterTags = [
    'React',
    'Firebase',
    'ResponsiveUI',
    'TailwindCSS',
    'TypeScript',
    'API연동',
  ];

  final List<Project> _projects = const [
    Project(
      title: 'MyPlanner – 일정 관리 웹앱',
      description: 'React와 Firebase로 만든 개인 일정 관리 서비스',
      tags: ['React', 'Firebase', 'ResponsiveUI'],
      date: '2025.03.28',
    ),
    Project(
      title: 'Shopixel – 반응형 이커머스 프론트엔드',
      description: 'SCSS와 JavaScript로 만든 쇼핑몰 웹사이트',
      tags: ['ResponsiveUI', 'VanillaJS', 'SCSS'],
      date: '2024.10.02',
    ),
    Project(
      title: '코딩톡 – 개발자 커뮤니티 SPA',
      description: 'Next.js 기반의 소셜 피드형 커뮤니티',
      tags: ['React', 'TailwindCSS', 'TypeScript'],
      date: '2024.08.12',
    ),
    Project(
      title: 'DevBoard – 개발자 대시보드',
      description: 'Github API 기반의 개인 프로젝트 관리 대시보드',
      tags: ['React', 'API연동', 'ResponsiveUI'],
      date: '2024.06.05',
    ),
    Project(
      title: '모두의 날씨 – 실시간 날씨 조회 앱',
      description: 'OpenWeather API 연동과 사용자 경험 중심 UI',
      tags: ['React', 'API연동', 'ResponsiveUI'],
      date: '2024.02.10',
    ),
  ];

  List<Project> get _visibleProjects => _selectedTag == null
      ? _projects
      : _projects.where((p) => p.tags.contains(_selectedTag)).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMainAppBar(),
      body: Column(
        children: [
          _buildTagFilter(),
          const SizedBox(height: 8),
          _buildProjectList(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: primaryBlue,
        backgroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        icon: const Icon(Icons.add),
        label: const Text('추가'),
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const AddProjectPage())),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: NavigationBar(
        height: 62,
        selectedIndex: _navIndex,
        onDestinationSelected: (i) => setState(() => _navIndex = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: '공고'),
          NavigationDestination(
              icon: Icon(Icons.list_alt_outlined), label: '내 활동'),
          NavigationDestination(
              icon: Icon(Icons.lightbulb_outline), label: '활동 추천'),
          NavigationDestination(
              icon: Icon(Icons.analytics_outlined), label: 'AI 분석'),
        ],
      ),
    );
  }

  /*──── Tag Filter Row ────*/
  Widget _buildTagFilter() => SizedBox(
        height: 42,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemCount: filterTags.length + 1,
          itemBuilder: (context, idx) {
            if (idx == 0) {
              return IconButton(
                splashRadius: 20,
                icon: Icon(Icons.refresh,
                    color: _selectedTag == null ? gray500 : primaryBlue),
                onPressed: () => setState(() => _selectedTag = null),
              );
            }
            final tag = filterTags[idx - 1];
            final selected = tag == _selectedTag;
            return GestureDetector(
              onTap: () => setState(() => _selectedTag = selected ? null : tag),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: selected ? primaryBlue : gray100,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: selected ? primaryBlue : gray200),
                ),
                child: Text(
                  tag,
                  style: GoogleFonts.notoSansKr(
                    fontSize: 13,
                    color: selected ? Colors.white : gray700,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            );
          },
        ),
      );

  /*──── Project List ────*/
  Widget _buildProjectList() => Expanded(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: _visibleProjects.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, i) {
            final p = _visibleProjects[i];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: gray200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.title,
                        style: GoogleFonts.notoSansKr(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: gray700)),
                    const SizedBox(height: 4),
                    Text(p.description,
                        style: GoogleFonts.notoSansKr(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: gray500)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: p.tags
                          .map(
                            (tag) => Chip(
                              label: Text(tag,
                                  style: GoogleFonts.notoSansKr(fontSize: 12)),
                              backgroundColor: gray100,
                              side: BorderSide.none,
                              visualDensity: VisualDensity.compact,
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 10),
                    Text(p.date,
                        style: GoogleFonts.notoSansKr(
                            fontSize: 12, color: gray400)),
                  ],
                ),
              ),
            );
          },
        ),
      );
}

/*───────────────────────────────────────────────────────────────*
 |                    ADD-PROJECT INPUT PAGE                    |
 *───────────────────────────────────────────────────────────────*/
class AddProjectPage extends StatefulWidget {
  const AddProjectPage({super.key});
  @override
  State<AddProjectPage> createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  final _titleCtl = TextEditingController();
  final _descCtl = TextEditingController();
  final _summaryCtl = TextEditingController();
  final _tagCtl = TextEditingController();

  @override
  void dispose() {
    _titleCtl.dispose();
    _descCtl.dispose();
    _summaryCtl.dispose();
    _tagCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final today = DateFormat('yyyy.MM.dd').format(DateTime.now());

    return Scaffold(
      appBar: buildMainAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader('기본 정보'),
            _outlinedText(_titleCtl, '제목'),
            const SizedBox(height: 12),
            _outlinedText(_descCtl, '설명', maxLines: 2),
            const SizedBox(height: 8),
            Text(today,
                style: GoogleFonts.notoSansKr(fontSize: 13, color: gray500)),
            const SizedBox(height: 24),
            _divider(),
            _sectionHeader('요약'),
            Stack(
              children: [
                _outlinedText(_summaryCtl, '직접 입력',
                    maxLines: 3, contentPadding: const EdgeInsets.all(12)),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Icon(Icons.check_circle_outline,
                      color: primaryBlue, size: 22),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _divider(),
            _sectionHeader('태그'),
            Text('추천태그', style: GoogleFonts.notoSansKr(fontSize: 12)),
            const SizedBox(height: 6),
            _outlinedText(_tagCtl, '직접 입력 후 엔터'),
            const SizedBox(height: 24),
            _divider(),
            _linkRow('링크'),
            const SizedBox(height: 24),
            _divider(),
            _linkRow('파일', icon: Icons.insert_drive_file_outlined),
          ],
        ),
      ),
      // Save / Cancel 버튼을 FAB 공간 대신 하단 고정
      bottomSheet: Container(
        color: gray50,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton(
                style: FilledButton.styleFrom(backgroundColor: primaryBlue),
                onPressed: () {
                  // TODO: 저장 로직
                  Navigator.pop(context);
                },
                child: const Text('저장'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton(
                style: FilledButton.styleFrom(backgroundColor: gray200),
                onPressed: () => Navigator.pop(context),
                child: const Text('취소',
                    style:
                        TextStyle(color: gray500, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*──── UI Helpers ────*/
  Widget _sectionHeader(String text) => Text(text,
      style: GoogleFonts.notoSansKr(
          fontSize: 15, fontWeight: FontWeight.w700, color: primaryBlue));

  Widget _outlinedText(TextEditingController ctl, String hint,
          {int maxLines = 1, EdgeInsets? contentPadding}) =>
      TextField(
        controller: ctl,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          isDense: true,
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        ),
      );

  Widget _divider() => const Divider(height: 1, color: gray200);

  Widget _linkRow(String label, {IconData icon = Icons.link_outlined}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Icon(icon, color: primaryBlue),
            const SizedBox(width: 8),
            Text(label)
          ]),
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: primaryBlue),
            onPressed: () {}, // TODO: 추가 로직
          )
        ],
      );
}

/*───────────────────────────────────────────────────────────────*
 |                           MODEL                               |
 *───────────────────────────────────────────────────────────────*/
class Project {
  final String title;
  final String description;
  final List<String> tags;
  final String date;
  const Project(
      {required this.title,
      required this.description,
      required this.tags,
      required this.date});
}
