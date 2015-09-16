//
//  LyricModle.m
//  Pro_MusicPlayer
//
//  Created by lanou3g on 15/9/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "LyricModle.h"

@implementation LyricModle

- (instancetype)initWithTime:(float)time lyric:(NSString *)lyricString{

    if (self=[super init]) {
        self.time=time;
        self.lyric=lyricString;
    }
    return self;
}

+(instancetype)lyricWithTime:(float)time lyric:(NSString *)lyric{

    return [[self alloc]initWithTime:time lyric:lyric];



}
@end
