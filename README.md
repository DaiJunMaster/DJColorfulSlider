# DJColorfulSlider
彩色渐变的slider


Useage:
    DJColorfulSlider *slider = [[DJColorfulSlider alloc]initWithFrame:CGRectMake(30, 400, 300, 70)];
    slider.locations = @[@(0),@(0.3),@(1)];
    slider.numberWords = @[@"我",@"是",@"代",@"胖"];
    slider.min = 123;
    slider.max = 456;
    [self.view addSubview:slider];
    [slider setUp];
    
    
