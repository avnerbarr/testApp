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
static int i;
+(void)count:(int)delta
{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        i = 0;
    });
    i+=delta;
    NSLog(@"i = %d",i);
}
-(void)prepareForReuse
{
    [[self class] count:-1];
    NSLog(@"Prepare For Reuse");
}

-(void)dealloc
{

    NSLog(@"Dealloc");
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [[self class] count:1];
    NSLog(@"init");
    return self;
}
@end

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableSet *collectionViewCells;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    [self.view addSubview:self.collectionView];
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[Cell class] forCellWithReuseIdentifier:@"a"];
    self.collectionViewCells = [NSMutableSet new];

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
    Cell *c = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"a" forIndexPath:indexPath];
    c.backgroundColor = [UIColor redColor];
    return c;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(60, 60);
}

@end
