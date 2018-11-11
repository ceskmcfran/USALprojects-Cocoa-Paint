//
//  Figura.h
//  Chocopaint
//
//  Created by Alumno on 12/12/16.
//  Copyright © 2016 Francisco Blázquez. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Figura : NSObject
{
    
    NSString * nombre;
    NSNumber * alto;
    NSNumber * ancho;
    NSNumber * grosor;
    NSPoint origen;
    NSColor * borde;
    NSColor * relleno;
    NSNumber * tipo; //0 para la linea, 1 para el rectangulo, 2 para la elipse
    
    NSBezierPath * bz;
    
    
}

@property(nonatomic, copy)NSString * nombre;
@property(nonatomic, copy)NSNumber * alto;
@property(nonatomic, copy)NSNumber * ancho;
@property(nonatomic, copy)NSNumber * grosor;
@property(nonatomic)NSPoint origen;
@property(nonatomic, copy)NSColor * borde;
@property(nonatomic, copy)NSColor * relleno;
@property(nonatomic, copy)NSNumber * tipo;

//Init desde la tabla
-(id)initFromTable:(NSString *) nombre
              tipo:(NSNumber *) tipo
              alto:(NSNumber *) alto
             ancho:(NSNumber *) ancho
            grosor:(NSNumber *) grosor
            origen:(NSPoint) origen
             borde:(NSColor *) borde
           relleno:(NSColor *) relleno;

//Init desde eventos del mouse
-(id)initFromMouse:(NSNumber *) aTipo
            grosor:(NSNumber *) aGrosor
               fin:(NSPoint) aFin
            origen:(NSPoint) aOrigen;

//Dibuja esta figura
-(void) dibujarFiguraWithGraphicContext:(NSGraphicsContext *)ctx;

@end
