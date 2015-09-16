//
//  LyriHelper.h
//  Pro_MusicPlayer
//
//  Created by lanou3g on 15/9/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LyriHelper : NSObject



+ (LyriHelper*)sharedHelper;

- (void)initWithLyricString:(NSString *)lyricString;

//外部访问歌词数组
-(NSArray *)allLyric;

//根据时间返回当前播放歌词在数组中的位置
-(NSUInteger)indexOfTime:(float)time;


@end
