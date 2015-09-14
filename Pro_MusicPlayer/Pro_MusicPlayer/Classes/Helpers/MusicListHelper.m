//
//  MusicListHelper.m
//  Pro_MusicPlayer
//
//  Created by lanou3g on 15/9/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MusicListHelper.h"
#import "MusicModle.h"





@implementation MusicListHelper

//单例
+(MusicListHelper *)shareHelper{

    static MusicListHelper *helper=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper=[MusicListHelper new];
        
    });

    return helper;

}

//数据请求
-(void)requstAllWithMusic:(void (^)())result{

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *array=[NSArray arrayWithContentsOfURL:[NSURL URLWithString:kMusicList]];
        
        for (NSDictionary *dict in array) {
            
            MusicModle *modle=[MusicModle new];
            [modle setValuesForKeysWithDictionary:dict];
            [self.allMusicMutable addObject:modle];
           // NSLog(@"---%@",_allMusicMutable);
                  
                  
                  }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            result();
        });
        
        
    });



}
- (MusicModle *)modleWithIndex:(NSInteger)index{
    return self.allMusicMutable[index];


}

#pragma mark 懒加载
-(NSMutableArray *)allMusicMutable{

    if (_allMusicMutable == nil) {
        _allMusicMutable=[NSMutableArray array];
    }
    return _allMusicMutable;
}

-(NSArray *)musicArray{

    return [_allMusicMutable mutableCopy];

}

@end
