//
//  MyGLKViewController.m
//  LearnOpenGL
//
//  Created by MacHD on 2019/7/22.
//  Copyright © 2019 FDK. All rights reserved.
//

#import "MyGLKViewController.h"
// Vertex 定点的意思
typedef struct{
    GLKVector3 positionCoords;
    GLKVector2 textureCoords; // 纹理
}SceneVertex;
//矩形的六个顶点
static const SceneVertex vertices[] = {
    {{1, -1, 0.0f,},{1.0f,0.0f}}, //右下
    {{1, 1,  0.0f},{1.0f,1.0f}}, //右上
    {{-1, 1, 0.0f},{0.0f,1.0f}}, //左上
    
    {{1, -1, 0.0f},{1.0f,0.0f}}, //右下
    {{-1, 1, 0.0f},{0.0f,1.0f}}, //左上
    {{-1, -1, 0.0f},{0.0f,0.0f}}, //左下
};
@interface MyGLKViewController(){
    GLuint  vertextBufferID;
}
@property (nonatomic,strong) GLKBaseEffect *baseEffect;
@end
@implementation MyGLKViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    GLKView *view = (GLKView *)self.view;
    view.context = [[EAGLContext alloc]initWithAPI: kEAGLRenderingAPIOpenGLES2];
    //设置当前上下文
    [EAGLContext setCurrentContext:view.context];
    
    self.baseEffect = [[GLKBaseEffect alloc]init];
    self.baseEffect.useConstantColor = GL_TRUE;
    self.baseEffect.constantColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
    [self getImageCef];
    [self filterVertextArray];
}
-(void)getImageCef{
     CGImageRef imageRef = [[UIImage imageNamed:@"weixin"] CGImage];
    
      //GLKTextureInfo封装了纹理缓存的信息，包括是否包含MIP贴图
     NSDictionary* options = [NSDictionary dictionaryWithObjectsAndKeys:@(1), GLKTextureLoaderOriginBottomLeft, nil];
    GLKTextureInfo * textureInfo =[GLKTextureLoader textureWithCGImage:imageRef options:options error:NULL ];
    self.baseEffect.texture2d0.name = textureInfo.name;
    self.baseEffect.texture2d0.target = textureInfo.target;
    
}
-(void)filterVertextArray{
    glGenBuffers(1, &vertextBufferID);
    glBindBuffer(GL_ARRAY_BUFFER, vertextBufferID);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), NULL + offsetof(SceneVertex, positionCoords));
    
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0); //纹理
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), NULL + offsetof(SceneVertex, textureCoords));
    
}
-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    
    //清除背景色
    glClearColor(0.0f,0.0f,0.0f,1.0f);
    glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
    [self.baseEffect prepareToDraw];
    glDrawArrays(GL_TRIANGLES, 0, 6);
    
}
-(void)dealloc{
    GLKView *view = (GLKView *)self.view;
    [EAGLContext setCurrentContext:view.context];
    if ( 0 != vertextBufferID) {
        glDeleteBuffers(1,
                        &vertextBufferID);
        vertextBufferID = 0;
    }
    [EAGLContext setCurrentContext:nil];
    NSLog(@"%@Dealloc",NSStringFromClass([self class]));
}


@end
