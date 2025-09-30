# 阶段3：高保真原型开发 - 执行任务规格 (Stage 3: High-Fidelity Prototype Development)

## 📋 **文档信息**
**文档名称**: Stage3_Prototype_Development.md  
**创建日期**: 2025年1月26日  
**版本**: v1.0  
**基于**: core-requirements v1.0, Design_Spec_A3.md, Style_Guide_A3.html  
**状态**: 待执行  

---

## 🎯 **阶段3任务概览**

基于已完成的设计系统（direction_a3.html + Design_Spec_A3.md + Style_Guide_A3.html）和完整的requirements.md用户故事，精确实现13个页面状态的高保真原型开发。

### **核心交付目标**
- **P1落地页原型**: 3个页面状态（S1.1默认/S1.2邀请/S1.3结束）
- **P2活动主页原型**: 4个页面状态（S2.0被邀请者欢迎/S2.1开奖前/S2.2中奖庆祝/S2.3未中奖鼓励）  
- **P3兑奖页原型**: 6个页面状态（S3.1实物/S3.2虚拟/S3.3成功/S3.4失效/S3.5已领取/S3.6WhatsApp个人号）
- **管理后台原型**: 完整的商家配置界面

### **设计系统依据**
- **设计风格**: 基于direction_a3.html的WhatsApp官方专业型
- **设计规范**: 严格遵循Design_Spec_A3.md的色彩、字体、间距系统
- **交互动效**: 完全实现Style_Guide_A3.html的动效规范
- **品牌关键词**: 专业、信赖、透明、高效、权威

### **质量标准**
- **设计还原度**: 100%符合Design_Spec_A3.md规范
- **视觉一致性**: 1:1还原WhatsApp官方专业型设计风格  
- **代码质量**: 生产级代码质量，可直接用于开发实施
- **响应式适配**: 320px-1920px完美响应式适配
- **交互完整性**: 所有用户故事验收标准在原型中可验证

---

## 🗓️ **详细执行计划**

### **任务3.1: P1落地页原型开发 (2天)**

#### **Day 1: 核心状态实现 (S1.1 默认状态)**
**文件**: `design/prototypes/p1-landing-page.html`

**S1.1 默认状态开发重点**:

1. **Hero Banner组件** (基于direction_a3.html设计)
   ```html
   <!-- 核心Banner结构 -->
   <section class="hero-banner" role="img" aria-label="活动展示">
       <div class="banner-image">
           <!-- 后台可配置的活动主视觉 -->
       </div>
       <div class="ticker-overlay">
           <!-- 跑马灯：xxx参与了抽奖 -->
       </div>
   </section>
   ```
   - **后台可配置**: 活动主视觉图片上传展示
   - **跑马灯组件**: 左上角显示用户动态
   - **头像显示策略**: DiceBear生成 > 虚拟上传 > 默认头像
   - **动态信息**: "[头像] xxx参与了抽奖"、"[头像] xx邀请了x个人"

2. **奖品展示模块** (基于requirements.md Epic 1 Story 1.1)
   ```html
   <!-- 奖品清单展示 -->
   <section class="prize-showcase">
       <h2>活动奖品</h2>
       <div class="prize-grid">
           <!-- 奖品详情图片支持后台上传 -->
       </div>
   </section>
   ```
   - **奖品详情**: 等级、名称、数量、价值展示
   - **图片管理**: 奖品详情图片支持后台上传配置
   - **卡片设计**: 基于Design_Spec_A3.md的卡片组件规范
   - **实现对齐**: 当前P1采用极简“文本清单”样式（与抽奖助手一致），奖品图片卡片为后续可切换选项

3. **CTA区域设计** (基于Story 1.1验收标准)
   ```html
   <!-- 参与按钮和数据展示 -->
   <section class="cta-section">
       <div class="participation-stats">
           <!-- 已参与人数显示（支持虚拟基数配置） -->
       </div>
       <button class="btn-cta-round">
           <!-- 唯一明确的参与按钮 -->
       </button>
   </section>
   ```
   - **参与人数**: 显示已参与抽奖人数（支持假数据配置）
   - **主CTA按钮**: 基于Style_Guide_A3.html的圆形CTA设计
   - **活动倒计时**: 实时倒计时组件
   - **交互规范（WhatsApp优先）**:
     - 点击CTA后立即生成 `SESSION_ID`，按钮进入加载态（文案改为“参与中”，禁用防重复点击）
     - 立刻唤醒 WhatsApp：`wa.me/<business_number>?text=我要参与-[SESSION_ID]`
     - 未跳转兜底：2.5s 后恢复按钮状态

4. **辅助信息区域**
   - **活动规则**: 清晰的规则说明展示
   - **赞助商信息**: Logo、名称、官网链接
   - **页脚信息**: 基础页脚组件

#### **Day 2: 状态变化和交互完善**

**S1.2 邀请状态开发** (基于Story 1.2):
```javascript
// 邀请状态逻辑
if (hasInviteRef) {
    showPersonalizedToast('[朋友名]送你一个抽奖码');
    updateCTAButton('领取并参与');
    storeInviterInfo(localStorage);
}
```
- **个性化Toast**: "[朋友名]送你一个抽奖码"的动态显示
- **CTA文案优化**: 按钮文案变为"领取并参与"
- **邀请者信息**: 存储在localStorage中

**S1.3 活动结束状态**:
```html
<!-- 活动结束遮罩 -->
<div class="activity-ended-overlay">
    <div class="ended-message">
        <h2>活动已结束</h2>
        <p>感谢您的关注，请关注下期活动</p>
    </div>
</div>
```

**响应式和交互优化**:
- **响应式测试**: 320px/375px/414px/768px/1024px全覆盖
- **微交互动效**: 基于Style_Guide_A3.html的动效规范
- **跑马灯动画**: 60fps流畅滚动效果
- **触摸优化**: H5端完美触摸体验

**验收标准检查**:
- [ ] 所有Story 1.1验收标准100%满足
- [ ] 跑马灯头像显示策略正确实现
- [ ] 奖品展示支持后台配置的视觉体现
- [ ] CTA区域参与人数配置功能展示
- [ ] 三个状态切换流畅自然
 - [ ] 点击CTA后按钮文案变为“参与中”并禁用，立即唤醒WhatsApp

---

### **任务3.2: P2活动主页原型开发 (2天)**

#### **Day 1: 用户状态核心功能 (S2.0 & S2.1)**
**文件**: `design/prototypes/p2-activity-dashboard.html`

**S2.0 首次访问被邀请者状态** (基于页面结构定义):
```html
<!-- 欢迎礼物视图 -->
<section class="welcome-gift-view">
    <div class="welcome-header">
        <h1>欢迎 <span class="user-nickname">[昵称]</span>!</h1>
        <div class="gift-message">
            <p>[邀请者姓名] 为你准备了专属抽奖码</p>
        </div>
    </div>
</section>
```

**S2.1 开奖前常规状态** (基于Story 2.1 & 2.2):

1. **用户身份展示区**
   ```html
   <!-- 用户信息展示 -->
   <header class="user-identity">
       <div class="user-avatar">
           <!-- 展示头像（DiceBear/默认） -->
       </div>
       <div class="user-info">
           <h2>[昵称]</h2>
           <p class="phone-masked">[脱敏手机号]</p>
       </div>
   </header>
   ```
- **身份标识**: 显示昵称与头像（DiceBear/默认）
   - **脱敏信息**: 安全展示手机号码

2. **抽奖码管理模块**
   ```html
   <!-- 抽奖码信息卡片 -->
   <section class="lottery-codes-card">
       <div class="codes-summary">
           <h3>当前抽奖码</h3>
           <div class="codes-count">[总数]</div>
       </div>
       <button class="view-all-btn">查看全部</button>
   </section>
   ```
   - **突出显示**: 当前拥有的抽奖码总数
   - **详细查看**: "查看全部"按钮展示抽奖码列表

3. **常驻邀请CTA/Toast** (基于Story 2.2核心功能)
   ```html
   <!-- 邀请任务卡片 -->
   <section class="invite-task-card">
       <div class="invite-cta-toast">
           <p>送好友抽奖码，你可以额外获得X个抽奖码，送的越多你也可以获得更多抽奖码</p>
       </div>
       <div class="whatsapp-share-actions">
           <button class="share-to-groups">分享到群组</button>
           <button class="share-to-contacts">分享给联系人</button>
       </div>
   </section>
   ```
   - **利他分享文案**: 强调"帮助朋友"的心理设计
   - **一键WhatsApp分享**: 支持群组和个人联系人分享
   - **参考微信体验**: 流畅的分享交互体验

#### **Day 2: 开奖后状态实现 (S2.2 & S2.3)**

**S2.2 中奖庆祝状态** (基于Story 3.1):
```html
<!-- 中奖庆祝视图 -->
<section class="winner-celebration">
    <header class="celebration-header">
        <h1 class="winner-title">恭喜！你已中奖</h1>
    </header>
    
    <!-- 核心奖品卡片 -->
    <div class="prize-card winner-card">
        <div class="prize-info">
            <h3>[奖品等级]</h3>
            <p>[具体奖品名称]</p>
        </div>
    </div>
    
    <!-- 主要CTA -->
    <button class="btn-redeem-now">立即兑奖</button>
    
    <!-- 分等级中奖者公示 -->
    <section class="winners-announcement">
        <div class="first-prize-winners">
            <h4>一等奖中奖者</h4>
            <!-- [头像] [脱敏昵称] -->
        </div>
        <div class="second-prize-winners">
            <h4>二等奖中奖者</h4>
            <!-- [头像] [脱敏昵称] -->
        </div>
        <div class="third-prize-winners">
            <h4>三等奖中奖者</h4>
            <!-- [头像] [脱敏昵称] -->
        </div>
    </section>
</section>
```

**S2.3 未中奖鼓励状态** (基于Story 3.2):
```html
<!-- 未中奖鼓励视图 -->
<section class="encouragement-view">
    <header class="encouragement-header">
        <h1 class="encourage-title">感谢参与</h1>
    </header>
    
    <!-- 核心鼓励卡片 -->
    <div class="encourage-card">
        <div class="encourage-message">
            <p>虽然这次没有中奖，但你的参与让活动更精彩</p>
        </div>
    </div>
    
    <!-- 主要CTA -->
    <button class="btn-next-activity">关注下期活动</button>
    
    <!-- 相同的分等级中奖者公示 -->
    <section class="winners-announcement">
        <!-- 与S2.2完全相同的设计 -->
    </section>
</section>
```

**关键设计要点**:
- **信息层次**: 个人状态 → 主要CTA → 分等级公示
- **设计一致性**: S2.2和S2.3的页面结构和样式保持一致
- **积极心理**: 避免"很遗憾"等负面词汇
- **透明度**: 两种状态都显示相同的中奖者公示信息

**验收标准检查**:
- [ ] Story 2.1和2.2的所有验收标准满足
- [ ] 常驻邀请CTA/Toast正确实现
- [ ] 一键WhatsApp分享功能展示
- [ ] 分等级中奖者公示在两种状态下完全一致
- [ ] 昵称与头像显示策略正确

---

### **任务3.3: P3兑奖页原型开发 (2天)**

#### **Day 1: 核心兑奖功能开发**
**文件**: `design/prototypes/p3-redemption-page.html`

**通用组件开发** (基于Story 3.3):

1. **Token透明展示组件**
   ```html
   <!-- Token显示区域 -->
   <section class="token-display">
       <h2>兑奖验证码</h2>
       <div class="token-container">
           <code class="token-value">[一次性验证Token]</code>
           <button class="copy-token-btn">复制</button>
       </div>
       <p class="token-notice">请保存此验证码，兑奖时需要提供</p>
   </section>
   ```

2. **客服支持常驻组件**
   ```html
   <!-- 悬浮客服按钮 -->
   <div class="floating-support">
       <button class="support-btn">
           <i class="fab fa-whatsapp"></i>
           有疑问？联系客服
       </button>
   </div>
   ```
   - **悬浮位置**: 页面右下角常驻显示
   - **一键跳转**: 直接打开WhatsApp客服对话
   - **后台配置**: 支持配置客服个人号

**S3.1 实物奖品兑奖状态**:
```html
<!-- 实物奖品兑奖表单 -->
<section class="physical-prize-redemption">
    <div class="prize-confirmation">
        <h3>[奖品名称]</h3>
        <p>请填写收货信息完成兑奖</p>
    </div>
    
    <form class="redemption-form">
        <div class="form-group">
            <label>收件人姓名</label>
            <input type="text" required>
        </div>
        <div class="form-group">
            <label>联系电话</label>
            <input type="tel" required>
        </div>
        <div class="form-group">
            <label>收货地址</label>
            <div class="address-selector">
                <!-- 省市区三级联动 -->
            </div>
            <textarea placeholder="详细地址"></textarea>
        </div>
        <button type="submit" class="submit-redemption">提交兑奖信息</button>
    </form>
</section>
```

**S3.2 虚拟奖品兑奖状态**:
```html
<!-- 虚拟奖品兑奖 -->
<section class="virtual-prize-redemption">
    <div class="prize-confirmation">
        <h3>[虚拟奖品名称]</h3>
        <p>您的兑换码如下，请复制保存</p>
    </div>
    
    <div class="redemption-code">
        <code class="exchange-code">[兑换码]</code>
        <button class="copy-code-btn">复制兑换码</button>
    </div>
    
    <div class="usage-instructions">
        <h4>使用说明</h4>
        <ol>
            <li>复制上方兑换码</li>
            <li>访问 [兑换网站/应用]</li>
            <li>输入兑换码完成兑换</li>
        </ol>
    </div>
</section>
```

#### **Day 2: 多种兑奖方式和状态管理**

**S3.6 WhatsApp个人号兑奖** (基于Story 3.3验收标准):
```html
<!-- WhatsApp个人号兑奖流程 -->
<section class="whatsapp-redemption">
    <div class="redemption-guide">
        <h3>联系客服完成兑奖</h3>
        <p>添加客服WhatsApp个人号，发送兑奖信息即可完成兑奖</p>
    </div>
    
    <div class="customer-service-info">
        <div class="service-number">
            <label>客服WhatsApp号码</label>
            <div class="whatsapp-number">
                <span>[客服个人号]</span>
                <button class="copy-number">复制号码</button>
            </div>
        </div>
        
        <div class="message-template">
            <label>标准话术模板</label>
            <div class="template-text">
                <code>我是活动中奖用户，兑奖码: [TOKEN]</code>
                <button class="copy-template">复制话术</button>
            </div>
        </div>
    </div>
    
    <div class="redemption-steps">
        <h4>兑奖步骤</h4>
        <ol>
            <li>复制客服WhatsApp号码</li>
            <li>添加客服为联系人</li>
            <li>发送标准话术和兑奖码</li>
            <li>等待客服确认并处理</li>
        </ol>
        <p class="save-reminder">建议截图保存此页面信息</p>
    </div>
</section>
```

**其他状态页面开发**:

**S3.3 领取成功确认**:
```html
<section class="redemption-success">
    <div class="success-icon">✅</div>
    <h2>兑奖信息提交成功</h2>
    <p>我们将在3-5个工作日内处理您的兑奖申请</p>
    <div class="next-steps">
        <p>请保存页面截图作为凭证</p>
        <button class="screenshot-guide">如何截图保存</button>
    </div>
</section>
```

**S3.4 链接无效或过期**:
```html
<section class="invalid-link">
    <div class="error-icon">⚠️</div>
    <h2>兑奖链接已失效</h2>
    <p>链接可能已过期或无效，请联系客服获取帮助</p>
    <button class="contact-support">联系客服</button>
</section>
```

**S3.5 奖品已被领取**:
```html
<section class="already-claimed">
    <div class="info-icon">ℹ️</div>
    <h2>此奖品已被领取</h2>
    <p>该兑奖码已使用，如有疑问请联系客服</p>
</section>
```

**安全性功能实现**:
- **Token一次性验证**: 防止重复使用
- **链接滥用防护**: 时效性和唯一性验证
- **防重复领取**: 状态标记和验证机制

**验收标准检查**:
- [ ] Story 3.3的所有验收标准满足
- [ ] Token透明展示功能正确实现
- [ ] 客服支持悬浮按钮在所有状态可用
- [ ] 三种兑奖方式完整实现
- [ ] WhatsApp个人号兑奖流程清晰
- [ ] 6个状态页面全部实现

---

### **任务3.4: 管理后台原型开发 (1天)**

#### **管理后台完整功能开发**
**文件**: `design/prototypes/admin-dashboard.html`

基于Story 4.1验收标准的管理后台开发:

**1. 基础活动配置模块**
```html
<!-- 活动基础设置 -->
<section class="activity-basic-config">
    <h2>基础活动配置</h2>
    
    <div class="config-group">
        <label>活动名称</label>
        <input type="text" placeholder="输入活动名称">
    </div>
    
    <div class="config-group">
        <label>活动时间</label>
        <div class="time-range">
            <input type="datetime-local" placeholder="开始时间">
            <input type="datetime-local" placeholder="结束时间">
        </div>
    </div>
    
    <div class="config-group">
        <label>活动规则</label>
        <div class="rich-text-editor">
            <!-- 富文本编辑器 -->
        </div>
    </div>
    
    <div class="config-group">
        <label>赞助商信息</label>
        <div class="sponsor-config">
            <input type="text" placeholder="赞助商名称">
            <input type="url" placeholder="官网链接">
            <div class="logo-upload">
                <button>上传Logo</button>
            </div>
        </div>
    </div>
</section>
```

**2. 视觉内容配置模块**
```html
<!-- 视觉内容管理 -->
<section class="visual-content-config">
    <h2>视觉内容配置</h2>
    
    <div class="banner-upload">
        <label>Banner图片上传</label>
        <div class="upload-area">
            <button class="upload-btn">选择Banner图片</button>
            <p>建议尺寸: 750x400px</p>
        </div>
        <div class="image-preview">
            <!-- 图片预览区域 -->
        </div>
    </div>
    
    <div class="prize-images">
        <label>奖品图片管理</label>
        <div class="batch-upload">
            <button class="batch-upload-btn">批量上传奖品图片</button>
        </div>
        <div class="prize-gallery">
            <!-- 奖品图片展示和管理 -->
        </div>
    </div>
</section>
```

**3. 头像管理系统** (基于Story 4.1关键功能)
```html
<!-- 头像管理系统 -->
<section class="avatar-management">
    <h2>头像管理系统</h2>
    
    <div class="avatar-strategy-config">
        <h3>头像显示策略配置</h3>
        <div class="strategy-options">
            <div class="strategy-item">
                <h4>1. DiceBear生成</h4>
                <p>使用DiceBear API生成用户头像</p>
                <label>
                    <input type="checkbox" checked>
                    启用DiceBear生成
                </label>
            </div>
            
            <div class="strategy-item">
                <h4>2. 虚拟头像库</h4>
                <p>用于营造氛围的虚拟用户头像</p>
                <div class="virtual-avatar-upload">
                    <button>批量上传虚拟头像</button>
                </div>
            </div>
        </div>
    </div>
    
    <div class="avatar-style-config">
        <h3>头像样式统一配置</h3>
        <div class="style-settings">
            <label>头像尺寸: <input type="number" value="32"> px</label>
            <label>边框圆角: <input type="number" value="50"> %</label>
            <label>边框宽度: <input type="number" value="2"> px</label>
        </div>
    </div>
</section>
```

**4. 跑马灯消息配置系统**
```html
<!-- 跑马灯配置 -->
<section class="ticker-config">
    <h2>跑马灯消息配置</h2>
    
    <div class="message-templates">
        <div class="template-item">
            <label>参与消息模板</label>
            <input type="text" value="[头像] xxx参与了抽奖" readonly>
            <p>格式说明: [头像] 自动替换为用户头像</p>
        </div>
        
        <div class="template-item">
            <label>邀请消息模板</label>
            <input type="text" value="[头像] xx邀请了x个人" readonly>
            <p>格式说明: x个人 自动替换为实际邀请数量</p>
        </div>
    </div>
    
    <div class="data-mix-config">
        <h3>数据混合显示配置</h3>
        <div class="mix-ratio">
            <label>真实用户数据比例: <input type="range" min="0" max="100" value="70"> %</label>
            <label>虚拟数据比例: <input type="range" min="0" max="100" value="30"> %</label>
        </div>
    </div>
    
    <div class="ticker-preview">
        <h3>跑马灯效果预览</h3>
        <div class="preview-area">
            <!-- 实时预览跑马灯效果 -->
        </div>
    </div>
</section>
```

**5. WhatsApp集成配置**
```html
<!-- WhatsApp集成设置 -->
<section class="whatsapp-integration">
    <h2>WhatsApp集成配置</h2>
    
    <div class="multi-tenant-config">
        <h3>多商家WhatsApp商业号设置</h3>
        <div class="business-accounts">
            <button class="add-account">添加商业号</button>
            <div class="account-list">
                <!-- 商业号列表 -->
            </div>
        </div>
    </div>
    
    <div class="customer-service-config">
        <h3>客服个人号配置</h3>
        <div class="service-numbers">
            <label>兑奖客服号码</label>
            <input type="text" placeholder="+1234567890">
            <button class="test-whatsapp">测试连接</button>
        </div>
    </div>
    
    <div class="template-message-config">
        <h3>模板消息内容自定义</h3>
        <textarea placeholder="邀请成功通知模板"></textarea>
    </div>
</section>
```

**6. 营销参数配置**
```html
<!-- 营销参数设置 -->
<section class="marketing-config">
    <h2>营销参数配置</h2>
    
    <div class="reward-settings">
        <label>邀请奖励抽奖码数量</label>
        <input type="number" value="1" min="1">
    </div>
    
    <div class="base-stats">
        <label>初始参与人数基数</label>
        <input type="number" value="1000" min="0">
    </div>
    
    <div class="cta-customization">
        <label>CTA按钮文案自定义</label>
        <input type="text" value="立即参与抽奖">
    </div>
</section>
```

**验收标准检查**:
- [ ] Story 4.1的所有验收标准满足
- [ ] 头像管理系统完整实现
- [ ] 多商家WhatsApp配置支持
- [ ] 跑马灯配置和预览功能
- [ ] 三种兑奖方式后台配置
- [ ] 实时预览前端页面效果

---

## 🔧 **技术实施规范**

### **设计系统严格应用**

#### **基于Design_Spec_A3.md的完整应用**
```css
/* 设计令牌系统严格应用 */
:root {
    /* WhatsApp官方色彩系统 */
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
    
    /* 8pt网格系统 */
    --spacing-xs: 4px;
    --spacing-sm: 8px;
    --spacing-md: 12px;
    --spacing-lg: 16px;
    --spacing-xl: 24px;
    --spacing-xxl: 32px;
    
    --pad-card: 16px;
    --gap-section: 16px;
    --radius-lg: 16px;
}
```

#### **基于Style_Guide_A3.html的交互动效**
```css
/* 微交互动效规范 */
.btn-cta-round {
    transition: all 0.4s cubic-bezier(0.23, 1, 0.320, 1);
    box-shadow: 0 4px 12px rgba(37, 211, 102, 0.15);
}

.btn-cta-round:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 32px rgba(37, 211, 102, 0.4);
}

.card {
    transition: all 0.3s ease;
}

.card:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 16px rgba(37, 211, 102, 0.08);
}
```

### **组件复用和模块化设计**

#### **项目结构规范**
```
design/prototypes/
├── p1-landing-page.html          # P1的3个状态实现
├── p2-activity-dashboard.html    # P2的4个状态实现
├── p3-redemption-page.html       # P3的6个状态实现
├── admin-dashboard.html          # 管理后台完整功能
├── components/                   # 基于Design_Spec_A3的组件库
│   ├── buttons.html              # 按钮组件库（CTA圆形、次要按钮等）
│   ├── cards.html                # 卡片组件库（标准卡片、Hero横幅等）
│   ├── forms.html                # 表单组件库（输入框、选择器等）
│   ├── avatars.html              # 头像显示组件（DiceBear策略）
│   ├── modals.html               # 弹窗组件库（Toast、确认框等）
│   └── navigation.html           # 导航组件（页眉、面包屑等）
├── assets/
│   ├── css/
│   │   ├── design-tokens.css     # 基于Design_Spec_A3的CSS变量
│   │   ├── components.css        # 组件样式库
│   │   ├── layout.css            # 布局样式
│   │   └── animations.css        # 基于Style_Guide_A3的动效
│   ├── js/
│   │   ├── interactions.js       # 交互逻辑
│   │   ├── state-management.js   # 页面状态管理
│   │   └── data-simulation.js    # 数据模拟逻辑
│   └── images/
│       ├── samples/              # 示例图片
│       └── icons/                # 图标资源
└── data/
    ├── mock-users.json           # 模拟用户数据
    ├── mock-prizes.json          # 模拟奖品数据
    ├── mock-activities.json      # 模拟活动配置
    └── mock-winners.json         # 模拟中奖者数据
```

### **真实数据集成模拟**

#### **头像策略模拟**
```javascript
// 头像显示优先级策略（DiceBear → 虚拟 → 默认）
function getAvatarUrl(user) {
    // 1. DiceBear生成头像
    if (user.name) {
        return `https://api.dicebear.com/7.x/avataaars/svg?seed=${encodeURIComponent(user.name)}`;
    }
    
    // 2. 虚拟头像库兜底
    return `/assets/images/virtual-avatars/default-${user.id % 10}.svg`;
}
```

#### **分等级中奖者公示数据**
```javascript
// 中奖者公示数据结构
const winnersData = {
    firstPrize: [
        {
            nickname: "张三***",
            avatar: "https://api.dicebear.com/7.x/avataaars/svg?seed=张三",
            prizeLevel: "一等奖",
            prizeName: "iPhone 15 Pro"
        }
    ],
    secondPrize: [
        {
            nickname: "李四***",
            avatar: "https://api.dicebear.com/7.x/avataaars/svg?seed=李四", // DiceBear生成
            prizeLevel: "二等奖",
            prizeName: "AirPods Pro"
        }
    ],
    thirdPrize: [
        // 更多三等奖中奖者
    ]
};
```

#### **跑马灯真实效果模拟**
```javascript
// 跑马灯消息生成
function generateTickerMessages() {
    return [
        {
            type: 'participation',
            avatar: `https://api.dicebear.com/7.x/avataaars/svg?seed=${encodeURIComponent('张明')}`,
            message: '张明刚刚参与抽奖'
        },
        {
            type: 'invitation',
            avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=李华',
            message: '李华邀请了3个人'
        }
        // 更多消息...
    ];
}
```

### **状态管理和交互逻辑**

#### **页面状态切换逻辑**
```javascript
// P1落地页状态管理
class LandingPageState {
    constructor() {
        this.currentState = this.detectInitialState();
    }
    
    detectInitialState() {
        const urlParams = new URLSearchParams(window.location.search);
        const hasInviteRef = urlParams.get('ref');
        const activityEnded = this.checkActivityStatus();
        
        if (activityEnded) return 'S1.3';
        if (hasInviteRef) return 'S1.2';
        return 'S1.1';
    }
    
    render() {
        switch(this.currentState) {
            case 'S1.1': this.renderDefaultState(); break;
            case 'S1.2': this.renderInviteState(); break;
            case 'S1.3': this.renderEndedState(); break;
        }
    }
}
```

---

## 📊 **验收标准与质量保证**

### **功能完整性验收清单**

#### **P1落地页验收标准**
- [ ] **S1.1默认状态**: Hero Banner + 跑马灯 + 奖品展示 + CTA区域完整实现
- [ ] **S1.2邀请状态**: 个性化Toast + CTA文案优化 + 邀请者信息存储
- [ ] **S1.3结束状态**: 活动结束遮罩和提示信息
- [ ] **跑马灯功能**: 头像显示策略正确实现
- [ ] **响应式设计**: 320px-1920px完美适配
- [ ] **Story 1.1验收标准**: 所有验收标准100%满足

#### **P2活动主页验收标准**
- [ ] **S2.0欢迎状态**: 被邀请者专属欢迎视图
- [ ] **S2.1常规状态**: 用户身份 + 抽奖码管理 + 常驻邀请CTA
- [ ] **S2.2中奖状态**: 庆祝视图 + 立即兑奖CTA + 分等级中奖者公示
- [ ] **S2.3未中奖状态**: 鼓励视图 + 关注下期CTA + 相同的分等级公示
- [ ] **一键WhatsApp分享**: 群组和个人联系人分享功能展示
- [ ] **利他分享文案**: "送好友抽奖码"心理设计正确实现
- [ ] **Story 2.1和2.2验收标准**: 所有验收标准100%满足

#### **P3兑奖页验收标准**
- [ ] **Token透明展示**: 验证码明确显示和复制功能
- [ ] **客服支持常驻**: 悬浮客服按钮在所有状态可用
- [ ] **S3.1实物兑奖**: 完整的收货地址表单
- [ ] **S3.2虚拟兑奖**: 兑换码显示和使用说明
- [ ] **S3.6 WhatsApp个人号**: 客服号码 + 标准话术 + 操作指引
- [ ] **其他状态**: S3.3成功/S3.4失效/S3.5已领取页面
- [ ] **安全机制**: Token一次性使用和链接防滥用
- [ ] **Story 3.3验收标准**: 所有验收标准100%满足

#### **管理后台验收标准**
- [ ] **基础活动配置**: 名称、时间、规则、赞助商设置
- [ ] **视觉内容管理**: Banner图片和奖品图片批量上传
- [ ] **头像管理**: 头像策略配置（DiceBear/虚拟）
- [ ] **跑马灯配置**: 消息模板和数据混合比例设置
- [ ] **WhatsApp集成**: 多商家配置和客服号码设置
- [ ] **三种兑奖方式**: 后台配置不同奖品的兑奖方式
- [ ] **实时预览**: 前端页面效果预览功能
- [ ] **Story 4.1验收标准**: 所有验收标准100%满足

### **设计质量验收清单**

#### **设计系统一致性验收**
- [ ] **色彩系统**: 100%使用Design_Spec_A3.md定义的颜色变量
- [ ] **WhatsApp官方色彩**: #25D366绿色系的一致性应用
- [ ] **字体系统**: 6级标题和正文层级正确实现
- [ ] **8pt网格系统**: 所有间距严格遵循4px/8px倍数
- [ ] **圆角和阴影**: 统一的视觉风格和阴影效果
- [ ] **组件状态**: default/hover/focus/active/disabled状态完整

#### **交互动效验收**
- [ ] **微交互动效**: 基于Style_Guide_A3.html的动效规范
- [ ] **悬停效果**: 按钮和卡片的悬停动画流畅自然
- [ ] **页面过渡**: 状态切换的过渡动画
- [ ] **加载动画**: 必要的loading状态和反馈
- [ ] **跑马灯动画**: 60fps流畅滚动效果

#### **响应式设计验收**
- [ ] **320px**: iPhone SE等小屏设备完美适配
- [ ] **375px**: iPhone标准尺寸最优体验
- [ ] **414px**: iPhone Plus大屏优化
- [ ] **768px**: iPad平板设备适配
- [ ] **1024px+**: 桌面端展示效果
- [ ] **触摸优化**: H5端按钮和交互区域>44px
- [ ] **横屏适配**: 横屏模式下的布局优化

### **用户体验验收清单**

#### **心理设计验收**
- [ ] **利他分享**: "帮助朋友"而非"自己获利"的文案设计
- [ ] **透明度体现**: 中奖和未中奖都显示分等级公示信息
- [ ] **积极心理**: 避免"很遗憾"等负面词汇
- [ ] **信任建立**: 客服支持在关键流程的常驻展示
- [ ] **专业感**: 企业级工具品质的视觉呈现

#### **交互体验验收**
- [ ] **一键操作**: 关键功能都有明确的一键操作
- [ ] **即时反馈**: 所有用户操作都有明确的反馈
- [ ] **错误处理**: 所有异常情况都有友好的错误提示
- [ ] **帮助指引**: 复杂操作都有清晰的步骤说明
- [ ] **截图保存**: 重要信息都建议用户截图保存

### **技术质量验收清单**

#### **代码质量验收**
- [ ] **HTML结构**: 语义化HTML和正确的标签嵌套
- [ ] **CSS组织**: 模块化CSS和变量系统的正确使用
- [ ] **JavaScript逻辑**: 清晰的状态管理和事件处理
- [ ] **可访问性**: WCAG AA级标准的基础支持
- [ ] **性能优化**: 图片优化和代码压缩

#### **数据模拟验证**
- [ ] **真实数据结构**: 模拟数据符合实际API设计
- [ ] **头像策略**: 显示策略正确实现
- [ ] **状态管理**: 页面状态切换逻辑完整
- [ ] **边界情况**: 异常状态和错误情况的处理

---

## 📁 **最终交付结构**

### **完整交付清单**

```
design/prototypes/
├── README.md                     # 原型使用说明和导航
├── index.html                    # 原型导航首页
├── p1-landing-page.html          # P1落地页（3个状态）
├── p2-activity-dashboard.html    # P2活动主页（4个状态）
├── p3-redemption-page.html       # P3兑奖页（6个状态）
├── admin-dashboard.html          # 管理后台
├── components/                   # 组件库
│   ├── buttons.html              # 按钮组件展示
│   ├── cards.html                # 卡片组件展示
│   ├── forms.html                # 表单组件展示
│   ├── avatars.html              # 头像组件展示
│   ├── modals.html               # 弹窗组件展示
│   └── navigation.html           # 导航组件展示
├── assets/                       # 资源文件
│   ├── css/
│   │   ├── design-tokens.css     # 设计令牌
│   │   ├── components.css        # 组件样式
│   │   ├── layout.css            # 布局样式
│   │   ├── animations.css        # 动效样式
│   │   └── responsive.css        # 响应式样式
│   ├── js/
│   │   ├── app.js                # 主应用逻辑
│   │   ├── state-manager.js      # 状态管理
│   │   ├── interactions.js       # 交互逻辑
│   │   ├── data-simulator.js     # 数据模拟
│   │   └── utils.js              # 工具函数
│   └── images/
│       ├── banners/              # Banner示例图片
│       ├── prizes/               # 奖品示例图片
│       ├── avatars/              # 虚拟头像库
│       └── icons/                # 图标资源
├── data/                         # 模拟数据
│   ├── mock-users.json           # 用户数据
│   ├── mock-prizes.json          # 奖品数据
│   ├── mock-activities.json      # 活动配置数据
│   ├── mock-winners.json         # 中奖者数据
│   └── mock-admin.json           # 管理后台配置数据
└── docs/                         # 文档说明
    ├── state-transitions.md      # 页面状态转换说明
    ├── component-usage.md        # 组件使用指南
    ├── design-tokens.md          # 设计令牌说明
    └── development-handoff.md    # 开发交接文档
```

### **原型功能完整性**

#### **13个页面状态全覆盖**
1. **P1落地页**: S1.1默认 + S1.2邀请 + S1.3结束 = 3个状态
2. **P2活动主页**: S2.0欢迎 + S2.1常规 + S2.2中奖 + S2.3未中奖 = 4个状态
3. **P3兑奖页**: S3.1实物 + S3.2虚拟 + S3.3成功 + S3.4失效 + S3.5已领取 + S3.6WhatsApp = 6个状态

#### **核心功能演示**
- **头像显示策略**: DiceBear生成 > 虚拟头像 > 默认头像
- **利他分享设计**: "送好友抽奖码"的心理学应用
- **分等级中奖者公示**: 一二三等奖中奖者信息在中奖/未中奖页相同展示
- **三种兑奖方式**: 表单/虚拟兑换码/WhatsApp个人号兑奖完整流程
- **常驻客服支持**: 所有关键流程的WhatsApp客服联系
- **Token透明展示**: 兑奖页面的验证码显示和复制功能

### **开发交接准备**

#### **设计到开发交接文档**
- **组件API定义**: 每个组件的props和状态定义
- **数据结构说明**: API接口的数据格式要求
- **状态管理方案**: 页面状态机的技术实现建议
- **第三方集成点**: DiceBear API、WhatsApp API集成要求

#### **质量验收标准**
- **设计还原验收**: 1:1还原原型的验收检查清单
- **功能完整性验收**: 每个用户故事验收标准的技术实现检查
- **性能优化要求**: 页面加载速度和交互响应时间标准
- **浏览器兼容性**: 移动端浏览器和微信内置浏览器兼容要求

---

## 🚀 **阶段衔接与后续工作**

### **为阶段4技术架构设计的准备**

#### **技术需求输入**
1. **组件API接口定义**: 基于原型实现的组件接口需求
2. **数据结构和状态管理**: 页面状态机的技术架构需求
3. **第三方服务集成**: DiceBear API、WhatsApp Business API集成点
4. **性能优化需求**: 基于原型交互的性能要求分析

#### **架构设计输入**
1. **前端技术栈选择**: 基于原型复杂度的技术栈建议
2. **状态管理方案**: 基于13个页面状态的状态管理架构
3. **组件设计模式**: 基于组件复用的设计模式选择
4. **API设计需求**: 基于数据模拟的后端API设计要求

### **质量保证延续**

#### **设计系统维护**
- **组件库扩展**: 基于原型的组件库持续完善
- **设计令牌更新**: 根据原型实现反馈的设计系统优化
- **响应式优化**: 基于真实设备测试的适配优化

#### **用户体验优化**
- **A/B测试准备**: 关键交互点的测试方案设计
- **用户反馈收集**: 原型测试的用户反馈收集机制
- **可访问性改进**: 基于WCAG标准的持续改进

---

**文档状态**: 待执行  
**预计完成时间**: 7个工作日  
**负责人**: UI/UX设计专家  
**验收责任人**: 项目产品经理  
**下一阶段**: 阶段4技术架构设计  

---

**重要提醒**: 此执行任务规格基于完整的requirements.md用户故事和已完成的设计系统资产，必须严格按照验收标准执行，确保原型质量满足生产环境开发需求。所有13个页面状态必须100%实现，为后续开发阶段提供完整准确的需求输入。
