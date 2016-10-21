# DJColorfulSlider
彩色渐变的slider


Useage:
    DJColorfulSlider *slider = [[DJColorfulSlider alloc]initWithFrame:CGRectMake(30, 400, 300, 70)];\n
    slider.locations = @[@(0),@(0.3),@(1)];\n
    slider.numberWords = @[@"我",@"是",@"代",@"胖"];\n
    slider.min = 123;\n
    slider.max = 456;\n
    [self.view addSubview:slider];\n
    [slider setUp];\n
    
    
