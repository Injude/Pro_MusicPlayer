//
//  MusicPlayingController.m
//  Pro_MusicPlayer
//
//  Created by lanou3g on 15/9/15.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MusicPlayingController.h"
#import "MusicModle.h"
#import "MusicListHelper.h"
#import "UIImageView+WebCache.h"
#import "AudioPlayer.h"
#import "LyriHelper.h"
#import "LyricModle.h"
@interface MusicPlayingController ()<AudioPlayerDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UINavigationBar *navebar;

//当前播放音乐的模型
@property(nonatomic,strong)MusicModle *currentModel;

@property (weak, nonatomic) IBOutlet UIImageView *img4Musicpic;
//当前正在播放的索引
@property(nonatomic,assign)NSInteger currentIndex;

@property (weak, nonatomic) IBOutlet UILabel *txt4playertime;

@property (weak, nonatomic) IBOutlet UILabel *txt4lasttime;


@property (weak, nonatomic) IBOutlet UISlider *slider4time;

@property (weak, nonatomic) IBOutlet UITableView *tableview4Lyric;

@end

@implementation MusicPlayingController

//因为这个页面要一直存在,所以使用单例
+(MusicPlayingController *)shareController{

    static MusicPlayingController *playeingcontrller=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        playeingcontrller = [MusicPlayingController new];
    });

    return playeingcontrller;
}

//因为这个控制器实际上存在SB上,所以要重写这个方法

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{

    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        MusicPlayingController *playing=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"playvc"];
        self = playing;
        _currentIndex=-1;
    }

    return self;
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    //[self updateUI];
    //如果要播放的音乐和当前播放的音乐是一样的,就直接返回,下面的代码不执行了
    if (_index == _currentIndex) {
        return;
    }
    _currentIndex=_index;
    
    [self startPlay];

}

//暂停或者播放
- (IBAction)startOrpuase:(id)sender {
    
    UIButton *btn=(UIButton *)sender;
    if ([AudioPlayer sharedPlayer].isPlaying) {
        [[AudioPlayer sharedPlayer] pause];
        [btn setTitle:@"播放" forState:UIControlStateNormal];
    }else{
    
        [[AudioPlayer sharedPlayer] play];
        [btn setTitle:@"暂停" forState:UIControlStateNormal];
    
    }
    
    
}

//上一首歌
- (IBAction)qianyishou:(id)sender {
    
    _currentIndex--;
    if (_currentIndex<0) {
        _currentIndex=[MusicListHelper shareHelper].musicArray.count-1;
    }
    
    [self startPlay];
}

//下一首
- (IBAction)next:(id)sender {
    
    _currentIndex++;
    if (_currentIndex >= [MusicListHelper shareHelper].musicArray.count) {
        _currentIndex = 0;
    }
    
    
    [self startPlay];
}



//返回页面按钮
- (IBAction)dis4muList:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.img4Musicpic.layer.masksToBounds = YES;
    self.img4Musicpic.layer.cornerRadius = 100;
    [self.slider4time addTarget:self action:@selector(timeSliderAction:) forControlEvents:UIControlEventValueChanged];
    self.tableview4Lyric.dataSource=self;
    
    //注册cell
    [self.tableview4Lyric registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -公开方法
- (void)startPlay{

    [self updateUI];
    
    [[AudioPlayer sharedPlayer] setPrepareMusicWithURL:self.currentModel.mp3Url];
    [AudioPlayer sharedPlayer].delegate=self;
    [[LyriHelper sharedHelper] initWithLyricString:self.currentModel.lyric];
    [self.tableview4Lyric reloadData];

}

#pragma mark -私有方法
-(void )updateUI{

    //显示每首歌上的歌曲名
    for (UINavigationItem *item in self.navebar.items) {
        item.title = self.currentModel.name;
    }
    
  //如果换个的话,就让图片重新归位
    self.img4Musicpic.transform  = CGAffineTransformMakeRotation(0);
  //可以根据获取到当前播放的音乐model 更新UI
    [self.img4Musicpic sd_setImageWithURL:[NSURL URLWithString:self.currentModel.picUrl]];
    //更新slidr
    //改变进度条的最大值
    self.slider4time.maximumValue = [self.currentModel.duration floatValue]/1000;



}

-(void)timeSliderAction:(UISlider *)sender{

    [[AudioPlayer sharedPlayer] seekToTime:sender.value];

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [LyriHelper sharedHelper].allLyric.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    LyricModle *modle=[LyriHelper sharedHelper].allLyric[indexPath.row];
    cell.textLabel.text = modle.lyric;
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    cell.textLabel.font=[UIFont systemFontOfSize:14];
    return cell;
   
}




#pragma mark -AudioPlayerDelegate
//回调时间:progress 当前播放的秒数

- (void)adioplayerPlayWith:(AudioPlayer *)audioplayer Progress:(float)progress{

     //旋转图片
    self.img4Musicpic.transform = CGAffineTransformRotate(self.img4Musicpic.transform, M_PI/100);
    
    //更新时间
    //已经播放时间
    int minutes = (int)progress/60;
    int seconds = (int)progress % 60;
    float lastTime = [_currentModel.duration floatValue]/1000 - progress;
    //剩余时间
    int minutes2 = (int)lastTime/60;
    int seconds2 = (int)lastTime % 60;
    
    self.txt4playertime.text=[NSString stringWithFormat:@"%d:%d",minutes,seconds];
    self.txt4lasttime.text = [NSString stringWithFormat:@"%d:%d",minutes2,seconds2];
    //更新进度条
    self.slider4time.value = progress;
    
    
    
    
    
    //滑动到哪一行不确定
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[[LyriHelper sharedHelper] indexOfTime:progress] inSection:0];
    [self.tableview4Lyric selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];

}


-(void)audioplayerDidFinishItem:(AudioPlayer *)audioplayer{

    [self next:nil];


}




//重写get方法
-(MusicModle *)currentModel{

    _currentModel=[[MusicListHelper shareHelper] modleWithIndex:_currentIndex];
    return _currentModel;


}


@end
