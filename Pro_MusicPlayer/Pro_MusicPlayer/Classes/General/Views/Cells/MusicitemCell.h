//
//  MusicitemCell.h
//  Pro_MusicPlayer
//
//  Created by lanou3g on 15/9/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MusicModle; 
@interface MusicitemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image4music;

@property (weak, nonatomic) IBOutlet UILabel *txt4name;
@property (weak, nonatomic) IBOutlet UILabel *txt4singer;
@property(nonatomic,strong)MusicModle *modle;
@end
