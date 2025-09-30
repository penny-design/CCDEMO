# 用户流程设计 (User Flow Design)

## 📋 **文档信息**
**文档名称**: Flowchart.md  
**创建日期**: 2024年9月29日  
**版本**: v1.0  
**状态**: 进行中  
**基于**: core-requirements v1.0  

---

## 🎯 **流程设计概览**

基于已确认的12个用户故事和完整的Requirements规格，本文档定义了WhatsApp抽奖活动系统的完整用户流程设计。

### **核心设计原则**
- **激活路径**: WhatsApp优先（直接唤醒）；Google登录为可选扩展（用于头像/数据完善）
- **利他分享心理学**: 强调帮助朋友而非自己获利
- **透明度优先**: 中奖信息完全公开透明
- **客服支持常驻**: 关键环节都有客服联系方式
- **三种兑奖方式**: 适应不同奖品类型的灵活兑奖

---

## 🗺️ **主流程图: 完整用户生命周期**

```mermaid
graph TD
    subgraph "入口与发现"
        A[用户访问H5落地页] --> B{来源类型判断}
        B -->|自然流量| C[S1.1: 默认落地页状态]
        B -->|邀请链接| D[S1.2: 邀请状态 + 个性化Toast]
        
        C --> E[查看奖品清单和跑马灯]
        D --> F[显示朋友名送你一个抽奖码]
        E --> G[点击参与抽奖按钮]
        F --> G
    end

    subgraph "用户激活 - WhatsApp优先（P1）"
        G --> L[生成SESSION_ID]
        L --> M[跳转WhatsApp预填消息<br/>我要参与-SESSION_ID]
        M --> N[用户发送WhatsApp消息]
        N --> O[后台获取手机号]
        O --> P[完成激活绑定<br/>（可选补充Google信息）]
        P --> Q[WhatsApp机器人回复激活成功]
        Q --> R[H5页面Realtime监听到激活]
        R --> S[自动跳转到活动主页]
    end

    subgraph "活动主页状态管理"
        S --> T{首次访问判断}
        T -->|被邀请者首次| U[S2.0: 欢迎礼物视图]
        T -->|常规用户| V[S2.1: 开奖前常规状态]
        
        U --> W[显示个性化欢迎<br/>展示获得的抽奖码]
        V --> X[显示抽奖码总数<br/>邀请任务模块]
        W --> X
        
        X --> Y[常驻邀请CTA/Toast<br/>送好友抽奖码，你也获得更多]
        Y --> Z[用户点击邀请分享]
    end

    subgraph "病毒式传播循环"
        Z --> AA[生成专属邀请链接<br/>包含用户ID和Google昵称]
        AA --> BB[一键WhatsApp分享]
        BB --> CC{分享目标}
        CC -->|分享到群组| DD[WhatsApp群组分享]
        CC -->|分享给个人| EE[WhatsApp个人分享]
        
        DD --> FF[新用户通过邀请链接访问]
        EE --> FF
        FF --> D
        
        P --> GG[监听事件好友关注商业号]
        GG --> HH[为邀请者增加N个抽奖码]
        HH --> II[WhatsApp模板消息通知邀请者]
        II --> JJ[H5页面Realtime更新抽奖码数量]
        JJ --> KK[跑马灯显示Google头像张三邀请了3个人]
    end

    subgraph "开奖与结果展示"
        LL[活动到达开奖时间] --> MM[系统执行抽奖算法]
        MM --> NN[生成中奖结果]
        NN --> OO{用户中奖状态}
        
        OO -->|中奖| PP[S2.2: 庆祝视图]
        OO -->|未中奖| QQ[S2.3: 鼓励视图]
        
        PP --> RR[显示恭喜中奖标题<br/>奖品等级和名称]
        QQ --> SS[显示感谢参与标题<br/>下期再来鼓励]
        
        RR --> TT[分等级中奖者公示<br/>头像+脱敏昵称]
        SS --> TT
        
        TT --> UU{用户操作}
        UU -->|中奖用户| VV[点击立即兑奖]
        UU -->|未中奖用户| WW[点击关注下期活动]
    end

    subgraph "兑奖流程 - 三种方式"
        VV --> XX[生成一次性Token链接]
        XX --> YY[访问兑奖页面 P3]
        YY --> ZZ[Token验证]
        ZZ --> AAA{Token状态}
        
        AAA -->|有效| BBB[S3.1/S3.2/S3.6: 显示Token<br/>可复制保存]
        AAA -->|无效| CCC[S3.4: 链接无效页面]
        AAA -->|已使用| DDD[S3.5: 奖品已领取页面]
        
        BBB --> EEE[悬浮客服按钮常驻<br/>有疑问？联系客服]
        BBB --> FFF{奖品类型判断}
        
        FFF -->|实物奖品| GGG[S3.1: 收件信息表单]
        FFF -->|虚拟奖品| HHH[S3.2: 兑换码直接显示]
        FFF -->|WhatsApp兑奖| III[S3.6: 客服个人号兑奖]
        
        GGG --> JJJ[填写并提交地址信息]
        HHH --> KKK[一键复制兑换码]
        III --> LLL[显示客服WhatsApp个人号<br/>提供标准话术模板]
        
        JJJ --> MMM[S3.3: 提交成功确认]
        KKK --> MMM
        LLL --> NNN[用户添加客服微信<br/>发送兑奖码完成兑奖]
        
        MMM --> OOO[建议截图保存]
        NNN --> OOO
        OOO --> PPP[系统标记Token已使用]
    end

    style A fill:#e1f5fe
    style VV fill:#c8e6c9
    style PPP fill:#ffcdd2
```

---

## 📱 **页面状态机设计**

### **P1: 落地页状态机**

```mermaid
stateDiagram-v2
    [*] --> 检查活动状态
    检查活动状态 --> S1_3_活动结束: 活动已结束
    检查活动状态 --> 检查访问来源: 活动进行中
    
    检查访问来源 --> S1_1_默认状态: 自然流量或无ref参数
    检查访问来源 --> S1_2_邀请状态: 有ref和name参数
    
    S1_1_默认状态 --> 展示标准落地页: 显示奖品清单
    S1_2_邀请状态 --> 展示个性化Toast: 朋友名送你一个抽奖码
    
    展示标准落地页 --> 生成会话并唤醒: 点击立即参与
    展示个性化Toast --> 生成会话并唤醒: 点击领取并参与
    
    生成会话并唤醒 --> WhatsApp验证: 跳转WhatsApp发送消息
    
    WhatsApp验证 --> 等待激活: 页面轮询或Realtime监听
    等待激活 --> 激活成功: 后台完成身份绑定
    激活成功 --> [*]: 跳转到活动主页
    
    S1_3_活动结束 --> [*]: 显示活动结束遮罩
```

### **P2: 活动主页状态机**

```mermaid
stateDiagram-v2
    [*] --> 用户身份识别
    用户身份识别 --> S2_0_欢迎礼物: 被邀请者首次访问
    用户身份识别 --> 检查开奖状态: 非首次访问
    
    S2_0_欢迎礼物 --> 展示欢迎视图: 来自[邀请者]的礼物
    展示欢迎视图 --> 检查开奖状态: 用户进行任何操作
    
    检查开奖状态 --> S2_1_开奖前: 活动进行中
    检查开奖状态 --> 检查中奖状态: 活动已开奖
    
    S2_1_开奖前 --> 展示常规视图: 抽奖码+邀请任务
    展示常规视图 --> 邀请分享: 点击邀请CTA
    展示常规视图 --> 实时更新: 监听邀请成功事件
    
    邀请分享 --> 生成邀请链接: 包含用户信息
    生成邀请链接 --> WhatsApp分享: 一键分享
    WhatsApp分享 --> 展示常规视图: 分享完成返回
    
    实时更新 --> 增加抽奖码: 邀请成功+1动画
    增加抽奖码 --> 展示常规视图: 更新完成
    
    检查中奖状态 --> S2_2_中奖庆祝: 用户中奖
    检查中奖状态 --> S2_3_未中奖鼓励: 用户未中奖
    
    S2_2_中奖庆祝 --> 展示庆祝视图: 恭喜中奖+分等级公示
    S2_3_未中奖鼓励 --> 展示鼓励视图: 感谢参与+分等级公示
    
    展示庆祝视图 --> 跳转兑奖: 点击立即兑奖
    展示鼓励视图 --> 关注下期: 点击关注下期活动
    
    跳转兑奖 --> [*]: 前往兑奖页面
    关注下期 --> [*]: 引导关注或返回
```

### **P3: 兑奖页状态机**

```mermaid
stateDiagram-v2
    [*] --> Token验证
    Token验证 --> S3_4_无效链接: Token无效或过期
    Token验证 --> S3_5_已领取: Token已被使用
    Token验证 --> 奖品类型判断: Token有效
    
    奖品类型判断 --> S3_1_实物奖品: 实物类型
    奖品类型判断 --> S3_2_虚拟奖品: 虚拟类型
    奖品类型判断 --> S3_6_WhatsApp兑奖: WhatsApp个人号类型
    
    S3_1_实物奖品 --> 展示地址表单: 显示Token+客服按钮
    S3_2_虚拟奖品 --> 展示兑换码: 显示Token+客服按钮
    S3_6_WhatsApp兑奖 --> 展示客服信息: 显示Token+个人号+话术
    
    展示地址表单 --> 提交地址: 用户填写完成
    展示兑换码 --> 复制兑换码: 用户点击复制
    展示客服信息 --> 联系客服: 用户添加客服微信
    
    提交地址 --> S3_3_成功确认: 表单验证通过
    复制兑换码 --> S3_3_成功确认: 复制成功
    联系客服 --> S3_3_成功确认: 引导用户联系
    
    S3_3_成功确认 --> 建议截图: 显示成功信息
    建议截图 --> 标记已使用: 系统更新Token状态
    
    S3_4_无效链接 --> [*]: 显示错误信息
    S3_5_已领取 --> [*]: 显示已领取信息
    标记已使用 --> [*]: 兑奖流程完成
    
    note right of 展示地址表单 : 悬浮客服按钮<br/>有疑问？联系客服
    note right of 展示兑换码 : Token可复制保存<br/>客服支持常驻
    note right of 展示客服信息 : 话术模板：<br/>我是活动中奖用户<br/>兑奖码: TOKEN
```

---

## ⚠️ **异常处理与边界情况**

### **关键异常流程**

```mermaid
graph TD
    subgraph "Google登录异常（可选）"
        A[Google登录失败] --> B{失败原因}
        B -->|网络问题| C[显示网络错误<br/>提供重试按钮]
        B -->|用户取消| D[保持在落地页<br/>可重新点击参与]
        B -->|权限拒绝| E[显示权限说明<br/>引导用户允许]
        
        C --> F[用户点击重试]
        D --> F
        E --> F
        F --> G[重新触发Google登录]
    end

    subgraph "WhatsApp验证异常"
        H[WhatsApp消息发送失败] --> I{失败原因}
        I -->|应用未安装| J[显示安装WhatsApp提示]
        I -->|用户返回未发送| K[显示发送消息提醒]
        I -->|SESSION_ID失效| L[重新生成SESSION_ID]
        
        J --> M[引导安装后返回]
        K --> N[提供重发消息选项]
        L --> N
        M --> N
        N --> O[重新跳转WhatsApp]
    end

    subgraph "实时监听异常"
        P[激活状态监听超时] --> Q[显示手动刷新选项]
        Q --> R[用户点击刷新]
        R --> S[重新检查激活状态]
        S --> T{激活状态}
        T -->|已激活| U[跳转活动主页]
        T -->|未激活| V[显示重试发送消息]
        V --> N
    end

    subgraph "兑奖异常处理"
        W[Token验证失败] --> X{失败类型}
        X -->|格式错误| Y[显示链接无效]
        X -->|已过期| Z[显示链接过期]
        X -->|已使用| AA[显示已领取状态]
        
        Y --> BB[引导联系客服]
        Z --> BB
        AA --> CC[显示历史兑奖信息]
        
        DD[表单提交失败] --> EE[显示错误信息<br/>保留用户输入]
        EE --> FF[提供重试选项]
        FF --> GG[重新提交表单]
    end

    style A fill:#ffcdd2
    style H fill:#ffcdd2
    style P fill:#fff3e0
    style W fill:#ffcdd2
```

### **边界情况处理**

#### **用户行为边界**
- **快速连续点击**: 防抖处理，避免重复请求
- **页面刷新**: 保持状态，基于localStorage和数据库状态恢复
- **浏览器返回**: 正确处理页面状态，避免流程断裂
- **长时间停留**: Session保活机制，避免登录状态丢失

#### **技术边界**
- **网络断开**: 显示离线提示，恢复后自动重试
- **API响应超时**: 显示加载提示，提供重试选项
- **Realtime连接断开**: 自动重连机制，备用轮询方案
- **Google OAuth限流**: 错误提示和延迟重试

#### **业务边界**
- **活动未开始**: 显示倒计时，禁用参与按钮
- **活动已结束**: 全局遮罩，仍可查看结果
- **奖品数量不足**: 实时检查，动态调整显示
- **重复参与**: 基于Google ID和手机号去重

---

## 🔄 **状态同步与数据流**

### **关键状态管理**

```mermaid
graph TD
    subgraph "前端状态管理"
        A[URL参数解析] --> B[localStorage状态]
        B --> C[页面状态机]
        C --> D[组件状态更新]
        D --> E[UI重新渲染]
    end

    subgraph "后端数据同步"
        F[Supabase数据库] --> G[Realtime订阅]
        G --> H[前端事件监听]
        H --> I[状态自动更新]
        I --> D
    end

    subgraph "第三方集成"
        J[Google OAuth API] --> K[用户信息获取]
        K --> L[数据库存储]
        L --> F
        
        M[WhatsApp Business API] --> N[消息处理]
        N --> O[激活状态更新]
        O --> F
        
        P[DiceBear API] --> Q[头像生成]
        Q --> R[前端缓存]
        R --> E
    end

    subgraph "关键数据流向"
        S[用户操作] --> T[前端验证]
        T --> U[API调用]
        U --> V[后端处理]
        V --> W[数据库更新]
        W --> G
        
        X[邀请链接分享] --> Y[新用户访问]
        Y --> Z[激活成功]
        Z --> AA[奖励发放]
        AA --> W
    end
```

### **关键数据结构**

```javascript
// 用户状态数据结构
const UserState = {
  // Google登录信息
  google: {
    id: "google_123456",
    name: "张三",
    email: "zhangsan@gmail.com",
    picture: "https://lh3.googleusercontent.com/..."
  },
  
  // WhatsApp验证信息
  whatsapp: {
    phone: "+1234567890",
    verified: true,
    session_id: "SESSION_ABC123"
  },
  
  // 活动参与状态
  activity: {
    activated: true,
    lottery_codes: 3,
    invited_by: "user_456",
    invited_count: 2,
    lottery_result: "pending" | "won" | "lost",
    won_prize: null
  },
  
  // 页面状态
  page: {
    current: "home",
    state: "S2.1",
    first_visit: false
  }
}

// 活动配置数据结构
const ActivityConfig = {
  // 基础信息
  id: "activity_001",
  name: "iPhone15抽奖活动",
  start_time: "2024-10-01T00:00:00Z",
  end_time: "2024-10-31T23:59:59Z",
  
  // 奖品配置
  prizes: [
    {
      tier: "一等奖",
      name: "iPhone 15 Pro 256GB",
      quantity: 1,
      image_url: "...",
      redemption_type: "form" | "virtual" | "whatsapp"
    }
  ],
  
  // 营销参数
  marketing: {
    invite_reward_codes: 1,
    initial_participants_base: 1000,
    banner_image_url: "...",
    marquee_messages: [
      "[头像] xxx参与了抽奖",
      "[头像] xx邀请了x个人"
    ]
  },
  
  // WhatsApp集成
  whatsapp: {
    business_number: "+1234567890",
    customer_service_number: "+0987654321",
    template_messages: {
      activation_success: "激活成功！您已获得1个抽奖码",
      invite_success: "恭喜！您的好友已加入，您获得1个新抽奖码"
    }
  }
}
```

---

## 📊 **流程性能与监控**

### **关键性能指标**

| 流程节点 | 性能目标 | 监控方式 |
|----------|----------|----------|
| 落地页加载 | <2s | Google Analytics pageload |
| Google登录响应 | <2s | OAuth API响应时间 |
| WhatsApp跳转 | <1s | 前端性能监控 |
| 激活状态检查 | <3s | Realtime延迟监控 |
| 页面状态切换 | <500ms | 前端性能API |
| 头像加载 | <1s | 图片加载完成事件 |
| 兑奖页面响应 | <2s | 端到端监控 |

### **关键转化率监控**

| 转化节点 | 目标转化率 | GA4事件埋点 |
|----------|------------|-------------|
| 访问→点击参与 | >70% | participate_click |
| 点击→Google登录完成 | >85% | google_login_success |
| Google登录→WhatsApp验证 | >80% | whatsapp_verification |
| 激活→首次邀请分享 | >30% | first_invite_share |
| 中奖→开始兑奖 | >95% | redemption_start |
| 开始兑奖→完成兑奖 | >90% | redemption_complete |

---

## ✅ **验收标准总结**

### **流程完整性验收**
- [ ] 三个主要流程图覆盖所有用户故事场景
- [ ] 页面状态机包含所有定义的状态转换
- [ ] 异常处理覆盖所有关键失败点
- [ ] 边界情况处理完整无遗漏

### **用户体验验收**
- [ ] 用户操作路径清晰直观，无困惑点
- [ ] 异常情况都有友好的错误提示和恢复路径
- [ ] 关键节点都有适当的反馈和确认
- [ ] 流程符合移动端操作习惯

### **技术实现验收**
- [ ] 所有状态转换都有明确的触发条件
- [ ] 数据同步机制支持实时更新
- [ ] 异常恢复机制健壮可靠
- [ ] 性能指标符合设计要求

### **业务价值验收**
- [ ] 流程设计最大化病毒传播效果
- [ ] 双重验证确保数据完整性
- [ ] 透明度设计增强用户信任
- [ ] 客服支持降低用户流失

---

**文档状态**: 待用户确认审批  
**下一步**: 等待用户确认后进入任务1.3功能模块划分  
**负责人**: UI/UX设计专家  
**创建时间**: 2024年9月29日

---

**重要**: 此流程设计文档基于已确认的用户故事和Requirements规格，所有流程都必须严格按照设计实现，确保用户体验的一致性和完整性。
