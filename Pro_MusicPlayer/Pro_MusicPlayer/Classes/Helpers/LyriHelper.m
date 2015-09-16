//
//  LyriHelper.m
//  Pro_MusicPlayer
//
//  Created by lanou3g on 15/9/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "LyriHelper.h"
#import "LyricModle.h"

@interface LyriHelper ()

{

    NSUInteger _index;

}

@property(nonatomic,strong)NSMutableArray*allLyricMutable;

@end

@implementation LyriHelper




+(LyriHelper*)sharedHelper{


    static LyriHelper *helper=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper=[LyriHelper new];
    });

    return helper;
}
//将lyricstring 转化为一个数组
- (void)initWithLyricString:(NSString *)lyricString{
    _index = -1;
    [self.allLyricMutable removeAllObjects];

   //在添加新的

    //先将字符串 根据换行符来划分
    NSArray *itemArray=[lyricString componentsSeparatedByString:@"\n"];
    for (NSString *itemString in itemArray) {
        //根据括号将时间和歌词分开
        NSArray *lyricArray=[itemString componentsSeparatedByString:@"]"];
        
        if ([lyricArray.firstObject length]<1) {
            return;
        }
        
        //取正确的歌词时间
        NSString *timestr=[lyricArray.firstObject substringFromIndex:1];
        //将时间的分和秒分开
        NSArray *timeArray=[timestr componentsSeparatedByString:@":"];
        //计算秒数
        float time = [timeArray.firstObject integerValue]*60+[timeArray.lastObject integerValue];
        //创建歌词对象
        LyricModle *lyric = [LyricModle lyricWithTime:time lyric:lyricArray.lastObject];
        
        [self.allLyricMutable addObject:lyric];
        NSLog(@"%@",_allLyricMutable);
        
    }
    
    


}

-(NSUInteger)indexOfTime:(float)time{

  //遍历数组中的元素
    for (int i = 0; i<_allLyricMutable.count; i++) {
        LyricModle *modle=_allLyricMutable[i];
        
        if (modle.time>=time) {
            _index=(i - 1 > 0 ? i - 1 : 0);
            //找到下标就退出
            break;
        }
        
    }

    return _index;
}


-(NSArray *)allLyric{

    return [self.allLyricMutable mutableCopy];


}

-(NSMutableArray *)allLyricMutable{


    if (_allLyricMutable == nil) {
        _allLyricMutable= [NSMutableArray new];
    }
    return _allLyricMutable;

}


@end
