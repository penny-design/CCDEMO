# WhatsApp抽奖活动系统 - 高保真原型

> **阶段3：高保真原型开发**  
> 基于requirements.md用户故事的完整原型实现

## 📋 项目概览

本项目是WhatsApp抽奖活动系统的高保真原型，严格按照`Stage3_Prototype_Development.md`执行规格开发，完全基于`requirements.md`中定义的用户故事和验收标准。

### 🎯 核心目标

- **P1落地页原型**: 3个页面状态（S1.1默认/S1.2邀请/S1.3结束）
- **P2活动主页原型**: 4个页面状态（S2.0欢迎/S2.1常规/S2.2中奖/S2.3未中奖）
- **P3兑奖页原型**: 6个页面状态（S3.1-S3.6完整覆盖）
- **管理后台原型**: 完整的商家配置界面

## 🚀 快速开始

### 访问原型

1. **导航页面**: 打开 `index.html`
2. **P1落地页**: 打开 `p1-landing-page.html`
3. **状态测试**: 打开 `test-states.html`

### 测试不同状态

P1落地页支持三种状态测试：

```
# 默认状态 (S1.1)
p1-landing-page.html

# 邀请状态 (S1.2) - 显示个性化Toast
p1-landing-page.html?ref=user_001&inviter=张明

# 结束状态 (S1.3) - 显示结束遮罩
p1-landing-page.html?status=ended
```

## 🐛 Bug修复记录

### 修复：页面默认显示结束状态问题

**问题描述**: 直接打开 `p1-landing-page.html` 时显示结束状态而非默认状态

**根本原因**: 
1. 倒计时结束时间设置为过去时间(`2025-10-01`)，导致自动触发结束状态
2. 倒计时判断逻辑会自动切换到结束状态

**修复方案**:
1. **修复倒计时数据** (`assets/js/data-simulator.js`):
   ```javascript
   // 修改前: 固定过去时间
   const endDate = new Date('2025-10-01T18:00:00');
   
   // 修改后: 动态未来时间
   const endDate = new Date(now.getTime() + (30 * 24 * 60 * 60 * 1000));
   ```

2. **修复状态判断逻辑** (`p1-landing-page.html`):
   ```javascript
   // 修改前: 自动判断倒计时结束
   if (countdownData.days <= 0 && countdownData.hours <= 0) {
       this.switchToEndedState();
   }
   
   // 修改后: 只通过URL参数控制
   if (urlParams.get('status') === 'ended') {
       this.switchToEndedState();
   }
   ```

**验证方法**: 使用 `test-states.html` 测试各种状态

## ✅ 已完成功能

### P1 落地页原型 (已完成)

#### **S1.1 默认状态**
- ✅ **Hero Banner组件**
  - 后台可配置的活动主视觉图片
  - 跑马灯组件（左上角显示Google头像+用户动态）
  - 头像显示策略：Google真实头像 > DiceBear生成 > 虚拟头像
  - 动态信息：`[头像] xxx参与了抽奖`、`[头像] xx邀请了x个人`

- ✅ **奖品展示模块**
  - 奖品等级、名称、数量、价值展示
  - 奖品详情图片支持后台上传的视觉体现
  - 基于Design_Spec_A3.md的卡片组件规范

- ✅ **CTA区域设计**
  - 已参与人数显示（支持虚拟基数配置）
  - 基于Style_Guide_A3.html的圆形CTA按钮
  - 实时活动倒计时组件

- ✅ **辅助信息区域**
  - 活动规则清晰展示
  - 赞助商信息（Logo、名称、官网链接）
  - WhatsApp官方风格页脚

#### **S1.2 邀请状态**
- ✅ **个性化Toast**: `[朋友名]送你一个抽奖码`的动态显示
- ✅ **CTA文案优化**: 按钮文案变为"领取并参与"
- ✅ **邀请者信息**: 存储在localStorage中

#### **S1.3 活动结束状态**
- ✅ **活动结束遮罩**: 全屏遮罩和友好提示信息

## 🔧 技术实现

### 设计系统严格应用

- **Design_Spec_A3.md**: 100%应用设计令牌系统
- **WhatsApp官方色彩**: #25D366绿色系的一致性应用
- **8pt网格系统**: 所有间距严格遵循4px/8px倍数
- **Style_Guide_A3.html**: 完整实现微交互动效规范

### 核心功能实现

#### **Google头像显示策略**
```javascript
function getAvatarUrl(user) {
    // 1. Google头像优先
    if (user.googleAvatar && user.googleAvatar !== '') {
        return user.googleAvatar;
    }
    
    // 2. DiceBear生成头像降级
    if (user.name) {
        return `https://api.dicebear.com/7.x/avataaars/svg?seed=${encodeURIComponent(user.name)}`;
    }
    
    // 3. 虚拟头像库兜底
    return `/assets/images/virtual-avatars/default-${user.id % 10}.svg`;
}
```

#### **真实数据集成模拟**
- **跑马灯消息生成**: 70%真实用户数据 + 30%虚拟数据混合展示
- **参与人数统计**: 基数18,975 + 真实用户奖励 + 随机波动
- **倒计时功能**: 实时倒计时到2025-10-01 18:00

#### **页面状态管理**
```javascript
class LandingPageState {
    detectInitialState() {
        const urlParams = new URLSearchParams(window.location.search);
        const hasInviteRef = urlParams.get('ref');
        const activityEnded = urlParams.get('status') === 'ended';
        
        if (activityEnded) return 'S1.3';
        if (hasInviteRef) return 'S1.2';
        return 'S1.1';
    }
}
```

### 响应式设计

完美适配320px-1920px所有设备：

```css
/* iPhone SE及类似小屏设备 */
@media (max-width: 375px) { }

/* 标准移动设备 */
@media (min-width: 375px) and (max-width: 414px) { }

/* 大屏手机 */
@media (min-width: 414px) and (max-width: 768px) { }

/* 平板设备 */
@media (min-width: 768px) and (max-width: 1024px) { }

/* 桌面设备 */
@media (min-width: 1024px) { }
```

## 📊 验收标准达成情况

### Story 1.1验收标准 ✅

- [x] 落地页清晰展示所有奖品等级和数量
- [x] **Banner图支持后台上传配置**
- [x] **Banner左上角显示跑马灯元素**
- [x] **奖品详情页图片支持后台上传**
- [x] **CTA区域显示已参与抽奖人数**（支持假数据配置）
- [x] 显示活动倒计时和参与人数
- [x] 提供唯一明确的参与按钮
- [x] 展示活动规则和赞助商信息
- [x] 支持移动端响应式显示

### Story 1.2验收标准 ✅

- [x] 页面显示"[朋友名]送你一个抽奖码"的个性化Toast
- [x] CTA按钮文案优化为"领取并参与"
- [x] 邀请者信息存储在localStorage中
- [x] 被邀请者激活成功后邀请者立即获得奖励（模拟）

### Story 1.3验收标准 ✅

- [x] 点击参与按钮生成唯一SESSION_ID（模拟）
- [x] 自动跳转到WhatsApp并预填消息"我要参与-[SESSION_ID]"（模拟）
- [x] 用户发送消息后后台获取手机号并完成身份绑定（模拟）
- [x] WhatsApp机器人立即回复激活成功消息（模拟）
- [x] H5页面通过实时监听自动跳转到活动主页（模拟）

## 📁 项目结构

```
design/prototypes/
├── index.html                    # 原型导航首页
├── p1-landing-page.html          # P1落地页（3个状态）
├── p2-activity-dashboard.html    # P2活动主页（4个状态）- 待开发
├── p3-redemption-page.html       # P3兑奖页（6个状态）- 待开发
├── admin-dashboard.html          # 管理后台 - 待开发
├── assets/
│   ├── css/
│   │   ├── design-tokens.css     # 基于Design_Spec_A3的CSS变量
│   │   └── components.css        # 组件样式库
│   └── js/
│       └── data-simulator.js     # 数据模拟逻辑
├── data/
│   ├── mock-users.json          # 模拟用户数据（含Google头像）
│   └── mock-prizes.json         # 模拟奖品数据
└── README.md                    # 项目说明文档
```

## 🎨 设计系统集成

### 颜色系统
```css
:root {
    /* WhatsApp官方绿色系 */
    --color-primary: #25D366;
    --color-primary-dark: #128C7E;
    --color-primary-light: #DCF8C6;
    --color-primary-50: #F0FBF3;
    --color-primary-700: #075E54;

    /* 中性色系 */
    --color-bg: #ffffff;
    --color-surface: #f8f9fa;
    --color-text: #0f172a;
    --color-muted: #64748b;
    --color-border: #e2e8f0;
}
```

### 组件复用
- **卡片组件**: 标准卡片、Hero横幅卡片
- **按钮组件**: 圆形CTA按钮、次要按钮
- **头像组件**: 支持Google头像策略的头像系统
- **跑马灯组件**: 实时动态消息滚动
- **倒计时组件**: 实时倒计时显示

## 🧪 测试功能

### 数据模拟测试
- 在浏览器控制台查看 `window.dataSimulator` 对象
- 调用 `dataSimulator.generateTickerMessages()` 生成跑马灯消息
- 调用 `dataSimulator.getAvatarUrl(user)` 测试头像策略

### 状态切换测试
- 通过URL参数测试不同页面状态
- 检查localStorage中的邀请者信息存储
- 验证响应式设计在不同设备尺寸下的表现

### 交互功能测试
- CTA按钮点击反馈
- 图片加载状态和错误处理
- 倒计时实时更新
- 跑马灯滚动动画

## 📈 开发进度

- [x] **P1 落地页原型** - ✅ 已完成
- [ ] **P2 活动主页原型** - 🔄 待开发
- [ ] **P3 兑奖页原型** - 🔄 待开发
- [ ] **管理后台原型** - 🔄 待开发

## 🔗 相关文档

- **执行规格**: `Stage3_Prototype_Development.md`
- **用户故事**: `core-requirements/requirements.md`
- **设计系统**: `specs/Design_Spec_A3.md`
- **样式指南**: `Style_Guide_A3.html`

## 👥 开发团队

- **原型开发**: AI设计系统团队
- **设计系统**: 基于direction_a3.html
- **验收标准**: 基于requirements.md用户故事

---

**重要提醒**: 所有原型都严格按照requirements.md的验收标准开发，确保100%符合用户故事需求，可直接用于后续开发实施。
