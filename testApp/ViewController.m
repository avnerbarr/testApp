//
//  ViewController.m
//  testApp
//
//  Created by Avner Barr on 10/16/13.
//  Copyright (c) 2013 Avner Barr. All rights reserved.
//

#import "ViewController.h"

@interface Cell : UICollectionViewCell

@end

@implementation Cell

-(void)prepareForReuse
{
    NSLog(@"Prepare For Reuse");
}

-(void)dealloc
{
    NSLog(@"Dealloc");
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    NSLog(@"init");
    return self;
}
@end

@interface ViewController () <UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    [self.view addSubview:self.collectionView];
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[Cell class] forCellWithReuseIdentifier:@"a"];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100000;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
UICollectionViewCell *cell =    [collectionView dequeueReusableCellWithReuseIdentifier:@"a" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

@end
