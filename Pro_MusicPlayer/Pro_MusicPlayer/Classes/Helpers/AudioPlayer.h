//
//  AudioPlayer.h
//  Pro_MusicPlayer
//
//  Created by lanou3g on 15/9/15.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AudioPlayer;
@protocol AudioPlayerDelegate <NSObject>

//再播放中每秒都执行的事件
- (void)adioplayerPlayWith:(AudioPlayer *)audioplayer Progress:(float)progress;
//当一首歌曲播放完成之后只需这个事件
- (void)audioplayerDidFinishItem:(AudioPlayer *)audioplayer;
@end



@interface AudioPlayer : NSObject
@property(nonatomic,assign)id<AudioPlayerDelegate>delegate;
@property(nonatomic,assign)BOOL  isPlaying;
+ (AudioPlayer *)sharedPlayer;
- (void)setPrepareMusicWithURL:(NSString *)url;
-(void)play;
-(void)pause;
- (void)seekToTime:(float)time;
@end
