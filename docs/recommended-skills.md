# AI Agent 新手推薦技能 Top 10

> 這份名單主打低風險、高實用、立竿見影。安裝量高、star 多、惡意報告極少。

---

## 1. self-improving-agent（自我改進/主動代理）

讓 Agent 記住錯誤、自我優化、越來越聰明。新手最容易感受到「哇，變聰明了」。

- 📊 **46k+ installs**，ClawHub 熱門榜第一

---

## 2. tavily-search（聯網搜索）

Tavily API 優化版。沒這個 Agent 就是「井底之蛙」，查不了即時信息。幾乎所有新手必裝第一梯隊。

- 📊 **37k+ installs**，AI Agent 標配

---

## 3. gog（Google Workspace CLI）

Gmail、日曆、Drive、Docs 全家桶。日常辦公/郵件/日程神器，新手最快看到實際自動化效果（讀郵件、加日曆、寫文檔）。

- 📊 **46k+ installs**，超級實用

---

## 4. github（GitHub 集成）

用 gh CLI。能搜代碼、管 issue/PR、創建 repo。新手學代碼/做專案超方便。

- 📊 **35k+ installs**，開發者入門必備

---

## 5. summarize（總結工具）

總結 URL、PDF、圖片、YouTube、音頻。快速消化信息，新手研究東西時超級省力。

- 📊 **36k+ installs**，高頻使用

---

## 6. find-skills（技能搜尋）

讓 Agent 自己去 ClawHub 搜並推薦/安裝技能。解決「不知道裝什麼」的最大痛點，新手最友好。

- 🏷️ 社區反覆推薦的「元技能」

---

## 7. ontology / agent-memory / memory（結構化記憶）

知識圖譜。讓 Agent 真正「記住你」、跨對話連貫，不再健忘。新手交互體驗提升巨大。

- 📊 **35k+ installs**，長期用越用越香

---

## 8. weather（查天氣）

無需 API key。超級簡單、零配置，新手第一個測試技能，成功率 100%，建立信心。

- 📊 **29k+ installs**，入門玩具但實用

---

## 9. proactive-agent（主動代理）

增加主動性，能自己規劃、反覆改進任務。讓 Agent 從「被動回答」變成「主動幫忙」。

- 🏷️ X 上中文社區特別推，新手用後反饋「活了」

---

## 10. skill-vetter / security-audit（安全掃描）

安裝前掃描技能代碼、防惡意。新手安全第一，裝這個後再放心裝別的。

- 🏷️ 安全類必備，社區共識「後悔沒先裝」

---

## 新手安裝建議順序（別一下全裝）

**順序很重要：先安全 + 基礎，再加生產力，最後加高級。**

強烈建議先用以下指令安裝安全掃描技能，再裝別的：

```bash
clawhub install skill-vetter
# 或
npx clawhub@latest install skill-vetter
```

### 建議安裝順序：

1. **第一階段：安全 + 基礎**
   - skill-vetter（安全掃描）
   - weather（建立信心）

2. **第二階段：生產力**
   - tavily-search（聯網搜索）
   - gog（Google 全家桶）
   - summarize（信息總結）

3. **第三階段：進階功能**
   - github（代碼管理）
   - self-improving-agent（自我改進）
   - ontology（記憶系統）
   - proactive-agent（主動代理）
   - find-skills（技能搜尋）

---

## 安裝指令

```bash
# 使用 clawhub 安裝
clawhub install <技能名稱>

# 或使用 npx 安裝
npx clawhub@latest install <技能名稱>
```

---

## 安全提醒

**安全永遠第一：**

- 用隔離環境（Docker）
- 別給敏感權限
- 定期 `clawhub update --all`

---

*資料來源：AI Agent 新手教材 | 整理日期：2026-02-28*
