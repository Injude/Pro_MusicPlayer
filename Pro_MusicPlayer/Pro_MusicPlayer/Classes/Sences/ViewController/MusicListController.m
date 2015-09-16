//
//  MusicListController.m
//  Pro_MusicPlayer
//
//  Created by lanou3g on 15/9/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MusicListController.h"
#import "MusicItemCell.h"
#import "MusicListHelper.h"
#import "MusicModle.h"
#import "MusicPlayingController.h"
#import "URLs.h"
#import "MBProgressHUD.h"

@interface MusicListController ()<UIWebViewDelegate>
//因为播放页面一直存在,所以做成一个属性直接放在列表页面
@property(nonatomic,strong)MusicPlayingController *playingController;

@end

@implementation MusicListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    self.title=@"奈文摩尔";
    [self.tableView registerNib:[UINib nibWithNibName:@"MusicitemCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
    [[MusicListHelper shareHelper]requstAllWithMusic:^{
        [self.tableView reloadData];
        
        
    }];
    
    
}

-(void)loadHUD{

    MBProgressHUD *HUD=[MBProgressHUD new];
    HUD=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    // Return the number of rows in the section.
    return [MusicListHelper shareHelper].musicArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicitemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    MusicModle *item=[[MusicListHelper shareHelper] modleWithIndex:indexPath.row];
    
    cell.modle=item;
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     //这个就是将播放页面显示出来
    self.playingController.index = indexPath.row;
    [self showDetailViewController:self.playingController sender:nil];


}

- (IBAction)show4playVC:(id)sender {
    
    [self showDetailViewController:self.playingController sender:nil];
    
    
}


- (MusicPlayingController *)playingController{


    if (_playingController == nil) {
        _playingController = [MusicPlayingController new];
    }
    return _playingController;

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
