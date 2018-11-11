//
//  Figura.m
//  Chocopaint
//
//  Created by Alumno on 12/12/16.
//  Copyright © 2016 Francisco Blázquez. All rights reserved.
//

#import "Figura.h"

@implementation Figura

@synthesize nombre,alto,ancho,grosor,origen,borde,relleno,tipo;

//Init desde la tabla de la ventana auxiliar
-(id)initFromTable:(NSString *) aNombre
              tipo:(NSNumber *) aTipo
              alto:(NSNumber *) aAlto
             ancho:(NSNumber *) aAncho
            grosor:(NSNumber *) aGrosor
            origen:(NSPoint) aOrigen
             borde:(NSColor *) aBorde
           relleno:(NSColor *) aRelleno{
    
    self = [super init];
    if(!self){
        
        return nil;
        
    }
    
    bz = [[NSBezierPath alloc]init];
    
    //Damos valores a los atributos
    self.nombre = aNombre;
    self.tipo = aTipo;
    self.alto = aAlto;
    self.ancho = aAncho;
    self.grosor = aGrosor;
    self.origen = aOrigen;
    [self setBorde: aBorde];
    [self setRelleno: aRelleno];
    
    return self;
    
}

//Init desde el mouse
-(id)initFromMouse:(NSNumber *) aTipo
            grosor:(NSNumber *) aGrosor
               fin:(NSPoint) aFin
            origen:(NSPoint) aOrigen{
    
    self = [super init];
    
    if(!self){
        
        return nil;
        
    }
    
    bz = [[NSBezierPath alloc]init];
    
    //Damos valores a los atributos
    self.nombre = @"mouseShape";
    self.tipo = aTipo;
    self.alto = @(aFin.y);
    self.ancho = @(aFin.x);
    self.grosor = aGrosor;
    self.origen = aOrigen;
    [self setBorde: [NSColor blackColor]];
    [self setRelleno: [NSColor redColor]];
    
    return self;
    
}


-(void) dibujarFiguraWithGraphicContext:(NSGraphicsContext *)ctx{
 
    [ctx saveGraphicsState]; //Se guarda el contexto grafico
    
    switch (self.tipo.integerValue) {
        case 0:
            //Linea
            [bz moveToPoint:origen];
            [bz lineToPoint:NSMakePoint([[self ancho]floatValue], [[self alto]floatValue])];
            break;
            
        case 1:
            //Rectangulo
            [bz appendBezierPathWithRect:NSMakeRect([self origen].x, [self origen].y, [[self ancho]floatValue], [[self alto]floatValue])];
            break;
            
        case 2:
            //Elipse
            [bz appendBezierPathWithOvalInRect:NSMakeRect([self origen].x, [self origen].y, [[self ancho]floatValue], [[self alto]floatValue])];
            break;
            
    }
    
    [bz setLineWidth:[[self grosor]floatValue]];
    [[self borde]setStroke];
    [[self relleno]setFill];
    [bz stroke];
    [bz fill];
    [ctx restoreGraphicsState]; //Se restaura el contexto grafico
    
}


@end
