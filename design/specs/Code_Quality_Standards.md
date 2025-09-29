# 代码质量标准 - WhatsApp抽奖活动系统

## 📋 **质量检查总览**

本文档定义了项目开发过程中必须遵循的代码质量标准，确保代码的**可读性、可维护性、可扩展性和安全性**。

### 🎯 **质量目标**
- **零硬编码**: 所有配置项可动态调整
- **注释完备**: 关键逻辑有清晰说明
- **结构清晰**: 代码组织符合架构设计
- **性能优化**: 无明显性能瓶颈
- **安全可靠**: 防范常见安全漏洞

---

## 🔍 **核心检查项目**

### **1. 功能完整性检查**
#### **检查标准**
- ✅ **需求对齐**: 实现功能与PRD需求100%匹配
- ✅ **边界处理**: 所有边界情况都有处理逻辑
- ✅ **异常处理**: 完善的错误捕获和处理机制
- ✅ **状态管理**: 所有状态变更都有明确的触发条件

#### **具体检查点**
```typescript
// ❌ 错误示例：缺少边界处理
function getUserCodes(userId: string) {
  return database.codes.filter(code => code.userId === userId);
}

// ✅ 正确示例：完整的边界处理
function getUserCodes(userId: string): Promise<LotteryCode[]> {
  if (!userId || typeof userId !== 'string') {
    throw new ValidationError('userId must be a valid string');
  }
  
  try {
    const codes = await database.codes.filter(code => code.userId === userId);
    return codes || [];
  } catch (error) {
    logger.error('Failed to fetch user codes', { userId, error });
    throw new DatabaseError('Unable to retrieve user codes');
  }
}
```

---

### **2. 硬编码检查**
#### **检查标准**
- ✅ **配置外置**: 所有可变值使用配置文件
- ✅ **环境变量**: 敏感信息使用环境变量
- ✅ **常量定义**: 业务常量统一管理
- ✅ **多语言支持**: 文案支持国际化

#### **具体检查点**
```typescript
// ❌ 错误示例：硬编码
const maxRetries = 3; // 硬编码重试次数
const apiUrl = 'https://api.whatsapp.com/v1'; // 硬编码API地址
const welcomeMessage = '欢迎参与抽奖！'; // 硬编码文案

// ✅ 正确示例：配置化
const config = {
  api: {
    maxRetries: process.env.MAX_RETRIES || 3,
    whatsappUrl: process.env.WHATSAPP_API_URL,
  },
  messages: {
    welcome: t('welcome_message'), // 国际化文案
  }
};
```

---

### **3. 注释和文档完整性**
#### **检查标准**
- ✅ **函数注释**: 所有public函数都有JSDoc注释
- ✅ **复杂逻辑**: 复杂算法有详细说明
- ✅ **业务逻辑**: 业务规则有清晰注释
- ✅ **TODO标记**: 临时代码有明确标记和计划

#### **具体检查点**
```typescript
// ✅ 正确示例：完整的函数注释
/**
 * 计算用户获得的抽奖码数量
 * 
 * @param userId - 用户ID
 * @param inviteCount - 邀请人数
 * @returns Promise<number> 抽奖码总数
 * 
 * @description
 * 计算规则：
 * - 基础奖励：1个抽奖码
 * - 邀请奖励：每邀请1人获得1个抽奖码
 * - 上限控制：最多50个抽奖码
 * 
 * @example
 * const codes = await calculateUserCodes('user123', 5);
 * console.log(codes); // 6 (1基础 + 5邀请)
 */
async function calculateUserCodes(
  userId: string, 
  inviteCount: number
): Promise<number> {
  // 业务规则：基础1个 + 邀请数量，上限50个
  const baseCodes = 1;
  const inviteCodes = Math.min(inviteCount, 49); // 防止超出上限
  
  return baseCodes + inviteCodes;
}
```

---

### **4. 代码结构检查**
#### **检查标准**
- ✅ **单一职责**: 每个函数只负责一个功能
- ✅ **模块化**: 相关功能组织在同一模块
- ✅ **依赖注入**: 避免硬依赖，使用依赖注入
- ✅ **接口隔离**: 使用接口定义清晰的契约

#### **具体检查点**
```typescript
// ❌ 错误示例：职责不清晰
function processUserAction(userId: string, action: string) {
  // 验证用户
  if (!isValidUser(userId)) return false;
  
  // 发送WhatsApp消息
  sendWhatsAppMessage(userId, 'Action processed');
  
  // 更新数据库
  updateUserAction(userId, action);
  
  // 记录日志
  logger.info(`User ${userId} performed ${action}`);
}

// ✅ 正确示例：职责分离
class UserActionService {
  constructor(
    private userValidator: IUserValidator,
    private messageService: IMessageService,
    private userRepository: IUserRepository,
    private logger: ILogger
  ) {}

  async processAction(userId: string, action: string): Promise<boolean> {
    // 职责1：验证
    await this.validateUser(userId);
    
    // 职责2：处理业务逻辑
    await this.executeAction(userId, action);
    
    // 职责3：通知
    await this.notifyUser(userId, action);
    
    return true;
  }
  
  private async validateUser(userId: string): Promise<void> {
    if (!await this.userValidator.isValid(userId)) {
      throw new ValidationError('Invalid user');
    }
  }
  
  private async executeAction(userId: string, action: string): Promise<void> {
    await this.userRepository.updateAction(userId, action);
    this.logger.info(`User ${userId} performed ${action}`);
  }
  
  private async notifyUser(userId: string, action: string): Promise<void> {
    await this.messageService.send(userId, 'Action processed');
  }
}
```

---

### **5. 性能和安全检查**
#### **检查标准**
- ✅ **性能优化**: 无明显性能瓶颈，响应时间<100ms
- ✅ **内存管理**: 无内存泄漏，及时释放资源
- ✅ **安全防护**: 防范XSS、CSRF、SQL注入等
- ✅ **数据验证**: 所有输入数据都经过验证

#### **具体检查点**
```typescript
// ✅ 性能优化示例
class UserCodeService {
  private codeCache = new Map<string, LotteryCode[]>();
  
  async getUserCodes(userId: string): Promise<LotteryCode[]> {
    // 缓存优化：避免重复查询
    if (this.codeCache.has(userId)) {
      return this.codeCache.get(userId)!;
    }
    
    const codes = await this.repository.findByUserId(userId);
    
    // 设置缓存过期时间，避免内存泄漏
    this.codeCache.set(userId, codes);
    setTimeout(() => this.codeCache.delete(userId), 5 * 60 * 1000);
    
    return codes;
  }
}

// ✅ 安全防护示例
function validateUserInput(input: unknown): UserInput {
  // 类型验证
  if (typeof input !== 'object' || input === null) {
    throw new ValidationError('Input must be an object');
  }
  
  // 字段验证
  const schema = z.object({
    userId: z.string().min(1).max(50),
    message: z.string().max(500),
    timestamp: z.number().positive()
  });
  
  try {
    return schema.parse(input);
  } catch (error) {
    throw new ValidationError('Invalid input format');
  }
}
```

---

## 📊 **TypeScript专项检查**

### **类型安全检查**
```typescript
// ✅ 完整的类型定义
interface LotteryActivity {
  id: string;
  name: string;
  status: ActivityStatus;
  prizes: Prize[];
  config: ActivityConfig;
  createdAt: Date;
  updatedAt: Date;
}

// ✅ 泛型使用
interface Repository<T> {
  findById(id: string): Promise<T | null>;
  create(entity: Omit<T, 'id'>): Promise<T>;
  update(id: string, updates: Partial<T>): Promise<T>;
  delete(id: string): Promise<void>;
}

// ✅ 联合类型和类型守卫
type ApiResponse<T> = 
  | { success: true; data: T }
  | { success: false; error: string };

function isSuccessResponse<T>(
  response: ApiResponse<T>
): response is { success: true; data: T } {
  return response.success === true;
}
```

---

## 🧪 **测试质量标准**

### **单元测试要求**
```typescript
// ✅ 完整的单元测试示例
describe('UserCodeService', () => {
  let service: UserCodeService;
  let mockRepository: jest.Mocked<IUserRepository>;
  
  beforeEach(() => {
    mockRepository = createMockRepository();
    service = new UserCodeService(mockRepository);
  });
  
  describe('calculateCodes', () => {
    it('should return base code plus invite codes', async () => {
      // Arrange
      const userId = 'user123';
      const inviteCount = 5;
      const expected = 6; // 1 base + 5 invite
      
      // Act
      const result = await service.calculateCodes(userId, inviteCount);
      
      // Assert
      expect(result).toBe(expected);
    });
    
    it('should limit codes to maximum of 50', async () => {
      // Arrange
      const userId = 'user123';
      const inviteCount = 100;
      const expected = 50; // Maximum limit
      
      // Act
      const result = await service.calculateCodes(userId, inviteCount);
      
      // Assert
      expect(result).toBe(expected);
    });
    
    it('should throw error for invalid userId', async () => {
      // Arrange
      const invalidUserId = '';
      const inviteCount = 5;
      
      // Act & Assert
      await expect(
        service.calculateCodes(invalidUserId, inviteCount)
      ).rejects.toThrow(ValidationError);
    });
  });
});
```

---

## ✅ **质量检查清单**

### **代码提交前检查**
```markdown
- [ ] **功能完整**: 所有需求功能已实现，边界情况已处理
- [ ] **硬编码清除**: 无硬编码配置、URL、文案等
- [ ] **注释完整**: 复杂逻辑有说明，public函数有JSDoc
- [ ] **结构清晰**: 职责分离，模块化设计，依赖注入
- [ ] **类型安全**: TypeScript无any滥用，类型定义完整
- [ ] **性能优化**: 无明显性能问题，缓存合理使用
- [ ] **安全检查**: 输入验证，防XSS/CSRF，敏感数据保护
- [ ] **测试覆盖**: 单元测试覆盖率>90%，关键路径有集成测试
- [ ] **命名规范**: 变量、函数、类名语义清晰，符合约定
- [ ] **错误处理**: 异常捕获完整，错误信息有意义
```

### **Code Review检查**
```markdown
- [ ] **架构设计**: 是否符合项目架构设计原则
- [ ] **最佳实践**: 是否遵循TypeScript和React最佳实践
- [ ] **重构机会**: 是否有重复代码或改进空间
- [ ] **文档同步**: 相关文档是否需要更新
- [ ] **向后兼容**: 变更是否影响现有功能
```

---

## 🛠️ **质量检查工具**

### **自动化检查**
```bash
# TypeScript类型检查
npm run type-check

# ESLint代码规范检查
npm run lint

# 单元测试和覆盖率
npm run test:coverage

# 安全漏洞扫描
npm audit

# 性能测试
npm run test:performance
```

### **手动检查工具**
- **代码审查**: 使用GitHub PR Review
- **安全检查**: OWASP安全检查清单
- **性能分析**: Chrome DevTools Performance
- **可访问性**: axe-core自动化测试

---

## 🚨 **质量门控**

### **提交门控**
- ESLint零错误
- TypeScript零类型错误
- 单元测试全部通过
- 代码覆盖率>85%

### **发布门控**  
- 集成测试全部通过
- 性能测试达标
- 安全扫描无高危漏洞
- Code Review通过批准

---

**文档版本**: v1.0  
**创建日期**: 2024年9月29日  
**维护团队**: 技术质量团队  
**适用范围**: 所有开发阶段  

---

**重要**: 此标准为强制执行规范，所有代码提交都必须通过完整的质量检查。
