#!/usr/bin/env bash
# paraphrasing-korean 멀티 하니스 설치기.
# agentskills.io 표준 스킬 폴더를 각 하니스의 스킬 디렉토리에 심링크(기본) 또는 복사(--copy)한다.
#
# 사용법:
#   ./install.sh [claude|codex|openclaw|hermes|agents|all] [--copy]
#
#   claude    → ~/.claude/skills/
#   codex     → ~/.agents/skills/   (Codex + OpenClaw 공용 경로)
#   openclaw  → ~/.agents/skills/
#   agents    → ~/.agents/skills/   (위 둘과 동일, 명시적 이름)
#   hermes    → ~/.hermes/skills/writing/
#   all       → 위 경로 중 부모 디렉토리가 존재하는 곳 모두
#
# 심링크 설치는 `git pull` 로 갱신된다. --copy 는 심링크를 따라가(-L) 자족적 폴더로 복사한다.
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$REPO/skills"
MODE="${1:-all}"
COPY=0
for a in "$@"; do [ "$a" = "--copy" ] && COPY=1; done

# 설치할 스킬 폴더(로마자 별칭 -sentence 포함). 심링크 자체도 대상.
SKILLS=(paraphrasing-korean paraphrasing-korean-센텐스 paraphrasing-korean-trans paraphrasing-korean-ai paraphrasing-korean-sentence)

link_one() {  # $1=src dir, $2=dest dir
  local src="$1" dest="$2"
  mkdir -p "$dest"
  for s in "${SKILLS[@]}"; do
    local from="$src/$s" to="$dest/$s"
    [ -e "$from" ] || continue
    rm -rf "$to"
    if [ "$COPY" -eq 1 ]; then
      cp -RL "$from" "$to"        # 심링크 따라가 자족 복사
    else
      ln -s "$from" "$to"         # 심링크
    fi
    echo "  $s → $to"
  done
}

install_target() {  # $1=label, $2=dest, $3=require_parent(1/0)
  local label="$1" dest="$2" req="$3"
  local parent; parent="$(dirname "$dest")"
  if [ "$req" -eq 1 ] && [ ! -d "$parent" ]; then
    echo "건너뜀($label): $parent 없음."
    return
  fi
  echo "[$label] → $dest"
  link_one "$SKILLS_DIR" "$dest"
}

# ~/.agents/skills 는 agentskills.io 공용 경로(Codex·OpenClaw가 함께 읽음). 일부 하니스는
# 네이티브 경로(~/.codex/skills, ~/.openclaw/skills)도 읽으므로 둘 다 설치해 호환을 넓힌다.
case "$MODE" in
  claude)   install_target claude   "$HOME/.claude/skills"          0 ;;
  agents)   install_target agents   "$HOME/.agents/skills"          0 ;;
  codex)    install_target codex    "$HOME/.codex/skills"           0
            install_target "codex(agents)" "$HOME/.agents/skills"   0 ;;
  openclaw) install_target openclaw "$HOME/.openclaw/skills"        0
            install_target "openclaw(agents)" "$HOME/.agents/skills" 0 ;;
  hermes)   install_target hermes   "$HOME/.hermes/skills/writing"  0 ;;
  all)
    install_target claude   "$HOME/.claude/skills"         1
    install_target agents   "$HOME/.agents/skills"         1
    install_target codex    "$HOME/.codex/skills"          1
    install_target openclaw "$HOME/.openclaw/skills"       1
    install_target hermes   "$HOME/.hermes/skills/writing" 1
    ;;
  *) echo "알 수 없는 대상: $MODE (claude|codex|openclaw|hermes|agents|all)"; exit 1 ;;
esac
echo "완료. ($([ "$COPY" -eq 1 ] && echo 복사 || echo 심링크))"
