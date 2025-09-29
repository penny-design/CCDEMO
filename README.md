# WhatsApp抽奖活动系统 🎪

一个基于WhatsApp的专业病毒式传播营销活动工具，帮助商家以最低成本实现用户增长和私域流量沉淀。

## 🎯 项目概览

**产品定位**: H5移动端病毒式传播抽奖活动工具  
**目标用户**: 希望通过低成本社交裂变获取新用户的商家/品牌  
**开发模式**: UI优先的Spec Coding工作流  
**预计工期**: 14周（从设计系统到生产部署）

## 🏗️ 技术架构

### 核心技术栈
- **前端**: Vite + Vanilla TypeScript + TailwindCSS
- **后端**: Supabase (BaaS) + PostgreSQL
- **实时功能**: Supabase Realtime
- **部署**: Vercel/Netlify + Supabase
- **API集成**: WhatsApp Business API

### 性能标准
- 首屏加载时间 <2秒
- 交互响应时间 <100毫秒
- 代码覆盖率 >90%

## 🎨 设计系统

### 品牌关键词
1. **专业 (Professional)** - P0级别
2. **信赖 (Trustworthy)** - P0级别  
3. **高效 (Efficient)** - P1级别
4. **社交 (Social)** - P1级别
5. **增长 (Growth)** - P2级别

### 设计原则
- 强制8pt网格系统
- 品牌关键词驱动设计
- Mobile-first响应式设计
- WCAG 2.1 AA级可访问性标准

## 📱 核心功能

### 用户流程
- **P1 落地页**: 流量入口，展示奖品，引导参与
- **P2 活动主页**: 个人中心，显示抽奖码，邀请管理
- **P3 兑奖页**: 中奖用户填写领奖信息

### 病毒传播机制
- 专属邀请链接生成
- 实时奖励反馈系统
- 社交证明和FOMO营销
- 防刷机制和安全控制

## 📊 项目进度

### 已完成 ✅
- **阶段0**: 项目基础搭建 (100%)
  - 开发环境配置
  - 项目治理文档
  - 品牌关键词定义
  - Git仓库初始化

### 进行中 🚧
- **阶段1**: 核心需求与流程定义
  - 深度PRD分析
  - 用户故事编写
  - 流程图设计

### 计划中 📅
- **阶段2-3**: UI设计系统建设 (Week 3-6)
- **阶段4**: 技术架构设计 (Week 7)
- **阶段5**: 功能模块开发 (Week 8-12)
- **阶段6**: 集成优化与部署 (Week 13-14)

## 📁 项目结构

```
driod-demo1/
├── .claude/           # Claude AI工具配置
│   ├── specs/         # Spec工作流规格文档
│   └── steering/      # 项目治理文档
├── design/            # 设计相关文件
│   ├── style_tiles/   # 风格探索HTML
│   ├── specs/         # 设计规范文档
│   └── prototypes/    # 高保真原型
├── src/               # 源代码目录
├── docs/              # 项目文档
└── tools/             # 开发工具
```

## 🚀 快速开始

### 环境要求
- Node.js 18+
- Git 2.40+
- 现代浏览器支持

### 安装和运行
```bash
# 克隆项目
git clone https://github.com/penny-design/CCDEMO.git
cd CCDEMO

# 设置开发工具
.\setup-tools.bat

# 查看项目状态
git status
```

## 📋 开发规范

### 代码标准
- TypeScript严格模式
- ESLint零错误
- 8pt网格系统强制执行
- 组件化开发模式

### 工作流程
- Spec Coding驱动开发
- 设计系统优先
- 用户确认检查点
- 持续集成和部署

## 📚 相关文档

- [设计执行规范](./DESIGN_GUIDELINES.md)
- [项目任务计划](./PROJECT_TASK_PLAN.md)
- [品牌关键词定义](./design/Brand_Keywords.md)
- [产品需求文档](./docs/WhatsApp抽奖活动PRD_v1.0.md)

## 🤝 贡献指南

1. Fork项目到您的账户
2. 创建特性分支 (`git checkout -b feature/amazing-feature`)
3. 遵循代码规范和设计标准
4. 提交变更 (`git commit -m 'Add amazing feature'`)
5. 推送分支 (`git push origin feature/amazing-feature`)
6. 创建Pull Request

## 📄 许可证

本项目采用MIT许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 📞 联系方式

项目维护者: WhatsApp抽奖活动系统团队  
邮箱: dev@whatsapp-lottery.com

---

**⭐ 如果这个项目对您有帮助，请考虑给它一个星标！**
