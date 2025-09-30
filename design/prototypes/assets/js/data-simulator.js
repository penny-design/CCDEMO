// 数据模拟器 - 基于requirements.md和真实数据结构

class DataSimulator {
    constructor() {
        this.users = [];
        this.prizes = [];
        this.activity = {};
        this.winners = [];
        this.endTimestamp = null; // 固定的活动结束时间戳（用于倒计时）
        this.businessWhatsAppNumber = null; // 商业号（国际格式，仅数字）
        this.marketing = {
            invite_reward_codes: 1,
            initial_participants_base: 18975,
            banner_image_url: 'https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=1024&h=576&fit=crop&crop=center&auto=format&fm=webp'
        };
        this.init();
    }

    async init() {
        try {
            // 加载模拟数据
            await this.loadMockData();
            // 初始化固定的倒计时结束时间（当前时间+30天，统一设为18:00，确保递减）
            this.setupCountdownEndTime();
            this.generateTickerMessages();
            this.generateParticipationStats();
        } catch (error) {
            console.error('数据模拟器初始化失败:', error);
            this.generateFallbackData();
        }
    }

    async loadMockData() {
        // 加载用户数据
        const usersResponse = await fetch('./data/mock-users.json');
        this.users = await usersResponse.json();

        // 加载奖品数据
        const prizesResponse = await fetch('./data/mock-prizes.json');
        this.prizes = await prizesResponse.json();

        console.log('模拟数据加载完成:', {
            users: this.users.length,
            prizes: this.prizes.length
        });

        // 初始化商业号（示例号码，可在后台配置/替换）
        this.businessWhatsAppNumber = '14155552671'; // 示例: +1 415 555 2671（去掉+号）
    }

    generateFallbackData() {
        // 备用数据生成
        this.users = [
            {
                id: 'user_001',
                name: '张明',
                nickname: '张明***',
                googleAvatar: 'https://lh3.googleusercontent.com/a/default',
                inviteCount: 3
            },
            {
                id: 'user_002',
                name: '李华',
                nickname: '李华***',
                diceBearAvatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=李华',
                inviteCount: 1
            }
        ];

        this.prizes = [
            { level: '一等奖', name: 'iPhone 15 Pro', quantity: 1 },
            { level: '二等奖', name: 'AirPods Pro', quantity: 3 },
            { level: '三等奖', name: 'Apple Store礼品卡', quantity: 10 }
        ];

        // 回退时也设置倒计时结束时间
        this.setupCountdownEndTime();

        // 备用商业号
        this.businessWhatsAppNumber = '14155552671';
    }

    // Google头像显示策略实现
    getAvatarUrl(user) {
        // 1. Google头像优先
        if (user.googleAvatar && user.googleAvatar !== '') {
            return user.googleAvatar;
        }
        
        // 2. DiceBear生成头像降级
        if (user.name && !user.isVirtual) {
            return `https://api.dicebear.com/7.x/avataaars/svg?seed=${encodeURIComponent(user.name)}`;
        }
        
        // 3. 虚拟头像库兜底
        if (user.virtualAvatar) {
            return user.virtualAvatar;
        }
        
        return `/assets/images/avatars/default-${user.id.slice(-1)}.svg`;
    }

    // 跑马灯消息生成
    generateTickerMessages() {
        const messages = [];
        const realUsers = this.users.filter(u => !u.isVirtual);
        const virtualUsers = this.users.filter(u => u.isVirtual);
        
        // 70%真实用户数据 + 30%虚拟数据
        const totalMessages = 12;
        const realCount = Math.floor(totalMessages * 0.7);
        
        // 真实用户消息
        for (let i = 0; i < realCount && i < realUsers.length; i++) {
            const user = realUsers[i % realUsers.length];
            const messageType = Math.random() > 0.5 ? 'participation' : 'invitation';
            
            if (messageType === 'participation') {
                messages.push({
                    type: 'participation',
                    avatar: this.getAvatarUrl(user),
                    message: `${user.name}刚刚参与抽奖`,
                    user: user
                });
            } else {
                messages.push({
                    type: 'invitation',
                    avatar: this.getAvatarUrl(user),
                    message: `${user.name}邀请了${user.inviteCount}个人`,
                    user: user
                });
            }
        }
        
        // 虚拟用户消息补充
        const virtualCount = totalMessages - realCount;
        for (let i = 0; i < virtualCount && i < virtualUsers.length; i++) {
            const user = virtualUsers[i % virtualUsers.length];
            messages.push({
                type: 'participation',
                avatar: this.getAvatarUrl(user),
                message: `${user.nickname}参与了抽奖`,
                user: user
            });
        }
        
        this.tickerMessages = messages;
        return messages;
    }

    // 参与人数统计生成
    generateParticipationStats() {
        // 初始基数可从营销配置读取
        const baseCount = this.getActivityConfig()?.marketing?.initial_participants_base ?? 18975; // 初始基数
        const realUserBonus = this.users.filter(u => !u.isVirtual).length * 3;
        const virtualBonus = Math.floor(Math.random() * 500);
        
        this.participationCount = baseCount + realUserBonus + virtualBonus;
        return this.participationCount;
    }

    // 获取奖品展示数据
    getPrizesForDisplay() {
        return this.prizes.map(prize => ({
            level: prize.level,
            name: prize.name,
            description: prize.description,
            quantity: prize.quantity,
            value: prize.value,
            imageUrl: prize.imageUrl,
            displayText: `${prize.level}：${prize.name} × ${prize.quantity}`
        }));
    }

    // 设置固定结束时间：当前时间+30天，并规范到当天18:00
    setupCountdownEndTime(days = 30) {
        const now = new Date();
        const end = new Date(now.getTime() + days * 24 * 60 * 60 * 1000);
        // 统一到18:00:00，避免时区/刷新导致跳动
        end.setHours(18, 0, 0, 0);
        this.endTimestamp = end.getTime();
    }

    // 倒计时数据
    getCountdownData() {
        // 使用固定的结束时间戳计算剩余时间，确保每秒递减
        if (!this.endTimestamp) {
            this.setupCountdownEndTime();
        }

        const now = Date.now();
        const diff = this.endTimestamp - now;

        if (diff > 0) {
            const endDate = new Date(this.endTimestamp);
            return {
                days: Math.floor(diff / (1000 * 60 * 60 * 24)),
                hours: Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)),
                minutes: Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60)),
                seconds: Math.floor((diff % (1000 * 60)) / 1000),
                endTime: `活动结束时间：${endDate.getFullYear()}-${String(endDate.getMonth() + 1).padStart(2, '0')}-${String(endDate.getDate()).padStart(2, '0')} 18:00`
            };
        }
        
        return {
            days: 0,
            hours: 0,
            minutes: 0,
            seconds: 0,
            endTime: '活动已结束'
        };
    }

    // 分等级中奖者公示数据
    generateWinnersData() {
        const winnersData = {
            firstPrize: [],
            secondPrize: [],
            thirdPrize: []
        };

        // 一等奖中奖者（1人）
        if (this.users.length > 0) {
            const winner = this.users[0];
            winnersData.firstPrize.push({
                nickname: winner.nickname,
                avatar: this.getAvatarUrl(winner),
                prizeLevel: "一等奖",
                prizeName: "iPhone 15 Pro"
            });
        }

        // 二等奖中奖者（3人）
        for (let i = 1; i <= 3 && i < this.users.length; i++) {
            const winner = this.users[i];
            winnersData.secondPrize.push({
                nickname: winner.nickname,
                avatar: this.getAvatarUrl(winner),
                prizeLevel: "二等奖", 
                prizeName: "AirPods Pro"
            });
        }

        // 三等奖中奖者（10人）
        for (let i = 4; i <= 13 && i < this.users.length; i++) {
            const winner = this.users[i] || this.users[i % this.users.length];
            winnersData.thirdPrize.push({
                nickname: winner.nickname,
                avatar: this.getAvatarUrl(winner),
                prizeLevel: "三等奖",
                prizeName: "Apple Store礼品卡"
            });
        }

        this.winnersData = winnersData;
        return winnersData;
    }

    // 页面状态检测
    detectPageState() {
        const urlParams = new URLSearchParams(window.location.search);
        const hasInviteRef = urlParams.get('ref');
        const inviterName = urlParams.get('inviter');
        const activityStatus = urlParams.get('status');
        
        if (activityStatus === 'ended') {
            return {
                state: 'S1.3',
                data: { reason: 'activity_ended' }
            };
        }
        
        if (hasInviteRef && inviterName) {
            return {
                state: 'S1.2',
                data: { 
                    inviteRef: hasInviteRef,
                    inviterName: decodeURIComponent(inviterName)
                }
            };
        }
        
        return {
            state: 'S1.1',
            data: {}
        };
    }

    // 获取邀请链接
    generateInviteLink(userId) {
        const user = this.users.find(u => u.id === userId);
        if (!user) return '';
        
        const baseUrl = window.location.origin + window.location.pathname;
        return `${baseUrl}?ref=${userId}&inviter=${encodeURIComponent(user.name)}`;
    }

    // 活动配置数据
    getActivityConfig() {
        return {
            name: "WhatsApp官方抽奖活动",
            description: "验证WhatsApp账号即可参与，邀请好友获得更多机会",
            startTime: "2025-01-20T00:00:00Z",
            endTime: "2025-10-01T18:00:00Z",
            rules: [
                "验证WhatsApp账号即可获得抽奖机会",
                "邀请好友可获得更多抽奖机会",  
                "奖品真实有效，公开透明抽奖",
                "中奖后将通过WhatsApp官方渠道通知"
            ],
            sponsor: {
                name: "WhatsApp官方抽奖工具",
                logo: "fa-whatsapp",
                website: "https://business.whatsapp.com/",
                verified: true
            },
            marketing: {
                invite_reward_codes: this.marketing.invite_reward_codes,
                initial_participants_base: this.marketing.initial_participants_base,
                banner_image_url: this.marketing.banner_image_url,
                marquee_messages: [
                    "xxx参与了抽奖",
                    "xx邀请了x个人"
                ]
            },
            business: {
                joinNumber: this.businessWhatsAppNumber,
                joinLink: this.businessWhatsAppNumber ? `https://wa.me/${this.businessWhatsAppNumber}` : ''
            }
        };
    }

    // 参与用：获取商业号
    getWhatsAppBusinessNumber() {
        return this.businessWhatsAppNumber || this.getActivityConfig()?.business?.joinNumber || '';
    }

    // 生成参与SESSION_ID
    generateSessionId() {
        const rnd = Math.random().toString(36).slice(2, 8).toUpperCase();
        return `SESS-${Date.now().toString(36).toUpperCase()}-${rnd}`;
    }

    // 构建唤起WhatsApp的链接
    getWhatsAppJoinUrl(sessionId) {
        const num = this.getWhatsAppBusinessNumber();
        const text = `我要参与-${sessionId}`;
        if (!num) return '';
        // wa.me 方案：移动端/桌面端均可回退到web
        return `https://wa.me/${num}?text=${encodeURIComponent(text)}`;
    }
}

// 全局数据模拟器实例
window.dataSimulator = new DataSimulator();

// 导出给其他模块使用
if (typeof module !== 'undefined' && module.exports) {
    module.exports = DataSimulator;
}
