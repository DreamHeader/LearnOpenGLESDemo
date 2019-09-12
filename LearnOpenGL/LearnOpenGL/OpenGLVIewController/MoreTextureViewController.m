//
//  MoreTextureViewController.m
//  LearnOpenGL
//
//  Created by MacHD on 2019/7/23.
//  Copyright © 2019 FDK. All rights reserved.
//

#import "MoreTextureViewController.h"

// 定点数据
typedef struct{
    GLKVector3 positionCoords;
    GLKVector2 textureCoord;
    
}SceneVertex;
static SceneVertex vertices[] = {
    {{-0.5f, -0.5f, 0.0f}, {0.0f, 0.0f}}, // lower left corner
    {{ 0.5f, -0.5f, 0.0f}, {1.0f, 0.0f}}, // lower right corner
    {{-0.5f,  0.5f, 0.0f}, {0.0f, 1.0f}}, // upper left corner
};
//默认顶点 -- 用于关闭动画时候恢复默认顶点
static const SceneVertex defaultVertices[] =
{
    {{-0.5f, -0.5f, 0.0f}, {0.0f, 0.0f}},
    {{ 0.5f, -0.5f, 0.0f}, {1.0f, 0.0f}},
    {{-0.5f,  0.5f, 0.0f}, {0.0f, 1.0f}},
};
//move结构体 用于动画，各个坐标的变换动画效果
static GLKVector3 movementVectors[3] = {
    {-0.02f,  -0.01f, 0.0f},
    {0.01f,  -0.005f, 0.0f},
    {-0.01f,   0.01f, 0.0f},
};

@interface MoreTextureViewController (){
    GLuint vertextBufferID;
}
@property (nonatomic,strong)GLKBaseEffect *baseEffect;
//是否使用线性过滤器
@property (nonatomic,assign)BOOL shouldUseLineFilter;
//是否开启动画
@property (nonatomic,assign)BOOL shouldAnimate;
//是否重复纹理
@property (nonatomic,assign)BOOL shouldRepeatTexture;
//顶点s坐标的offset
@property (nonatomic,assign)GLfloat sCoordinateOffset;
@end

@implementation MoreTextureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.preferredFramesPerSecond = 60;
    self.shouldAnimate = YES;
    self.shouldRepeatTexture = YES;
    self.shouldUseLineFilter = NO;
     GLKView *view = (GLKView *)self.view;
    view.context = [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:view.context];
    self.baseEffect = [[GLKBaseEffect alloc]init];
    self.baseEffect.useConstantColor = GL_TRUE;
    self.baseEffect.constantColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    [self loadVertexBuffer];
    [self loadTexture];
    
    
    
    // Do any additional setup after loading the view.
}
-(void)loadVertexBuffer{
    glGenBuffers(1, &vertextBufferID);
    glBindBuffer(GL_ARRAY_BUFFER, vertextBufferID);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_DYNAMIC_DRAW);
}
-(void)loadTexture{
  // 到现在为止 还是不太明白 glkTextureINfo 是干什么作用 只知道他是处理了Shader语言
    CGImageRef imageRef = [[UIImage imageNamed:@"weixin"] CGImage];
    GLKTextureInfo * textureINfo = [GLKTextureLoader textureWithCGImage:imageRef options:nil error:NULL];
    self.baseEffect.texture2d0.name = textureINfo.name;
    self.baseEffect.texture2d0.target = textureINfo.target;
}
-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glClear(GL_COLOR_BUFFER_BIT);
    [self.baseEffect prepareToDraw];
    glBindBuffer(GL_ARRAY_BUFFER, vertextBufferID);
    
    //设置定点数据
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), NULL + offsetof(SceneVertex, positionCoords));
    
    //设置纹理
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), NULL + offsetof(SceneVertex,textureCoord));
    
    glDrawArrays(GL_TRIANGLES, 0,3);
}
-(void)update{
    
    
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
