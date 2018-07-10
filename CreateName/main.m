//
//  main.m
//  CreateName
//
//  Created by TozyZuo on 2018/6/25.
//  Copyright © 2018年 TozyZuo. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSInteger const NumberOfLastNameStrokes = 7;

dispatch_queue_t LocalWorkQueue = NULL, NetWorkQueue = NULL;

NSSet *WuGeDaJiSet;
NSSet *WuGeJiSet;
NSSet *WuGeBanJiSet;
NSSet *WuGeAllJiSet;

NSSet *SanCaiDaJiSet;
NSSet *SanCaiZhongJiSet;
NSSet *SanCaiJiSet;

NSSet *FiveElementsOriginatedSet;
NSSet *FiveElementsSecondaryOriginatedSet;
NSSet *FiveElementsEqualedSet;
NSSet *FiveElementsRestrictedSet;

typedef NS_ENUM(NSInteger, CNModelType) {
    CNModelTypeXiong,
    CNModelTypeDaJi     =   3,
    CNModelTypeJi       =   2,
    CNModelTypeBanJi    =   1,
};

@interface CNModel : NSObject
@property (nonatomic, assign) NSInteger X;
@property (nonatomic, assign) NSInteger A;
@property (nonatomic, assign) NSInteger B;
@property (nonatomic, assign) NSInteger tian;
@property (nonatomic, assign) NSInteger di;
@property (nonatomic, assign) NSInteger ren;
@property (nonatomic, assign) NSInteger wai;
@property (nonatomic, assign) NSInteger zong;
@property (nonatomic, assign) NSInteger sanCai;
@property (nonatomic, assign) NSInteger priority;
- (instancetype)initWithX:(NSInteger)X A:(NSInteger)A B:(NSInteger)B;
@end

@implementation CNModel

+ (void)load
{
#if 1
    // 百度百科
    // 大吉 1, 3, 7, 11, 17, 23, 24, 29, 31, 33, 41, 47, 52, 57, 61, 67, 77, 81,
    // 吉 13, 15, 16, 21, 35, 37, 39, 45, 48, 71, 72, 73, 75, 79,
    // 半吉 5, 6, 27, 30, 51,

    WuGeDaJiSet = [NSSet setWithObjects:@1, @3, @7, @11, @17, @23, @24, @29, @31, @33, @41, @47, @52, @57, @61, @67, @77, @81, nil];
    WuGeJiSet = [NSSet setWithObjects:@13, @15, @16, @21, @35, @37, @39, @45, @48, @71, @72, @73, @75, @79, nil];
    WuGeBanJiSet = [NSSet setWithObjects:@5, @6, @27, @30, @51, nil];
#else
    // 自筛
    // 大吉：3、5、11、13、15、21、23、24、31、41、47、48、52、63、65、67、68、81
    // 吉：6、16、33、37、45、57
    // 半吉：7、8、17、18、25、29、30、38、39、51、58、61
    
    WuGeDaJiSet = [NSSet setWithObjects:@3, @5, @11, @13, @15, @21, @23, @24, @31, @41, @47, @48, @52, @63, @65, @67, @68, @81, nil];
    WuGeJiSet = [NSSet setWithObjects:@6, @16, @33, @37, @45, @57, nil];
    WuGeBanJiSet = [NSSet setWithObjects:@7, @8, @17, @18, @25, @29, @30, @38, @39, @51, @58, @61, nil];
#endif

    NSMutableSet *mSet = [[NSMutableSet alloc] init];
    [mSet unionSet:WuGeDaJiSet];
    [mSet unionSet:WuGeJiSet];
    [mSet unionSet:WuGeBanJiSet];
    WuGeAllJiSet = mSet;

    // 大吉 111, 222, 113, 224, 115, 226, 131, 242, 135, 246, 191, 202, 197, 208, 199, 200, 311, 422, 313, 424, 315, 426, 331, 442, 335, 446, 353, 464, 355, 466, 357, 468, 531, 642, 533, 644, 535, 646, 553, 664, 555, 666, 557, 668, 575, 686, 577, 688, 579, 680, 753, 864, 755, 866, 757, 868, 775, 886, 791, 802, 897, 808, 911, 022, 913, 024, 915, 026, 919, 020, 975, 086, 979, 080, 991, 002, 997, 008,
    // 中吉 133, 244, 153, 264, 319, 420, 333, 444, 511, 622, 513, 624, 551, 662, 751, 862, 777, 888, 779, 880, 799, 800, 031, 042, 953, 064, 955, 066, 957, 068, 977, 088, 999, 000,
    // 吉 155, 266, 795, 806,

//    SanCaiDaJiSet = @[@111, @222, @113, @224, @115, @226, @131, @242, @135, @246, @191, @202, @197, @208, @199, @200, @311, @422, @313, @424, @315, @426, @331, @442, @335, @446, @353, @464, @355, @466, @357, @468, @531, @642, @533, @644, @535, @646, @553, @664, @555, @666, @557, @668, @575, @686, @577, @688, @579, @680, @753, @864, @755, @866, @757, @868, @775, @886, @791, @802, @897, @808, @911, @22, @913, @24, @915, @26, @919, @20, @975, @86, @979, @80, @991, @2, @997, @8];

//    SanCaiZhongJiSet = @[@133, @244, @153, @264, @319, @420, @333, @444, @511, @622, @513, @624, @551, @662, @751, @862, @777, @888, @779, @880, @799, @800, @31, @42, @953, @64, @955, @66, @957, @68, @977, @88, @999, @0];

//    SanCaiJiSet = @[@155, @266, @795, @806];

    SanCaiDaJiSet = [NSSet setWithObjects:@"木木火", @"金土金", @"土金水", @"火土土", @"火火木", @"木木土", @"水木木", @"金土火", @"金水木", @"水水木", @"木火土", @"金金土", @"金土土", @"木水水", @"水金土", @"火木火", @"木木木", @"水金水", @"土火火", @"木水木", @"火木土", @"土火土", @"金水金", @"土金金", @"木火木", @"土土金", @"水水金", @"火火土", @"水木火", @"火土金", @"土土火", @"水木土", @"木水金", @"火木木", @"土土土", @"土火木", @"土金土", @"火土火", @"水木水", nil];

    SanCaiZhongJiSet = [NSSet setWithObjects:@"土土木", @"火木水", @"金金金", @"水火木", @"土木木", @"金金水", @"水土金", @"水金金", @"火火火", @"水土土", @"木土火", @"水土火", @"金土木", @"金水水", @"水水水", @"木火火", @"土木火", nil];

    SanCaiJiSet = [NSSet setWithObjects:@"木土土", @"金水土", nil];

    // 生 木->火->土->金->水->木
    // 克 木->土->水->火->金->木
    FiveElementsOriginatedSet = [NSSet setWithObjects:@"木火", @"火土", @"土金", @"金水", @"水木", nil];
    FiveElementsSecondaryOriginatedSet = [NSSet setWithObjects:@"木水", @"水金", @"金土", @"土火", @"火木", nil];
    FiveElementsEqualedSet = [NSSet setWithObjects:@"金金", @"木木", @"水水", @"火火", @"土土", nil];
    FiveElementsRestrictedSet = [NSSet setWithObjects:@"木土", @"木金", @"火金", @"火水", @"土木", @"土水", @"金木", @"金火", @"水火", @"水土", nil];
}

- (instancetype)initWithX:(NSInteger)X A:(NSInteger)A B:(NSInteger)B
{
    if (self = [super init]) {
        self.X = X;
        self.A = A;
        self.B = B;
        self.tian = X + 1;
        self.di = A + B;
        self.ren = X + A;
        self.wai = B + 1;
        self.zong = X + A + B;

        self.sanCai = self.tian%10 * 100 + self.ren%10 * 10 + self.di%10;

        // 三才检测 天格+人格+地格
        CNModelType type = [self typeForSanCaiNumber:self.sanCai];
        switch (type) {
            case CNModelTypeDaJi:
            case CNModelTypeJi:
            case CNModelTypeBanJi:
                self.priority += type;
                break;
            default:
                return self;
        }

        // 成功运 人格+天格
        type = [self typeForFiveElementsA:self.ren B:self.tian];
        switch (type) {
            case CNModelTypeDaJi:
            case CNModelTypeJi:
            case CNModelTypeBanJi:
                self.priority += type;
                break;
            default:
                break;
        }

        // 基础运 人格+地格
        type = [self typeForFiveElementsA:self.ren B:self.di];
        switch (type) {
            case CNModelTypeDaJi:
            case CNModelTypeJi:
            case CNModelTypeBanJi:
                self.priority += type;
                break;
            default:
                break;
        }

        // 人际关系 人格+外格
        type = [self typeForFiveElementsA:self.ren B:self.wai];
        switch (type) {
            case CNModelTypeDaJi:
            case CNModelTypeJi:
            case CNModelTypeBanJi:
                self.priority += type;
                break;
            default:
                break;
        }

        // 五格检测
        NSArray *fourGeArray = @[@(self.di), @(self.ren), @(self.wai), @(self.zong)];

        // 过滤不吉利的五格数
        for (NSNumber *number in fourGeArray) {
            if (![WuGeAllJiSet containsObject:number]) {
                return nil;
            }
        }

        for (NSNumber *number in fourGeArray) {
            if ([WuGeDaJiSet containsObject:number]) {
                self.priority += CNModelTypeDaJi;
            }
        }

        for (NSNumber *number in fourGeArray) {
            if ([WuGeJiSet containsObject:number]) {
                self.priority += CNModelTypeJi;
            }
        }

        for (NSNumber *number in fourGeArray) {
            if ([WuGeBanJiSet containsObject:number]) {
                self.priority += CNModelTypeBanJi;
            }
        }
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%ldA + %ldB (优先级%ld)\n%@\n%@\n%@\n\n", self.A, self.B, self.priority, [self wuGeString], [self sanCaiString], [self luckString]];
}

#pragma mark Public

- (NSString *)fiveElementsStringForNumber:(NSInteger)number
{
    switch (number%10) {
        case 1:
        case 2:
            return @"木";
        case 3:
        case 4:
            return @"火";
        case 5:
        case 6:
            return @"土";
        case 7:
        case 8:
            return @"金";
        case 9:
        case 0:
            return @"水";
        default:
            return @"未知";
    }
}

#pragma mark 五格

- (NSString *)wuGeString
{
    return [NSString stringWithFormat:@"\t天 : (%@)%ld\n\t人 : (%@)%ld (%@)\n\t地 : (%@)%ld (%@)\n\t外 : (%@)%ld (%@)\n\t总 : (%@)%ld (%@)", [self fiveElementsStringForNumber:self.tian], self.tian, [self fiveElementsStringForNumber:self.ren], self.ren, [self typeStringForWuGeNumber:self.ren], [self fiveElementsStringForNumber:self.di], self.di, [self typeStringForWuGeNumber:self.di], [self fiveElementsStringForNumber:self.wai], self.wai, [self typeStringForWuGeNumber:self.wai], [self fiveElementsStringForNumber:self.zong], self.zong, [self typeStringForWuGeNumber:self.zong]];
}

- (NSString *)typeStringForWuGeNumber:(NSInteger)number
{
    if ([WuGeDaJiSet containsObject:@(number)]) {
        return @"大吉";
    } else if ([WuGeJiSet containsObject:@(number)]) {
        return @"吉";
    } else if ([WuGeBanJiSet containsObject:@(number)]) {
        return @"半吉";
    } else {
        return @"各种凶";
    }
}

#pragma mark 三才

- (NSString *)sanCaiString
{
    return [NSString stringWithFormat:@"\t三才(天人地) : %@ %03ld (%@)", [self sanCaiStringForSanCaiNumber:self.sanCai], self.sanCai, [self typeStringForSanCaiType:[self typeForSanCaiNumber:self.sanCai]]];
}

- (NSString *)sanCaiStringForSanCaiNumber:(NSInteger)number
{
    return [NSString stringWithFormat:@"%@%@%@", [self fiveElementsStringForNumber:self.sanCai / 100], [self fiveElementsStringForNumber:(self.sanCai / 10) % 10], [self fiveElementsStringForNumber:self.sanCai % 10]];
}

- (CNModelType)typeForSanCaiNumber:(NSInteger)number
{
    NSString *sanCaiString = [self sanCaiStringForSanCaiNumber:number];

    CNModelType sanCaiType = CNModelTypeXiong;
    if ([SanCaiDaJiSet containsObject:sanCaiString]) {
        sanCaiType = CNModelTypeDaJi;
    } else if ([SanCaiZhongJiSet containsObject:sanCaiString]) {
        sanCaiType = CNModelTypeJi;
    } else if ([SanCaiJiSet containsObject:sanCaiString]) {
        sanCaiType = CNModelTypeBanJi;
    }
    return sanCaiType;
}

- (NSString *)typeStringForSanCaiType:(CNModelType)type
{
    switch (type) {
        case CNModelTypeDaJi:
            return @"大吉";
        case CNModelTypeJi:
            return @"中吉";
        case CNModelTypeBanJi:
            return @"吉";
        default:
            return @"各种凶";
    }
}

#pragma mark 运势

- (NSString *)luckString
{
    return [NSString stringWithFormat:@"\t成功运(人天) : %@%@ (%@)\n\t基础运(人地) : %@%@ (%@)\n\t人际关系(人外) : %@%@ (%@)", [self fiveElementsStringForNumber:self.ren], [self fiveElementsStringForNumber:self.tian], [self typeStringForLuckType:[self typeForFiveElementsA:self.ren B:self.tian]], [self fiveElementsStringForNumber:self.ren], [self fiveElementsStringForNumber:self.di], [self typeStringForLuckType:[self typeForFiveElementsA:self.ren B:self.di]], [self fiveElementsStringForNumber:self.ren], [self fiveElementsStringForNumber:self.wai], [self typeStringForLuckType:[self typeForFiveElementsA:self.ren B:self.wai]]];
}

- (CNModelType)typeForFiveElementsA:(NSInteger)A B:(NSInteger)B
{
    NSString *fiveElementsString = [NSString stringWithFormat:@"%@%@", [self fiveElementsStringForNumber:A], [self fiveElementsStringForNumber:B]];
    if ([FiveElementsOriginatedSet containsObject:fiveElementsString]) {
        return CNModelTypeDaJi;
    } else if ([FiveElementsSecondaryOriginatedSet containsObject:fiveElementsString]) {
        return CNModelTypeJi;
    } else if ([FiveElementsEqualedSet containsObject:fiveElementsString]) {
        return CNModelTypeBanJi;
    } else {
        return CNModelTypeXiong;
    }
}

- (NSString *)typeStringForLuckType:(CNModelType)type
{
    switch (type) {
        case CNModelTypeDaJi:
            return @"大吉";
        case CNModelTypeJi:
            return @"吉";
        case CNModelTypeBanJi:
            return @"平";
        default:
            return @"各种凶";
    }
}

@end

NSUInteger LogTheBestCombinationWithNumberOfLastNameStrokes(NSInteger numberOfLastNameStrokes)
{
    // 中华起名网的，【并没有】按照这个数理来计算
    //    • 含有15  16  23  24  29  32  33  41  52等财运数，预示：多钱财、富贵、白手可获巨财。
    //    • 含有13  16  21  23  29  31  33  39等官运数，预示：智慧仁勇、立上位、能领导众人。
    //    • 含有3  5  6  11  13  15  16  23  24  25  31  32 33 45等吉祥数，预示：表示健全、幸福、名誉。
    //    • 含有7  8  17  29  37  41  47  48  57  58  67  68等后运数，预示：中年之后运气佳，家庭幸福、美满。
    //    • 含有7  8  17  18  25  27  28  37  47等刚强数，预示：性刚固执、意气用事。

    NSMutableArray *models = [[NSMutableArray alloc] init];

    for (int i = 1; i < 31; i++) {
        for (int j = 1; j < 31; j++) {
            CNModel *model = [[CNModel alloc] initWithX:numberOfLastNameStrokes A:i B:j];
            if (model.priority > 15 /* 15以下基本就带凶了 */) {
                [models addObject:model];
            }
        }
    }

    [models sortUsingComparator:^NSComparisonResult(CNModel *obj1, CNModel *obj2)
     {
         return obj1.priority > obj2.priority ? NSOrderedAscending : NSOrderedDescending;
     }];

    for (CNModel *model in models) {
        printf("%s", model.description.UTF8String);
    }

    return models.count;
}

void GetWordsFromOdictWithNumberOfStrokesCompletion(NSInteger numberOfStrokes, void (^completion)(NSSet *words))
{
    dispatch_async(NetWorkQueue, ^{

        printf("请求 zidian.odict.net 数据\n");

        [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://zidian.odict.net/zongbihua-%ld/", numberOfStrokes]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
          {
              NSString *str = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];

              NSMutableSet *set = [[NSMutableSet alloc] init];

              NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"target='_top'>[\\u4E00-\\u9FA5]</a>" options:0 error:nil];

              [regularExpression enumerateMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop)
               {
                   if (result) {
                       NSString *ts = [[str substringWithRange:result.range] substringWithRange:NSMakeRange(14, 1)];
                       [set addObject:ts];
                   }
               }];

              printf("zidian.odict.net 解析文字%ld个\n", set.count);

              if (completion) {
                  dispatch_async(LocalWorkQueue, ^{
                      completion(set);
                  });
              }
          }] resume];
    });
}

void GetWordsFromZdictWithNumberOfStrokesCompletion(NSInteger numberOfStrokes, NSInteger page, void (^completion)(NSSet *words))
{
    dispatch_async(NetWorkQueue, ^{

        static NSMutableSet *set;
        if (page == 1) {
            set = [[NSMutableSet alloc] init];
        }

        printf("请求 www.zdic.net 数据，第%ld页\n", page);

        NSString *URLString = [[NSString stringWithFormat:@"http://www.zdic.net/z/kxzd/zbh/bs/?kxbh=%ld|%ld", numberOfStrokes, page] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
        [request setValue:@"http://www.zdic.net/z/kxzd/zbh/" forHTTPHeaderField:@"Referer"];

        [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
          {
              NSString *str = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding].lowercaseString;

              NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"target=_blank>[\\u4E00-\\u9FA5]</a>" options:0 error:nil];

              __block NSUInteger count = 0;

              [regularExpression enumerateMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop)
               {
                   if (result) {
                       NSString *ts = [[str substringWithRange:result.range] substringWithRange:NSMakeRange(14, 1)];
                       [set addObject:ts];
                       count++;
                   }
               }];

              printf("www.zdic.net 第%ld页解析文字%ld个，共%ld个\n", page, count, set.count);

              if (![str containsString:@"下一頁"] || // 只有一页
                  [str containsString:@"atend"])    // 多页到最后一页
              {
                  printf("www.zdic.net 全部请求并解析完毕，共%ld个\n", set.count);
                  if (completion) {
                      dispatch_async(LocalWorkQueue, ^{
                          completion(set);
                      });
                  }
              } else {
                  usleep(500000);
                  GetWordsFromZdictWithNumberOfStrokesCompletion(numberOfStrokes, page + 1, completion);
              }
          }] resume];
    });
}

void SearchFiveElementsAndNumberOfStrokesForWordAndCompletion(NSString *word, void(^completion)(NSString *fiveElements, NSInteger numberOfStrokes))
{
    dispatch_async(NetWorkQueue, ^{

        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://cm.k366.com/chazidange.asp"]];
        request.HTTPMethod = @"POST";
        request.HTTPBody = [[NSString stringWithFormat:@"zi=%@&btnAdd=立刻显示", word] dataUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];

        [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
          {
              dispatch_async(NetWorkQueue, ^{

                  NSString *str = [[NSString alloc] initWithData:data encoding: CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
                  NSRange range = NSMakeRange([str rangeOfString:@"五行：</td><td bgcolor=ffffff align=\"center\">"].location + 42, 1);
                  if (range.location == NSNotFound) {

                  }
                  NSString *f = [str substringWithRange:range];
                  NSUInteger startLocation = [str rangeOfString:@"姓名学笔画：</td><td bgcolor=ffffff align=\"center\">"].location + 45;
                  NSUInteger endLocation = [str rangeOfString:@"<" options:0 range:NSMakeRange(startLocation, str.length - startLocation)].location;
                  NSInteger numberOfStrokes = [str substringWithRange:NSMakeRange(startLocation, endLocation - startLocation)].integerValue;
                  if (completion) {
                      completion(f, numberOfStrokes);
                  }
              });
          }] resume];
    });
}

void SearchWordsWithNumberOfStrokesAndOutputPathAndCompletion(NSInteger numberOfStrokesToCheck, NSString *outputPath)
{
    if (!LocalWorkQueue || !NetWorkQueue) {
        LocalWorkQueue = dispatch_queue_create("LocalWorkQueue", DISPATCH_QUEUE_SERIAL);
        NetWorkQueue = dispatch_queue_create("NetWorkQueue", DISPATCH_QUEUE_SERIAL);
    }

    outputPath = outputPath.stringByDeletingPathExtension;

    dispatch_semaphore_t workSemaphore = dispatch_semaphore_create(0);

    dispatch_async(LocalWorkQueue, ^{

        printf("开始查询康熙字典%ld笔画的字\n", numberOfStrokesToCheck);

        GetWordsFromOdictWithNumberOfStrokesCompletion(numberOfStrokesToCheck, ^(NSSet *oWords) {

            GetWordsFromZdictWithNumberOfStrokesCompletion(numberOfStrokesToCheck, 1, ^(NSSet *zWords) {

                NSMutableSet *allWords = oWords.mutableCopy;
                NSMutableSet *intersectWords = oWords.mutableCopy;
                [intersectWords intersectSet:zWords];
                [allWords unionSet:zWords];

                printf("全部请求完毕，相同字%ld个，共%ld个\n进行五行属性查询...\n", intersectWords.count, allWords.count);

                NSDictionary<NSString *, NSMutableSet *> *wordsDic = @{
                    @"金": [NSMutableSet set],
                    @"木": [NSMutableSet set],
                    @"水": [NSMutableSet set],
                    @"火": [NSMutableSet set],
                    @"土": [NSMutableSet set],
                };

                NSMutableSet *wrongWords = [NSMutableSet set];
                CGFloat total = (CGFloat)allWords.count;

                __block NSUInteger wrongStrokes = 0;
                __block NSUInteger progress = 0;

                dispatch_semaphore_t loopSemaphore = dispatch_semaphore_create(0);
                for (NSString *word in allWords) {
                    SearchFiveElementsAndNumberOfStrokesForWordAndCompletion(word, ^(NSString *fiveElements, NSInteger numberOfStrokes)
                    {
                        // NetworkQueue

                        if (numberOfStrokes == numberOfStrokesToCheck) {
                            NSMutableSet *set = wordsDic[fiveElements];
                            if (set) {
                                [set addObject:word];
                            } else {
                                NSLog(@"%@%@属性未找到", word, fiveElements);
                            }
                        } else {
                            if (numberOfStrokes) {
                                wrongStrokes++;
                            }
                            [wrongWords addObject:[NSString stringWithFormat:@"%@(%ld%@)", word, numberOfStrokes, fiveElements]];
                        }

                        printf("查询进度 %.2f%%\n", ++progress/total*100);

                        usleep(100000);
                        dispatch_semaphore_signal(loopSemaphore);
                    });
                    dispatch_semaphore_wait(loopSemaphore, DISPATCH_TIME_FOREVER);
                }

                printf("全部查询完毕，其中，金%ld个，木%ld个，水%ld个，火%ld个，土%ld个，错误笔画字数%ld个(一般由于网站返回的是字本身的笔画数，而非康熙字典笔画数)，未查询到属性%ld个\n", wordsDic[@"金"].count, wordsDic[@"木"].count, wordsDic[@"水"].count, wordsDic[@"火"].count, wordsDic[@"土"].count, wrongStrokes, wrongWords.count - wrongStrokes);

                if (![NSKeyedArchiver archiveRootObject:wordsDic toFile:[NSString stringWithFormat:@"%@/wordsDicBackup_%ld", outputPath, numberOfStrokesToCheck]]) {
                    NSLog(@"备份wordsDic失败，建议此处加断点手动备份");
                }

                printf("进行繁简转换...\n");

                NSMutableString *finalString = [[NSMutableString alloc] init];
                [wordsDic enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSSet *obj, BOOL * _Nonnull stop)
                 {
                     NSMutableString *str = [[NSMutableString alloc] initWithString:@""];
                     for (NSString *ts in obj) {
                         NSString *ss = [ts stringByApplyingTransform:@"Hant-Hans" reverse:NO];
                         if ([ss isEqualToString:ts]) {
                             [str appendFormat:@"%@     ", ts];
                         } else {
                             [str appendFormat:@"%@(%@) ", ss, ts];
                         }
                     }

                     [finalString appendFormat:@"%@:\n\n%@\n\n", key, str];
                 }];

                NSString *file = [NSString stringWithFormat:@"%@/words_%ld.txt", outputPath, numberOfStrokesToCheck];
                [finalString writeToFile:file atomically:NO encoding:NSUTF8StringEncoding error:nil];

                printf("转换完毕，结果保存在 %s\n", file.UTF8String);

                dispatch_semaphore_signal(workSemaphore);
            });
        });
    });

    dispatch_semaphore_wait(workSemaphore, DISPATCH_TIME_FOREVER);
}

// 只能查属性，不能查笔画，留着备用吧
void SearchFiveElementsForWordAndCompletion(NSString *word, void(^completion)(NSString *fiveElements))
{
    dispatch_async(NetWorkQueue, ^{
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://xh.5156edu.com/sowx.php"]];
        request.HTTPMethod = @"POST";
        request.HTTPBody = [[NSString stringWithFormat:@"f_key=%@&B1=查询", word] dataUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
        [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
          {
              NSString *str = [[NSString alloc] initWithData:data encoding: CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
              NSString *f = [str substringWithRange:NSMakeRange([str rangeOfString:@" 五行属性："].location + 6, 1)];
              if (completion) {
                  completion(f);
              }
          }] resume];
    });
}

int main(int argc, const char * argv[]) {

    LogTheBestCombinationWithNumberOfLastNameStrokes(NumberOfLastNameStrokes);

#warning 这里输入想要查询的笔画，比如给出组合 10A + 11B，输入10或11就可以了
//    SearchWordsWithNumberOfStrokesAndOutputPathAndCompletion(10, [@"~/Desktop" stringByExpandingTildeInPath]);

    return 0;
}
