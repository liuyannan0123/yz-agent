#!/bin/bash
set -u

SERVICE_DIR="$HOME"
PYTHON="/opt/homebrew/bin/python3"
LOG_FILE="$HOME/rag_qa_service.log"
PID_MATCH="rag_qa_service.py"

cd "$SERVICE_DIR" || exit 1

/usr/bin/pkill -f "$PID_MATCH" > /dev/null 2>&1 || true
nohup "$PYTHON" rag_qa_service.py > "$LOG_FILE" 2>&1 &
sleep 3

if /usr/bin/curl -s http://127.0.0.1:8093/health > /dev/null 2>&1; then
  echo "RAG QA service started on http://127.0.0.1:8093"
else
  echo "RAG QA service failed to start"
  exit 1
fi
