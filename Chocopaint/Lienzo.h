//
//  Lienzo.h
//  Chocopaint
//
//  Created by Alumno on 14/12/16.
//  Copyright © 2016 Francisco Blázquez. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class MainMenuController;

@interface Lienzo : NSView{
    
    IBOutlet MainMenuController * mc;
    IBOutlet NSTextField * coorMouse;
    NSTrackingArea * trackingArea;
    NSBezierPath * bzMouse;
    NSPoint principio, fin;
}

- (id)initWithCoder:(NSCoder *)coder; //Init
- (void)drawRect:(NSRect)dirtyRect; //Añade el contexto y fondo
- (void)handleLienzoDibuja:(NSNotification *)aNotificacion; //Handler para dibujar

- (void)viewDidMoveToWindow;//Area de eventos de mouse
- (void)mouseMoved:(NSEvent *)theEvent;//Movimiento del mouse por el lienzo
- (void)mouseDown:(NSEvent *)theEvent; //Pulsacion del mouse
- (void)mouseDragged:(NSEvent *)theEvent; //Arrastre del mouse
- (void)mouseUp:(NSEvent *)theEvent; //Despulsacion del mouse

@end
