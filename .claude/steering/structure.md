# 项目结构约定 - WhatsApp抽奖活动系统

## 📁 项目目录结构

### 根目录结构
```
driod-demo1/
├── .claude/                    # Claude AI工具配置
│   ├── specs/                  # Spec工作流规格文档
│   └── steering/               # 项目治理文档
├── design/                     # 设计相关文件
│   ├── style_tiles/           # 风格探索HTML
│   ├── specs/                 # 设计规范文档
│   └── prototypes/            # 高保真原型
├── src/                       # 源代码目录
│   ├── components/            # 可复用组件
│   ├── pages/                 # 页面组件
│   ├── utils/                 # 工具函数
│   ├── types/                 # TypeScript类型定义
│   ├── styles/                # 样式文件
│   ├── assets/                # 静态资源
│   └── config/                # 配置文件
├── docs/                      # 项目文档
├── tests/                     # 测试文件
├── public/                    # 公共静态资源
└── dist/                      # 构建输出目录
```

### 详细目录说明

#### `.claude/` - AI工具配置
```
.claude/
├── specs/                     # Spec Coding工作流规格
│   ├── core-requirements/     # 需求规格
│   ├── ui-prototypes/         # UI原型规格
│   ├── tech-architecture/     # 技术架构规格
│   └── system-integration/    # 系统集成规格
└── steering/                  # 项目治理文档
    ├── product.md             # 产品愿景和目标
    ├── tech.md                # 技术标准和规范
    └── structure.md           # 项目结构约定 (本文档)
```

#### `design/` - 设计文件
```
design/
├── style_tiles/               # 风格探索 (阶段2.1)
│   ├── direction_a.html       # 专业信赖风格
│   ├── direction_b.html       # 年轻活力风格
│   └── direction_c.html       # 社交病毒风格
├── specs/                     # 设计规范 (阶段2.2)
│   ├── Design_Spec.md         # 完整设计规范
│   ├── CSS_Variables_Mapping.md    # CSS变量映射
│   ├── Component_Implementation_Guide.md  # 组件实现指南
│   └── Design_QA_Checklist.md     # 设计验收标准
├── prototypes/                # 高保真原型 (阶段3)
│   ├── p1-landing-page.html   # 落地页原型
│   ├── p2-activity-dashboard.html  # 活动主页原型
│   ├── p3-redemption-page.html     # 兑奖页原型
│   └── admin-dashboard.html   # 管理后台原型
├── Style_Guide.html           # 可视化样式指南
├── Flowchart.md              # 用户流程图
└── assets/                    # 设计相关资源
    ├── images/                # 设计稿图片
    ├── icons/                 # 图标资源
    └── fonts/                 # 字体文件
```

#### `src/` - 源代码
```
src/
├── components/                # 可复用组件
│   ├── common/               # 通用组件
│   │   ├── Button/           # 按钮组件
│   │   ├── Card/             # 卡片组件
│   │   ├── Modal/            # 弹窗组件
│   │   └── Toast/            # 提示组件
│   ├── forms/                # 表单组件
│   │   ├── Input/            # 输入框组件
│   │   ├── Select/           # 选择器组件
│   │   └── Validator/        # 验证组件
│   └── business/             # 业务组件
│       ├── PrizeList/        # 奖品列表组件
│       ├── Countdown/        # 倒计时组件
│       └── Marquee/          # 跑马灯组件
├── pages/                    # 页面组件
│   ├── Landing/              # 落地页 (P1)
│   ├── Dashboard/            # 活动主页 (P2)
│   ├── Redemption/           # 兑奖页 (P3)
│   └── Admin/                # 管理后台
├── utils/                    # 工具函数
│   ├── api.ts                # API调用工具
│   ├── storage.ts            # 本地存储工具
│   ├── validation.ts         # 验证工具
│   └── constants.ts          # 常量定义
├── types/                    # TypeScript类型
│   ├── api.ts                # API接口类型
│   ├── user.ts               # 用户相关类型
│   ├── activity.ts           # 活动相关类型
│   └── common.ts             # 通用类型
├── styles/                   # 样式文件
│   ├── globals.css           # 全局样式
│   ├── variables.css         # CSS变量定义
│   ├── components.css        # 组件样式
│   └── utilities.css         # 工具类样式
├── assets/                   # 静态资源
│   ├── images/               # 图片资源
│   ├── icons/                # 图标文件
│   └── fonts/                # 字体文件
├── config/                   # 配置文件
│   ├── supabase.ts           # Supabase配置
│   ├── whatsapp.ts           # WhatsApp API配置
│   └── app.ts                # 应用配置
└── main.ts                   # 应用入口文件
```

## 📋 文件命名约定

### 通用规则
- **目录名**: kebab-case (例: `user-profile/`)
- **组件文件**: PascalCase (例: `UserProfile.ts`)
- **工具文件**: camelCase (例: `userUtils.ts`)
- **样式文件**: kebab-case (例: `user-profile.css`)
- **测试文件**: 原文件名 + `.test` (例: `UserProfile.test.ts`)

### 组件文件结构
```
components/Button/
├── index.ts                  # 导出入口
├── Button.ts                 # 主组件文件
├── Button.css                # 组件样式
├── Button.test.ts            # 组件测试
└── types.ts                  # 组件类型定义
```

### 页面文件结构
```
pages/Landing/
├── index.ts                  # 导出入口
├── Landing.ts                # 主页面文件
├── Landing.css               # 页面样式
├── Landing.test.ts           # 页面测试
├── components/               # 页面专用组件
└── hooks/                    # 页面专用hooks
```

## 📝 代码组织原则

### 模块化原则
1. **单一职责**: 每个模块只负责一个功能
2. **松耦合**: 模块间依赖关系清晰最小
3. **高内聚**: 相关功能聚集在同一模块
4. **可复用**: 通用功能抽取为独立模块

### 导入导出约定
```typescript
// 使用绝对路径导入
import { Button } from '@/components/common/Button';
import { userApi } from '@/utils/api';

// 统一的导出方式
export { Button } from './Button';
export type { ButtonProps } from './types';
```

### 类型定义约定
```typescript
// 接口命名: I前缀 + PascalCase
interface IUser {
  id: string;
  phone: string;
}

// 类型别名: PascalCase
type UserStatus = 'active' | 'inactive' | 'pending';

// 枚举: PascalCase
enum ActivityStatus {
  DRAFT = 'draft',
  ACTIVE = 'active',
  ENDED = 'ended'
}
```

## 🎯 Spec工作流集成

### Spec规格文档结构
```
.claude/specs/{spec-name}/
├── requirements.md           # 需求规格
├── design.md                # 设计规格
├── implementation.md         # 实现规格
└── testing.md               # 测试规格
```

### Spec命名约定
- `core-requirements` - 核心需求规格
- `ui-prototypes` - UI原型规格
- `tech-architecture` - 技术架构规格
- `design-system-code` - 设计系统代码规格
- `page-state-management` - 页面状态管理规格
- `user-activation` - 用户激活系统规格
- `viral-invitation` - 病毒式邀请系统规格
- `lottery-redemption` - 抽奖兑奖系统规格
- `system-integration` - 系统集成规格

## 📦 构建和部署结构

### 构建配置
```
配置文件/
├── vite.config.ts            # Vite构建配置
├── tailwind.config.js        # TailwindCSS配置
├── tsconfig.json             # TypeScript配置
├── eslint.config.js          # ESLint配置
├── jest.config.js            # Jest测试配置
└── playwright.config.ts      # Playwright E2E配置
```

### 环境配置
```
environments/
├── .env                      # 本地环境变量
├── .env.development          # 开发环境
├── .env.staging              # 测试环境
├── .env.production           # 生产环境
└── .env.example              # 环境变量示例
```

## 📊 文档管理

### 文档分类
- **用户文档**: 面向最终用户的使用指南
- **开发文档**: 面向开发者的技术文档
- **设计文档**: 面向设计师的设计规范
- **运维文档**: 面向运维的部署和维护指南

### 文档版本管理
- 所有文档都有版本号和更新日期
- 重要变更必须在changelog中记录
- 文档与代码版本保持同步

## ✅ 结构检查清单

### 项目初始化检查
- [ ] 所有必要目录已创建
- [ ] 基础配置文件已设置
- [ ] Git仓库已初始化
- [ ] 依赖项已安装

### 开发过程检查
- [ ] 新文件遵循命名约定
- [ ] 代码组织符合模块化原则
- [ ] 导入路径使用绝对路径
- [ ] 类型定义完整准确

### 发布前检查
- [ ] 构建输出结构正确
- [ ] 静态资源路径正确
- [ ] 环境配置适用于目标环境
- [ ] 文档更新完整

---

**文档版本**: v1.0  
**最后更新**: 2024年9月29日  
**负责人**: 架构团队  
**审核周期**: 每月评审更新
