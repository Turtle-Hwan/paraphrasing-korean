# 바뀜 기록

## 0.2.0 — 2026-06-16

설치를 쉽게 하고 규칙을 더했습니다.

- **한 줄 설치**: Claude Code 마켓플레이스 설정을 넣었습니다. `/plugin marketplace add` 한 번이면 됩니다.
- **설치 스크립트 강화**: 깔려 있는 도구를 스스로 찾고, 충돌 시 백업하고, `--dry-run`·`--copy` 를 지원합니다.
  `update.sh` 와 `uninstall.sh` 도 넣었습니다.
- **Gemini CLI 지원**: `gemini-extension.json` 과 `GEMINI.md`, 그리고 `commands/` 를 넣었습니다.
- **새 규칙**: 번역투 T-10~T-30, AI 티 AI-10~AI-26 을 더했습니다. 괄호 줄이기 S-15 와 쉼표 줄이기 S-16 도
  넣고, 공통 약속에 "한국어답게 쓰기"를 더했습니다.
- **이름 정리**: 문장 다이어트 명령을 `-sentence` 로 통일했습니다.
- **문서 정리**: 한국어 특화를 앞세우고, 괄호와 쉼표를 줄여 더 자연스럽게 다시 썼습니다. 책 인용을
  『내 문장이 그렇게 이상한가요?』(저자 김정선, 유유, 2016)로 통일했습니다.

## 0.1.0 — 2026-06-15

첫 공개. 한국어 글을 문장 하나씩 다듬어 주는 스킬 묶음.

- **명령어 4개**: `paraphrasing-korean` 통합, `-sentence` 문장 다이어트, `-trans` 번역투, `-ai` AI 티.
- **문장 단위로만 다듬기**: `segment.py` 가 문장 부호로 잘라 작업표를 만들고, `reassemble.py` 가 되붙이며
  문장 수와 변경량을 검사합니다. 정규식으로 한꺼번에 바꾸지 않고 문장 칸을 하나씩 읽고 고치도록 강제합니다.
- **정규식 힌트**: `scan.py` 가 의심 문장에 규칙 번호를 달아 줍니다. 참고용이고 고치는 일은 에이전트가 합니다.
- **규칙 글 4종**: `sentence-rules`, `translationese-rules`, `ai-tell-rules`, `prime-directives`.
- **여러 도구 지원**: Claude Code·Codex·OpenClaw·Hermes. Claude Code 플러그인 설정도 포함합니다.
