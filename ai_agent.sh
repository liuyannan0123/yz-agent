#!/bin/bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPTS_DIR="$PROJECT_DIR/scripts"

usage() {
  cat <<'EOF'
Usage:
  ./ai_agent.sh start        # start full AI agent system
  ./ai_agent.sh start-rag    # start only RAG QA service
  ./ai_agent.sh demo         # enable OpenClaw demo mode and print demo URL
  ./ai_agent.sh status       # show current service status
  ./ai_agent.sh stop         # stop full AI agent system
  ./ai_agent.sh restart      # restart full AI agent system
EOF
}

require_script() {
  local script_path="$1"
  if [ ! -x "$script_path" ]; then
    echo "Script not found or not executable: $script_path" >&2
    exit 1
  fi
}

if [ $# -lt 1 ]; then
  usage
  exit 1
fi

case "$1" in
  start)
    require_script "$SCRIPTS_DIR/start_all.sh"
    exec "$SCRIPTS_DIR/start_all.sh"
    ;;
  start-rag)
    require_script "$SCRIPTS_DIR/start_rag_qa_service.sh"
    exec "$SCRIPTS_DIR/start_rag_qa_service.sh"
    ;;
  demo)
    require_script "$SCRIPTS_DIR/demo_start.sh"
    exec "$SCRIPTS_DIR/demo_start.sh"
    ;;
  status)
    require_script "$SCRIPTS_DIR/status_all.sh"
    exec "$SCRIPTS_DIR/status_all.sh"
    ;;
  stop)
    require_script "$SCRIPTS_DIR/stop_all.sh"
    exec "$SCRIPTS_DIR/stop_all.sh"
    ;;
  restart)
    require_script "$SCRIPTS_DIR/stop_all.sh"
    require_script "$SCRIPTS_DIR/start_all.sh"
    "$SCRIPTS_DIR/stop_all.sh"
    sleep 1
    exec "$SCRIPTS_DIR/start_all.sh"
    ;;
  *)
    usage
    exit 1
    ;;
esac
