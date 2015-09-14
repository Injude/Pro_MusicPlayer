//
//  MusicitemCell.m
//  Pro_MusicPlayer
//
//  Created by lanou3g on 15/9/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MusicitemCell.h"
#import "UIImageView+WebCache.h"
#import "MusicModle.h"

@implementation MusicitemCell



-(void)setModle:(MusicModle *)modle{

    self.txt4name.text=modle.name;
    self.txt4singer.text=modle.artists_name;
    [self.image4music sd_setImageWithURL:[NSURL URLWithString:modle.picUrl]];


}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
