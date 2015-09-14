//
//  MusicListHelper.h
//  Pro_MusicPlayer
//
//  Created by lanou3g on 15/9/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MusicModle;
@interface MusicListHelper : NSObject
@property (nonatomic,strong) NSMutableArray * allMusicMutable;

@property(nonatomic,strong)NSArray *musicArray;
+(MusicListHelper *)shareHelper;

/**
 *  数据请求
 *
 *  @param requst <#requst description#>
 */
-(void)requstAllWithMusic:(void(^)())result;
- (MusicModle *)modleWithIndex:(NSInteger)index;
@end
