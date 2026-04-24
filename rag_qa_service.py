#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Git 提交版占位服务。

说明：
- 本文件只保留公开仓库可展示的服务壳与接口形态。
- 完整的知识检索、快答、OCR、结构化抽取、混合重排等核心逻辑已拆分为私有模块，
  不包含在当前 Git 提交版中。
- 如果需要运行完整版，请使用私有发布包中的实现替换本文件，或按内部文档接入私有包。
"""

import os
from flask import Flask, jsonify

PORT = int(os.environ.get("AI_AGENT_RAG_PORT", "8093"))

app = Flask(__name__)

HTML_PAGE = """<!doctype html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>瑶知 Git 提交版</title>
  <style>
    body {
      margin: 0;
      padding: 40px 20px;
      font: 16px/1.7 "Microsoft YaHei", sans-serif;
      background: linear-gradient(180deg, #f8efff, #efe5ff 60%, #f9f6ff);
      color: #2c2444;
    }
    .card {
      max-width: 900px;
      margin: 0 auto;
      background: rgba(255,255,255,.86);
      border: 1px solid rgba(96,77,166,.14);
      border-radius: 24px;
      padding: 28px;
      box-shadow: 0 24px 60px rgba(81, 60, 146, 0.12);
    }
    h1 { margin-top: 0; }
    code {
      padding: 2px 6px;
      border-radius: 8px;
      background: rgba(122,90,215,.10);
      color: #6a4eb4;
    }
  </style>
</head>
<body>
  <section class="card">
    <h1>瑶知 Git 提交版</h1>
    <p>当前目录是用于 Git 提交和项目展示的公开版本。</p>
    <p>完整的知识库问答、快答规则、OCR 预处理、结构化抽取和私有业务逻辑未包含在此公开版本中。</p>
    <p>如需运行完整版，请按 <code>PRIVATE-INTEGRATION.zh-CN.md</code> 的说明接入私有发布包。</p>
  </section>
</body>
</html>
"""


@app.route("/", methods=["GET"])
def index():
    return HTML_PAGE


@app.route("/health", methods=["GET"])
def health():
    return jsonify({
        "status": "ok",
        "edition": "git-public",
        "message": "当前为 Git 提交版，占位服务正常。",
        "port": PORT,
    })


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=PORT)
