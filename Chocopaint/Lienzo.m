//
//  Lienzo.m
//  Chocopaint
//
//  Created by Alumno on 14/12/16.
//  Copyright © 2016 Francisco Blázquez. All rights reserved.
//

#import "Lienzo.h"
#import "MainMenuController.h"
#import "Figura.h"

extern NSString * LienzoNotificacion;
extern NSString * ETPanelDibujaFiguraNotification;

@implementation Lienzo

//Init
- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if(self){
        
        //Se recoge la notificacion para dibujar
        NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
        
        [nc addObserver:self
               selector:@selector(handleLienzoDibuja:)
                   name:LienzoNotificacion
                 object:nil];
        
    }
    
    return self;
}

//Añade el contexto y fondo
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    NSGraphicsContext * ctx = [NSGraphicsContext currentContext];
    //Fondo blanco al lienzo
    [[NSColor whiteColor] set];
    [NSBezierPath fillRect:[self bounds]];
    
    [mc dibujarFigurasWithGraphicContext:ctx];
    
    //Para el bezier del mouse
    if(bzMouse != nil){
        
        [ctx saveGraphicsState]; //Se guarda el contexto grafico
        
        [bzMouse moveToPoint:principio];
        [bzMouse lineToPoint:fin];
        
        [bzMouse setLineWidth:2];
        [[NSColor blackColor]setStroke];
        [bzMouse stroke];
        [ctx restoreGraphicsState]; //Se restaura el contexto grafico
        
    }
}

//Handler para dibujar en el lienzo
- (void)handleLienzoDibuja:(NSNotification *)aNotificacion{
 
    [self setNeedsDisplay:YES];
    
}

//Area de eventos de mouse
- (void)viewDidMoveToWindow {
    
    trackingArea = [[NSTrackingArea alloc] initWithRect:self.bounds
                                                options: (NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveAlways )
                                                  owner:self userInfo:nil];
    [self addTrackingArea:trackingArea];
}

//Movimiento del mouse por el lienzo
- (void)mouseMoved:(NSEvent *)theEvent {
    
    NSPoint eyeCenter = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    
    [coorMouse setStringValue:[NSString stringWithFormat:@"( %3.2f , %3.2f )", eyeCenter.x, eyeCenter.y]];
    
}

//Pulsacion del mouse
- (void)mouseDown:(NSEvent *)theEvent{
    
    bzMouse = [[NSBezierPath alloc]init];
    principio = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    
    
}

//Arrastre del mouse
- (void)mouseDragged:(NSEvent *)theEvent{
    
    
    fin = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    
}

//Despulsacion del mouse
- (void)mouseUp:(NSEvent *)theEvent{
    
    Figura * fig = [[Figura alloc] initFromMouse:@(0) grosor:@(2) fin:fin origen:principio];
    
    //Se manda la figura al centro de notificaciones
    NSDictionary * notificationInfo = [NSDictionary dictionaryWithObject:fig
                                                                  forKey:@"añadirFigura"];
    
    NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:ETPanelDibujaFiguraNotification
                      object:self
                    userInfo:notificationInfo];

    fig = nil;
    bzMouse = nil;
    
}

@end
