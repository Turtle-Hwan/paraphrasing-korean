# 바뀜 기록

## 0.1.0 (2026-06-15)

첫 공개. 한국어 글을 문장 하나씩 다듬어 주는 스킬 묶음.

- **명령어 4개**: `paraphrasing-korean`(통합: 번역투 → AI 티 → 문장 다이어트),
  `-센텐스`(문장 다이어트), `-trans`(번역투), `-ai`(AI 티). `-sentence` 는 `-센텐스` 의 영문 별칭.
- **문장 단위로만 다듬기**: `segment.py`(문장 부호로 자르기 → 작업표) +
  `reassemble.py`(되붙이기 + 문장 수 검사 + 변경량 검사). 정규식으로 한꺼번에 바꾸지 않고,
  문장 칸을 하나씩 읽고 고치도록 구조로 강제.
- **정규식 힌트(선택)**: `scan.py` 가 의심 문장에 규칙 번호를 살짝 달아 줌(참고용, 고치는 건 에이전트).
- **규칙 글 4종**: `sentence-rules`(책 『내 문장이 그렇게 이상한가요?』에서 영감 — 교보문고 도서 페이지),
  `translationese-rules`(번역투), `ai-tell-rules`(AI 티), `prime-directives`(공통 약속).
- **여러 도구 지원**: Claude Code · Codex · OpenClaw · Hermes (`install.sh`).
- Claude Code 플러그인 설정(`.claude-plugin/plugin.json`) 포함.
