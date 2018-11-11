//
//  MainMenuController.m
//  Chocopaint
//
//  Created by Alumno on 12/12/16.
//  Copyright © 2016 Francisco Blázquez. All rights reserved.
//

#import "MainMenuController.h"
#import "ETPanelController.h"
#import "Figura.h"

extern NSString * ETPanelDibujaFiguraNotification;
NSString * LienzoNotificacion = @"LienzoNotificacion";

@implementation MainMenuController

//Init
-(id)init{
    
    self = [super init];
    
    if(!self){
        
        return nil;
        
    }
    
    arrayFiguras = [[NSMutableArray alloc] init];
    
    //Recogemos la notificacion que manda el panel
    NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self
           selector:@selector(handlePanelDibuja:)
               name:ETPanelDibujaFiguraNotification
             object:nil];
    
    return self;
    
}

//Handler para añadir la figura
-(void) handlePanelDibuja:(NSNotification *)aNotificacion{

    NSDictionary * notificationInfo = [aNotificacion userInfo];
    Figura * f = [notificationInfo objectForKey:@"añadirFigura"];
    NSNumber * indice = [notificationInfo objectForKey:@"eliminarFigura"];
    Figura * modf = [notificationInfo objectForKey:@"modificarFiguraFigura"];
    NSNumber * modIndice = [notificationInfo objectForKey:@"modificarFiguraIndex"];
    
    //Si hay una figura es que se quiere añadir
    if(f != nil){
        
        //Añadimos al array la figura
        [arrayFiguras addObject:f];
        
    }
    if(indice != nil){
        
        //Eliminamos la figura del array
        [arrayFiguras removeObjectAtIndex:[indice integerValue]];
    
    }
    if((modf != nil)&&(modIndice != nil)){

        [arrayFiguras replaceObjectAtIndex:[modIndice integerValue] withObject:modf];
        
    }
    
    //Se postea notificacion para el lienzo y para la tabla del panel
    NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:LienzoNotificacion
                      object:self];
    
}

//Muestra el panel
-(IBAction)showPanel:(id)sender{
    
    if (!panel) {
        panel = [[ETPanelController alloc]initWithArray:arrayFiguras];
    }
    
    [panel showWindow:self];
    
}

//Termina la app
-(BOOL)windowShouldClose:(id)sender{
    [NSApp terminate:self];
    return YES;
}

//Dibuja el contenido del array de figuras
-(void) dibujarFigurasWithGraphicContext:(NSGraphicsContext *)ctx{
    
    for(Figura *f in arrayFiguras){
        
        [f dibujarFiguraWithGraphicContext:ctx];
        
    }
    
}

@end
