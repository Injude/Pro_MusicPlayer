//
//  LyricModle.h
//  Pro_MusicPlayer
//
//  Created by lanou3g on 15/9/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LyricModle : NSObject

//歌词时间
@property(nonatomic,assign)float time;
@property(nonatomic,strong)NSString *lyric;

- (instancetype)initWithTime:(float)time lyric:(NSString *)lyricString;
+ (instancetype)lyricWithTime:(float)time lyric:(NSString *)lyric;

@end
